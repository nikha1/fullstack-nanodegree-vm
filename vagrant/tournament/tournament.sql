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
  id serial primary key,
  name text
);

CREATE TABLE matches (
    id serial primary key,
    player_1 integer references players(id),
    player_2 integer references players(id),
    winner integer references players(id)
);

-- create some useful Views
CREATE VIEW wins_per_player AS SELECT winner,count(winner)
  FROM matches GROUP BY winner;

CREATE VIEW p1_stats AS
  SELECT player_1,count(player_1) FROM matches GROUP BY player_1;

CREATE VIEW p2_stats AS
  SELECT player_2,count(player_2) FROM matches GROUP BY player_2;


CREATE VIEW player_match_count AS
  SELECT p1_stats.player_1 as player, p1_stats.count as count FROM p1_stats
  UNION ALL
  SELECT p2_stats.player_2 as player, p2_stats.count as count FROM p2_stats;


  SELECT player,sum(count) FROM player_match_count GROUP BY player;
