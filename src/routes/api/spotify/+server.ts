import { SpotifyApi } from "@spotify/web-api-ts-sdk";
import { SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET } from '$env/static/private';
import { getAlbumsFromSpotify, getSpotifySDK } from "$lib/api/spotify";

export async function POST({ request }) {
    try {
      const spotifySDK = await getSpotifySDK();
      const { query } = await request.json();
      const data = await getAlbumsFromSpotify(spotifySDK, query);
      
      return new Response(JSON.stringify(data), { 
        status: 200, 
        headers: { 'Content-Type': 'application/json' }
      });
    } catch (error) {
      console.error('Error in Spotify request:', error);
      return new Response(JSON.stringify({ error: 'Failed to fetch albums' }), { status: 500 });
    }
  }