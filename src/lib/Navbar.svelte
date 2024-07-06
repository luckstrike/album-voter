<script lang="ts">
    import dino from '$lib/dino.png';
	import type { SupabaseClient } from '@supabase/supabase-js';
	import { error } from '@sveltejs/kit';
    export let data;

    async function handleLogout(supabase: SupabaseClient) {
        try {
            const { error } = await supabase.auth.signOut();
        } catch (e) {
            error(403, "Unable to logout")
        }
        
    }

</script>

<nav class="flex flex-row flex-grow justify-between text-white p-2 items-center bg-gray-900">
    <div class="flex flex-row items-center space-x-4">
        <a href="/" class="flex flex-row items-center text-3xl font-semibold transform transition-transform duration-300 hover:scale-105">
            <img
                class="w-10 h-10 mr-2"
                src={dino}  
                alt="Album Voter Dinosaur"
            />
            Album Voter
        </a>
        <a href="/">Home</a>
        <a href="/vote">Vote</a>
    </div>

    {#if !data.user}
        <a href="auth/login" class="p-2">Log In</a>
    {:else}
        <a href="" on:click={ () => handleLogout(data.supabase) } class="p-2">Log out</a>
    {/if}

</nav>
