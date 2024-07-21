<script lang="ts">
    import MaterialSymbolsSearch from '~icons/material-symbols/search';
    import { debounce } from 'lodash-es';
	import { onMount } from 'svelte';

    let albumSearch: string;
    let isSearching: boolean = false;
    let searchResults: any[] = [];
    let error: string | null = null;

    const MAX_DISPLAYED_ALBUMS: number = 5;

    const handleInput = debounce(async () => {
        if (albumSearch.length > 2) {
            const data = await handleSearch(albumSearch);
            searchResults = data;
        } else {
            searchResults = [];
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

            console.log(data.albums.items)

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
    }

    onMount(() => {
        document.addEventListener('click', (event: MouseEvent) => {
            const target = event.target as HTMLElement;
        });
    });

</script>

<div class="flex flex-col flex-grow text-white bg-gray-800 p-4 items-center">
    <div class="text-4xl font-bold bg-gradient-to-r from-blue-500 to-pink-700 inline-block text-transparent bg-clip-text leading-tight">
        Create a Poll
    </div>
    <!-- Or I could turn the search bar into a rectangle component that searches for stuff
         and updates the albums found without showing a dropdown
         So think like a Search Bar and then a box that is empty until the user searches for
         something 
    -->
    <div class="flex flex-row w-full h-full justify-between m-2">
        <div class="flex flex-col w-2/5 h-full bg-slate-900 rounded-lg">
            <div class="flex flex-row text-black bg-white rounded-lg w-full h-12 items-center">
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
            <div class="w-[100%] text-black bg-white border border-gray-300 rounded-lg shadow-lg mt-1">
                Test
            </div>
            {#if searchResults.length > 0}
                <div class="flex flex-col w-[100%] text-black bg-white border border-gray-300 rounded-lg shadow-lg mt-1">
                    {#each searchResults as result}
                        <div 
                            class="flex flex-row p-2 hover:bg-gray-100 cursor-pointer"
                            on:click={() => selectResult(result)}
                        >
                            <img src={result.images[2].url}/>
                            <div class="flex flex-col justify-center p-2">
                                <div>{result.name}</div>
                                <div>{result.artists[0].name}</div>
                            </div>
                        </div>
                    {/each}
                </div>
            {/if}
        </div>
        {#if error}
            <div class="text-red-500 mt-2">{error}</div>
        {/if}
        <div class="flex flex-col bg-slate-900 rounded-lg w-1/2 h-[100%]">
            <div class="flex flex-col text-center">Your Poll</div>
        </div>
    </div>
</div>