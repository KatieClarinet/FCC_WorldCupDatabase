#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# add each unique team to the teams table (there should be 24 rows)
# go through each line and check if the winner is already added to the table,
# if not add it
# go through each line and check if the opponent is already added to the table,
# if not add it 

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
# make sure not to add the title line
if [[ $WINNER != "winner" ]]
  then
echo "$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
fi

# make sure not to add the title line
if [[ $OPPONENT != "opponent" ]]
  then
echo "$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
fi

# insert a row for each line in the games.csv file (other than the top line)
# there should be 32 rows
# Each row should have every column filled in with the appropriate info.
# Make sure to add the correct ID's from the teams table (you cannot hard-code the values)

if [[ $YEAR != "year" || $ROUND != "round" || $WINNER_GOALS != "winner_goals" || $OPPONENT_GOALS != "opponent_goals" ]]
then
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'") 
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'") 

echo $WINNER_ID
echo $OPPONENT_ID

echo "$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")"

fi
done


