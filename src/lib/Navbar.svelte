<script>
    import dino from '$lib/dino.png'
</script>

<nav class="flex flex-row flex-grow text-white space-x-4 p-2 items-center bg-gray-900">
    <a href="/" class="flex flex-row items-center text-3xl font-semibold transform transition-transform duration-300 hover:scale-105">
        <img
            class="w-10 h-10 mr-2"
            src={dino}  
            alt="Album Voter"
        />
        Album Voter
    </a>
    <a href="/">Home</a>
    <a href="/vote">Vote</a> 
</nav>