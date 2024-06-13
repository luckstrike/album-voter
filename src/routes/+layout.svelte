<script>
    import "../app.css";
	import Navbar from "$lib/Navbar.svelte";
</script>

<div class="flex">
    <Navbar/>
</div>

<!-- Any content that we want will now fill this slot tag -->
<slot />
