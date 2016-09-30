-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- Create the db
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;

-- Connect to the db
\c tournament;


-- Create tables
CREATE TABLE players (
  player_id serial primary key,
  name text);

CREATE TABLE matches (
    match_id serial primary key);
