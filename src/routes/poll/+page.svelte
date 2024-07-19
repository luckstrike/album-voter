<script lang="ts">
    import MaterialSymbolsSearch from '~icons/material-symbols/search';
    import { debounce } from 'lodash-es';
	import { onMount } from 'svelte';

    let albumSearch: string;
    let isSearching: boolean = false;
    let showDropdown: boolean = false;
    let searchResults: any[] = [];
    let error: string | null = null;

    const MAX_DISPLAYED_ALBUMS: number = 5;

    const handleInput = debounce(async () => {
        if (albumSearch.length > 2) {
            const data = await handleSearch(albumSearch);
            searchResults = data;
            showDropdown = true;
        } else {
            searchResults = [];
            showDropdown = false;
        }
    }, 300);

    function removeDuplicates(albums: any[]): any[] {
        const uniqueAlbums = new Map();

        return albums.filter(album => {
            const duplicate = uniqueAlbums.has(album.name);

            if (!duplicate) uniqueAlbums.set(album.name, true);
            return !duplicate;
        })
    }

    async function handleSearch(searchQuery: string) {
        try {
            const response = await fetch('/api/spotify', {
                method: 'POST',
                body: JSON.stringify({ query: searchQuery }),
                headers: {
                'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            const data = await response.json();

            /// Returning only the list of albums
            const filteredAlbums = removeDuplicates(
                data.albums.items
                .filter((result: any) => result.album_type === 'album'))
                .slice(0, MAX_DISPLAYED_ALBUMS);

            return filteredAlbums;

        } catch (err) {
            error = err.message;
        } finally {
            isSearching = false;
        }
    }

    function selectResult(result: any) {
        albumSearch = result.name;
        showDropdown = false;
    }

    onMount(() => {
        document.addEventListener('click', (event: MouseEvent) => {
            const target = event.target as HTMLElement;
            if (!target.closest('.search-container')) {
                showDropdown = false;
            }
        });
    });

</script>

<div class="flex flex-col flex-grow text-white bg-gray-800 p-4 items-center">
    <div class="text-4xl font-bold bg-gradient-to-r from-blue-500 to-pink-700 inline-block text-transparent bg-clip-text leading-tight">
        Create a Poll
    </div>
    <div class="flex flex-col items-center w-1/3">
        <div class="flex flex-row text-black bg-white rounded-lg w-full mt-4 items-center">
            <div class="p-1 pl-2">
                <MaterialSymbolsSearch/>
            </div>
            <input 
                bind:value={albumSearch}
                on:input={handleInput}
                class="w-full focus:outline-none rounded-lg focus:ring-0 pt-2 pb-2 pl-1 pr-2"
                type="search" 
                placeholder="Search..."
            />
        </div>
        {#if showDropdown && searchResults.length > 0}
            <div class="w-[100%] text-black bg-white border border-gray-300 rounded-lg shadow-lg mt-1">
                {#each searchResults as result}
                    <div 
                        class="p-2 hover:bg-gray-100 cursor-pointer"
                        on:click={() => selectResult(result)}
                    >
                        {result.name}
                    </div>
                {/each}
            </div>
        {/if}
    </div>
    {#if error}
        <div class="text-red-500 mt-2">{error}</div>
    {/if}
</div>