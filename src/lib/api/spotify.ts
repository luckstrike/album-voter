// Anything Spotify API related should go here
import { SpotifyApi } from "@spotify/web-api-ts-sdk";
import { SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET } from '$env/static/private';

let spotifySDK: SpotifyApi | null = null;

export async function getSpotifySDK(): Promise<SpotifyApi> {
    if (!spotifySDK) {
      spotifySDK = SpotifyApi.withClientCredentials(
        SPOTIFY_CLIENT_ID, 
        SPOTIFY_CLIENT_SECRET
      );
      await spotifySDK.authenticate(); // Ensure we have a valid token
    }
    return spotifySDK;
}

export async function getAlbumsFromSpotify(sdk: SpotifyApi, searchQuery: string) {
    // Uses the Spotify API to search for an album
    const items = await sdk.search(searchQuery, ["album"]);

    return items;
}