import { integer, pgTable, uuid, serial, text, timestamp, varchar } from 'drizzle-orm/pg-core';

// Users Table
export const usersTable = pgTable('users', {
  provider_id: text('provider_id').primaryKey(),  // e.g., "github:1234567" or "google:abcdefg123"
  provider: varchar('provider', { length: 20 }).notNull(),  // e.g., "github" or "google"
  provider_user_id: text('provider_user_id').notNull(),  // The ID from the provider
  email: text('email').notNull().unique(),
  created_at: timestamp('created_at').defaultNow(),
});

// Polls Table
export const pollsTable = pgTable('polls', {
  poll_id: uuid('poll_id').defaultRandom().primaryKey(),
  provider_id: text('provider_id').notNull().references(() => usersTable.provider_id),
  title: text('title').notNull(),
  description: text('description'),
  creation_date: timestamp('creation_date').defaultNow(),
  end_date: timestamp('end_date').notNull()
});

// Albums Table
export const albumsTable = pgTable('albums', {
  album_id: uuid('album_id').defaultRandom().primaryKey(),
  album_name: varchar('album_name', { length: 255 }).notNull(),
  artist: varchar('artist', { length: 255 }).notNull(),
  release_year: integer('release_year')
});

// Poll Albums Table (Kind of like the glue between polls and albums)
export const pollAlbumsTable = pgTable('poll_albums', {
  poll_albums_id: uuid('poll_albums_id').defaultRandom().primaryKey(),
  poll_id: uuid('poll_id').notNull().references(() => pollsTable.poll_id),
  album_id: uuid('album_id').notNull().references(() => albumsTable.album_id)
});

// Votes Table
export const votesTable = pgTable('votes', {
  vote_id: uuid('vote_id').defaultRandom().primaryKey(),
  poll_id: uuid('poll_id').notNull().references(() => pollsTable.poll_id),
  album_id: uuid('album_id').notNull().references(() => albumsTable.album_id),
  provider_id: text('provider_id').notNull().references(() => usersTable.provider_id),
  vote_date: timestamp('vote_date').defaultNow()
});
