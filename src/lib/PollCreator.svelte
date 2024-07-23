<script lang="ts">
    import { createEventDispatcher } from 'svelte';
    import IcBaselineClose from '~icons/ic/baseline-close';
  
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
          <div class="flex p-2 mb-2 rounded-lg w-full bg-blue-500 hover:bg-gray-100">
            <img
              src={album.images[2].url}
              alt={album.name}
              class="w-16 h-16 object-cover rounded flex-shrink-0"
            />
            <div class="flex flex-col justify-center p-2 min-w-0 flex-grow">
              <div class="font-semibold text-black truncate">{album.name}</div>
              <div class="text-sm text-gray-600 truncate">{album.artists[0].name}</div>
            </div>
            <button
              on:click={() => removeAlbum(album.id)}
              class="text-black hover:text-red-500"
              aria-label="Remove album"
            >
              <IcBaselineClose />
            </button>
          </div>
        {/each}
      </div>
    {/if}
  </div>