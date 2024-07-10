CREATE TABLE IF NOT EXISTS "albums" (
	"album_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"album_name" varchar(255) NOT NULL,
	"artist" varchar(255) NOT NULL,
	"release_year" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "poll_albums" (
	"poll_albums_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"poll_id" uuid NOT NULL,
	"album_id" uuid NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "polls" (
	"poll_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"provider_id" text NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"creation_date" timestamp DEFAULT now(),
	"end_date" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"provider_id" text PRIMARY KEY NOT NULL,
	"provider" varchar(20) NOT NULL,
	"provider_user_id" text NOT NULL,
	"email" text NOT NULL,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "users_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "votes" (
	"vote_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"poll_id" uuid NOT NULL,
	"album_id" uuid NOT NULL,
	"provider_id" text NOT NULL,
	"vote_date" timestamp DEFAULT now()
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "poll_albums" ADD CONSTRAINT "poll_albums_poll_id_polls_poll_id_fk" FOREIGN KEY ("poll_id") REFERENCES "public"."polls"("poll_id") ON DELETE no action ON UPDATE no action;
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
 ALTER TABLE "polls" ADD CONSTRAINT "polls_provider_id_users_provider_id_fk" FOREIGN KEY ("provider_id") REFERENCES "public"."users"("provider_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "votes" ADD CONSTRAINT "votes_poll_id_polls_poll_id_fk" FOREIGN KEY ("poll_id") REFERENCES "public"."polls"("poll_id") ON DELETE no action ON UPDATE no action;
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
 ALTER TABLE "votes" ADD CONSTRAINT "votes_provider_id_users_provider_id_fk" FOREIGN KEY ("provider_id") REFERENCES "public"."users"("provider_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
