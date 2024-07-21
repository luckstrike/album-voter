<script lang="ts">
	import { forEach } from "lodash-es";

    let className: String = '';
	export { className as class }; // Let's us use class when using the component

    export let albums: any[] = [];
</script>

<div class="flex flex-col bg-slate-900 rounded-lg p-4 items-center {className}">
    <div class="text-2xl pb-2">Current Poll</div>
    {#if albums.length > 0}
        {#each albums as album}
            <!-- Make this look pretty now :) -->
            <div
                class="flex p-2 cursor-pointer mb-2 rounded-lg w-full bg-blue-500 hover:bg-gray-100"
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
    {/if}
</div>
