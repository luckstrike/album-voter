<script lang="ts">
  import AlbumSearchPanel from '$lib/AlbumSearchPanel.svelte'
	import PollCreator from '$lib/PollCreator.svelte';

  let error = null;
  let pollAlbums: any[] = [];

  function handleSearchError(event) {
    error = event.detail.message;
  }

  function handleAlbumSelect(event) {
    const { id, selectedAlbums } = event.detail;
    pollAlbums = selectedAlbums;
  }

  function handleAlbumRemove(event) {
    const { id } = event.detail;
    pollAlbums = pollAlbums.filter(album => album.id !== id);
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
        on:albumSelected={handleAlbumSelect}
        {pollAlbums}
      />

      <PollCreator 
        albums={pollAlbums} 
        class="w-5/12 h-full overflow-hidden" 
        on:albumRemoved={handleAlbumRemove}
      />
    </div>
</main>