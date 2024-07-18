<script lang="ts">
    import MaterialSymbolsSearch from '~icons/material-symbols/search';

    let albumSearch: string;
    let isSearching: boolean = false;
    let error;

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
            
            console.log(data)

        } catch (err) {
            error = err.message;
        } finally {
            isSearching = false;
        }
    }

</script>

<div class="flex flex-col flex-grow text-white bg-gray-800 p-4 items-center">
    <div class="text-4xl font-bold bg-gradient-to-r from-blue-500 to-pink-700 inline-block text-transparent bg-clip-text leading-tight">
        Create a Poll
    </div>
    <div class="flex flex-row text-black bg-white rounded-lg w-1/3 m-4 pt-1 pb-1 items-center">
        <div class="p-1 pl-2 pr-2">
            <MaterialSymbolsSearch/>
        </div>
        <input bind:value={albumSearch} class="w-full focus:outline-none focus:ring-0" type="search" placeholder="Search..."/>

    </div>
    <!--TODO: Create a way to show these results as soon as the user searches for an album
            Make sure to include some debouncing as well to decrease the amount of API
            calls done
            Also remove this button as it was just for testing purposes -->
    <button on:click={() => handleSearch(albumSearch)}>Test</button>
</div>