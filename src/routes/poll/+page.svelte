<script lang="ts">
    import MaterialSymbolsSearch from '~icons/material-symbols/search';
</script>

<div class="flex flex-col flex-grow text-white bg-gray-800 p-4 items-center">
    <div class="text-4xl font-bold bg-gradient-to-r from-blue-500 to-pink-700 inline-block text-transparent bg-clip-text leading-tight">
        Create a Poll
    </div>
    <div class="flex flex-row text-black bg-white rounded-lg w-1/2 m-4 pt-1 pb-1 items-center">
        <div class="p-1 pl-2 pr-2">
            <MaterialSymbolsSearch/>
        </div>
        <input class="w-full focus:outline-none focus:ring-0" type="search" placeholder="Search..."/>
    </div>
</div>