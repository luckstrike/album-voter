<script>
    import "../app.css";
	import Navbar from "$lib/Navbar.svelte";

    import { invalidate } from '$app/navigation';
	import { onMount } from 'svelte';

	export let data;
	$: ({ session, supabase } = data);

	onMount(() => {
		const { data } = supabase.auth.onAuthStateChange((_, newSession) => {
			if (newSession?.expires_at !== session?.expires_at) {
				invalidate('supabase:auth');
			}
		});

		return () => data.subscription.unsubscribe();
	});

	if (data.user)
		console.log("[root +layout.svelte DEBUG]: User: ")
		console.log(data.user)

</script>

<div class="flex flex-col h-screen">
    <div class="flex bg-gray-800">
        <Navbar/>
    </div>

    <!-- Any content that we want will now fill this slot tag -->
    <slot />
</div>