CREATE TABLE IF NOT EXISTS "albums" (
	"album_id" serial PRIMARY KEY NOT NULL,
	"album_name" varchar(255) NOT NULL,
	"artist" varchar(255) NOT NULL,
	"release_year" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "poll_albums" (
	"poll_albums_id" serial PRIMARY KEY NOT NULL,
	"poll_id" integer NOT NULL,
	"album_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "polls" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"user_id" text NOT NULL,
	"description" text,
	"creation_date" timestamp DEFAULT now(),
	"end_date" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "votes" (
	"vote_id" serial PRIMARY KEY NOT NULL,
	"poll_id" integer NOT NULL,
	"album_id" integer NOT NULL,
	"user_id" integer NOT NULL,
	"vote_date" timestamp DEFAULT now()
);
--> statement-breakpoint
ALTER TABLE "users_table" RENAME TO "users";--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_table_email_unique";--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "poll_albums" ADD CONSTRAINT "poll_albums_poll_id_polls_id_fk" FOREIGN KEY ("poll_id") REFERENCES "public"."polls"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "poll_albums" ADD CONSTRAINT "poll_albums_album_id_albums_album_id_fk" FOREIGN KEY ("album_id") REFERENCES "public"."albums"("album_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "polls" ADD CONSTRAINT "polls_name_users_id_fk" FOREIGN KEY ("name") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "votes" ADD CONSTRAINT "votes_poll_id_polls_id_fk" FOREIGN KEY ("poll_id") REFERENCES "public"."polls"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "votes" ADD CONSTRAINT "votes_album_id_albums_album_id_fk" FOREIGN KEY ("album_id") REFERENCES "public"."albums"("album_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "votes" ADD CONSTRAINT "votes_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_email_unique" UNIQUE("email");