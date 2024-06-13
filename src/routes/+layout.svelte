<script>
    import "../app.css";
	import Navbar from "$lib/Navbar.svelte";
</script>

<div class="flex flex-col h-screen">
    <div class="flex bg-gray-800">
        <Navbar/>
    </div>

    <!-- Any content that we want will now fill this slot tag -->
    <slot />
</div>