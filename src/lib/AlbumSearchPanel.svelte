<script lang="ts">
	import { debounce } from 'lodash-es';
	import { createEventDispatcher } from 'svelte';
	import MaterialSymbolsSearch from '~icons/material-symbols/search';

	export let initialSearchResults: any[] = [];
	let className = '';
	export { className as class };

	let searchQuery = '';
	let searchResults = initialSearchResults;
	let isLoading = false;
	let error: string | null = null;

	const MAX_DISPLAYED_ALBUMS = 10; // Define this constant

	const dispatch = createEventDispatcher();

	const handleInput = debounce(async () => {
		if (searchQuery.length > 2) {
			isLoading = true;
			const data = await handleSearch(searchQuery);
			searchResults = data || [];
			isLoading = false;
		} else {
			searchResults = [];
		}
	}, 300);

	function removeDuplicates(albums: any[]): any[] {
		const uniqueAlbums = new Map();

		return albums.filter((album) => {
			const duplicate = uniqueAlbums.has(album.name);

			if (!duplicate) uniqueAlbums.set(album.name, true);
			return !duplicate;
		});
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

			console.log(data.albums.items);

			// Returning only the list of albums
			const filteredAlbums = removeDuplicates(
				data.albums.items.filter((result: any) => result.album_type === 'album')
			).slice(0, MAX_DISPLAYED_ALBUMS);

			return filteredAlbums;
		} catch (err) {
			error = err.message;
			return [];
		}
	}

	function selectResult(result: any) {
		dispatch('select', result);
	}
</script>

<div class="flex flex-col bg-slate-900 rounded-lg p-4 {className}">
	<div class="flex items-center w-full h-12 text-black bg-white rounded-lg mb-4 flex-shrink-0">
		<div class="p-1 pl-2">
			<MaterialSymbolsSearch />
		</div>
		<input
			bind:value={searchQuery}
			on:input={handleInput}
			class="w-full pt-2 pb-2 pl-1 pr-2 rounded-lg focus:outline-none focus:ring-0"
			type="search"
			placeholder="Search for albums..."
		/>
	</div>

  <div class="flex-1 overflow-hidden flex justify-center">
    <div aria-live="polite">
        {#if isLoading}
            <div class="text-white text-center">Loading...</div>
        {:else if searchResults.length > 0}
            <div class="h-full overflow-y-auto flex-1" role="list" aria-label="Search results">
                {#each searchResults as result}
                    <div
                        class="flex p-2 cursor-pointer hover:bg-gray-100 bg-white mb-2 rounded-lg"
                        on:click={() => selectResult(result)}
                        role="button"
                        aria-label={`Select ${result.name} by ${result.artists[0].name}`}
                        tabindex="0"
                        on:keypress={(e) => e.key === 'Enter' && selectResult(result)}
                    >
                        <img
                            src={result.images[2].url}
                            alt={result.name}
                            class="w-16 h-16 object-cover rounded flex-shrink-0"
                        />
                        <div class="flex flex-col justify-center p-2 min-w-0 flex-grow">
                            <div class="font-semibold text-black truncate">{result.name}</div>
                            <div class="text-sm text-gray-600 truncate">{result.artists[0].name}</div>
                        </div>
                    </div>
                {/each}
            </div>
        {:else if searchQuery !== ''}
            <div class="text-white text-center">No results found</div>
        {/if}
    </div>
</div>

{#if error}
    <div class="text-red-500 mt-2 flex-shrink-0" aria-live="assertive">{error}</div>
{/if}
</div>