import { foreignKey } from 'drizzle-orm/mysql-core';
import { integer, pgTable, serial, text, timestamp, varchar } from 'drizzle-orm/pg-core';

// Users Table
export const usersTable = pgTable('users', {
  user_id: serial('id').primaryKey(),
  name: text('name').notNull(),
  age: integer('age').notNull(),
  email: text('email').notNull().unique(),
});

// Polls Table
export const pollsTable = pgTable('polls', {
  poll_id: serial('id').primaryKey(),
  user_id: text('name').notNull().references(() => usersTable.user_id),
  title: text('user_id').notNull(),
  description: text('description'),
  creation_date: timestamp('creation_date').defaultNow(),
  end_date: timestamp('end_date').notNull()
});

// Albums Table
export const albumsTable = pgTable('albums', {
  album_id: serial('album_id').primaryKey(),
  album_name: varchar('album_name', { length: 255 }).notNull(),
  artist: varchar('artist', { length: 255 }).notNull(),
  release_year: integer('release_year')
});

export const pollAlbumsTable = pgTable('poll_albums', {
  poll_albums_id: serial('poll_albums_id').primaryKey(),
  poll_id: integer('poll_id').notNull().references(() => pollsTable.poll_id),
  album_id: integer('album_id').notNull().references(() => albumsTable.album_id)
})

// Votes Table
export const votesTable = pgTable('votes', {
  vote_id: serial('vote_id').primaryKey(),
  poll_id: integer('poll_id').notNull().references(() => pollsTable.poll_id),
  album_id: integer('album_id').notNull().references(() => albumsTable.album_id),
  user_id: integer('user_id').notNull().references(() => usersTable.user_id),
  vote_date: timestamp('vote_date').defaultNow()
})
