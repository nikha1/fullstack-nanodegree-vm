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
    winner integer references players(id),
    loser integer references players(id)
);

-- create some useful Views
create view wins_per_player AS
  select players.id,count(winner) from players
  left outer join matches on (players.id = matches.winner)
  group by players.id order by count desc;

create view matches_per_player AS
  select players.id , count(matches.id)
  from players left outer join matches on (players.id = matches.winner OR players.id = matches.loser)
  group by players.id order by count desc;

-- Stack the columns
CREATE VIEW standings AS
  select players.id, players.name, wins_per_player.count as wins,
  matches_per_player.count as matches
  from players join wins_per_player on (players.id = wins_per_player.id)
  join matches_per_player on (players.id = matches_per_player.id)
  order by wins desc;
