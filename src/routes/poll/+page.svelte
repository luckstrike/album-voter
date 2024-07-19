<script lang="ts">
    import MaterialSymbolsSearch from '~icons/material-symbols/search';
    import { debounce } from 'lodash-es';
	import { onMount } from 'svelte';

    let albumSearch: string;
    let isSearching: boolean = false;
    let showDropdown: boolean = false;
    let searchResults: any[] = [];
    let error: string | null = null;

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
            const filteredAlbums = data.albums.items.filter((result: any) => {
                return result.album_type === 'album';
            });

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
    <div class="relative w-1/3 search-container">
        <div class="flex flex-row text-black bg-white rounded-lg m-4 pt-1 items-center">
            <div class="p-1 pl-2 pr-2">
                <MaterialSymbolsSearch/>
            </div>
            <input 
                bind:value={albumSearch}
                on:input={handleInput}
                class="w-full focus:outline-none focus:ring-0" 
                type="search" 
                placeholder="Search..."
            />
        </div>
        {#if showDropdown && searchResults.length > 0}
            <div class="z-10 w-full text-black bg-white border border-gray-300 rounded-lg shadow-lg">
                {#each searchResults as result}
                    <div 
                        class="p-2 hover:bg-gray-100 cursor-pointer"
                        on:click={() => selectResult(result)}
                    >
                        {result.name} <!-- Adjust this based on your result structure -->
                    </div>
                {/each}
            </div>
        {/if}
    </div>
    {#if error}
        <div class="text-red-500">{error}</div>
    {/if}
</div>