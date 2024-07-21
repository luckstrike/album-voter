<script>
    import MaterialSymbolsSearch from '~icons/material-symbols/search';
    export let value = '';
  </script>
  
<div class="flex items-center w-full h-12 text-black bg-white rounded-lg">
    <div class="p-1 pl-2">
        <MaterialSymbolsSearch/>
    </div>
    <input 
        bind:value
        on:input
        class="w-full pt-2 pb-2 pl-1 pr-2 rounded-lg focus:outline-none focus:ring-0"
        type="search" 
        placeholder="Search..."
    />
</div>