<script lang="ts">
	import { createEventDispatcher } from 'svelte';

	let className: string = '';
	export { className as class };

	export let albums: any[] = [];

	const dispatch = createEventDispatcher();

	function removeAlbum(id: string) {
		dispatch('albumRemoved', { id });
	}
</script>

<div class="flex flex-col bg-slate-900 rounded-lg p-4 items-center overflow-hidden {className}">
	<div class="text-2xl pb-2">Current Poll</div>
	{#if albums.length > 0}
		<div class="overflow-y-auto w-full">
			{#each albums as album}
				<div
					class="flex p-2 mb-2 rounded-lg w-full bg-blue-500 hover:bg-red-500 cursor-pointer transition-colors duration-200"
					on:click={() => removeAlbum(album.id)}
					on:keypress={(e) => e.key === 'Enter' && removeAlbum(album.id)}
					tabindex="0"
					role="button"
					aria-label="Remove {album.name} from poll"
				>
					<img
						src={album.images[2].url}
						alt={album.name}
						class="w-16 h-16 object-cover rounded flex-shrink-0"
					/>
					<div class="flex flex-col justify-center p-2 min-w-0 flex-grow">
						<div class="font-semibold text-black truncate">{album.name}</div>
						<div class="text-sm text-gray-600 truncate">{album.artists[0].name}</div>
					</div>
				</div>
			{/each}
		</div>
	{:else}
		<div class="text-white">No albums selected for the poll yet.</div>
	{/if}
</div>
