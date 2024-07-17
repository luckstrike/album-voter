<script>
    import Poll from "$lib/Poll.svelte"
</script>

<div class="flex flex-col flex-grow text-white bg-gray-800 p-4 items-center">
    <div class="text-4xl font-bold bg-gradient-to-r from-blue-500 to-pink-700 inline-block text-transparent bg-clip-text leading-tight">
        Current Polls
    </div>
    <Poll/>
</div>