<script lang="ts">
	import { forEach } from "lodash-es";

    let className: String = '';
	export { className as class }; // Let's us use class when using the component

    export let albums: any[] = [];
</script>

<div class="flex flex-col bg-slate-900 rounded-lg items-center {className}">
    <div class="p-2 text-2xl">Current Poll</div>
    {#if albums.length > 0}
        {#each albums as album}
            <!-- Make this look pretty now :) -->
            <div>{album.name}</div>
        {/each}
    {/if}
</div>
