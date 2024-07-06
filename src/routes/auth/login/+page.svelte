<script>
    import MdiGithub from '~icons/mdi/github';
    import FlatColorIconsGoogle from '~icons/flat-color-icons/google';
</script>

<div class="flex flex-col flex-grow text-white bg-gray-800 p-4 items-center">
    <div class="flex flex-col flex-1 justify-center">
        <form
            class="flex flex-col space-y-2"
            action="?/githubSignIn" method="POST">
            <button
                class="flex flex-row items-center space-x-4 bg-gray-900 rounded-md p-4"
                type="submit">
                <div class="text-xl font-semibold">Sign In With Github</div>
                <MdiGithub style="font-size:2em"/>
            </button>
            <button
                class="flex flex-row items-center space-x-4 bg-gray-600 rounded-md p-4"
                type="submit">
                <div class="text-xl font-semibold">Sign In With Google</div>
                <FlatColorIconsGoogle style="font-size:2em"/>
            </button>
        </form>
    </div>
</div>