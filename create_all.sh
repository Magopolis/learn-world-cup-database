#!/bin/bash
USERNAME="freecodecamp"

# Create the worldcup database
psql --username=$USERNAME --dbname=postgres -c "CREATE DATABASE worldcup;"

# Run the create_tables.sql script to create tables in the worldcup database
psql --username=$USERNAME --dbname=worldcup -f create_tables.sql
-- Create teams table
CREATE TABLE teams (
  team_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);

-- Create games table
CREATE TABLE games (
  game_id SERIAL PRIMARY KEY,
  year INT NOT NULL,
  round VARCHAR(50) NOT NULL,
  winner_id INT NOT NULL REFERENCES teams(team_id),
  opponent_id INT NOT NULL REFERENCES teams(team_id),
  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL
);
chmod +x create_all.sh
./create_all.sh
