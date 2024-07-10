import type { LayoutServerLoad } from './$types'
import { db } from '$lib/db/db';
import { usersTable } from '$lib/db/schema';
import { and, eq } from 'drizzle-orm';


export const load: LayoutServerLoad = async ({ locals: { session }, cookies }) => {
  if (session) {
    const { user } = session;

    // Extract provider and provider_user_id from user.id
    const provider = user.app_metadata.provider;
    const provider_user_id = user.id;
    const provider_id = provider + ":" + provider_user_id
    const user_email = user.email;

    // Checking if the user already exists in the users table
    try {
      const existingUser = await db.query.usersTable.findFirst({
      where: and(
        eq(usersTable.provider, provider as string),
        eq(usersTable.provider_user_id, provider_user_id as string)
      ),
    });

      if (!existingUser) {
        await db.insert(usersTable).values({
          provider_id: provider_id,
          provider: provider,
          provider_user_id: provider_user_id,
          email: user_email
          // created_at will be set automatically due to defaultNow();
        });
      }
    } catch (error) {
      console.error("error in user operation: ", error)
    }
  }

  return {
    session,
    cookies: cookies.getAll(),
  }
}