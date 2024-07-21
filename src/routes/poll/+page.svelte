<script lang="ts">
    import AlbumSearchPanel from '$lib/AlbumSearchPanel.svelte'
	import PollCreator from '$lib/PollCreator.svelte';

    let error = null;

    function handleSearchError(event) {
        error = event.detail.message;
    }

    function handleAlbumSelect(event) {
        const selectedAlbum = event.detail;
        // Handle the selected album (e.g., add it to the poll)
        console.log('Selected album:', selectedAlbum);
    }

</script>

<main class="flex flex-col h-screen p-4 text-white bg-gray-800 items-center overflow-hidden">
    <h1 class="text-4xl font-bold leading-tight bg-gradient-to-r from-blue-500 to-pink-700 bg-clip-text text-transparent mb-4">
      Create a Poll
    </h1>
  
    <div class="flex w-full flex-1 justify-between overflow-hidden">
      <AlbumSearchPanel 
        class="w-1/2 h-full overflow-hidden" 
        on:error={handleSearchError} 
        on:select={handleAlbumSelect}
      />
  
      {#if error}
        <p class="mt-2 text-red-500">{error}</p>
      {/if}
  
      <PollCreator class="w-2/5 h-full overflow-hidden" />
    </div>
</main>