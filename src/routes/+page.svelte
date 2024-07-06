<!-- TODO: Make the landing page be able to have multiple different song quotes you can switch through -->
<!--       Ideally pull from the most popular polls but for now just hard code a couple                -->

<script lang="ts">
    import MdiArrowRightBold from '~icons/mdi/arrow-right-bold';

    
</script>

<div class="flex flex-row flex-grow bg-gray-800 items-center p-16 space-x-8">
    <div class="flex flex-col text-white items-start">
        <h1 class="text-6xl font-bold bg-gradient-to-r from-blue-500 to-pink-700 inline-block text-transparent bg-clip-text leading-tight">
            Next Level Album Voting
        </h1>
        <p class="text-white text-3xl">Wanna feed your dogs like Mardi Gras?</p>
        <div class="pt-10">
            <button class="rounded-full bg-blue-500 pl-4 pr-4 pt-2 pb-2 text-xl font-bold">Vote</button>
        </div>
    </div>
    <div class="flex flex-col flex-grow text-white items-end">
        <img
            class="max-h-96 max-w-96 transform transition-transform duration-300 hover:rotate-3 hover:scale-110"
            src="https://i.discogs.com/rObvAZc7_iGhjPqHp2cQ_srbEmbm-7tjnW7ULLsfoGg/rs:fit/g:sm/q:90/h:600/w:592/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTE2ODAx/OTc3LTE2MDk5MTEy/ODItMzYyMC5qcGVn.jpeg"
            alt="Album Cover for DOG by Kahlil Blu"
        />
        <p class="text-lg">runway talk - Kahlil Blu</p>
    </div>
    <button class="rounded-full bg-blue-500 p-1 text-white">
        <MdiArrowRightBold style="font-size:2em"/>
    </button>
</div>