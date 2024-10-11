#!/bin/bash

# Define file paths
QUERIES_FILE="./queries.sh"
EXPECTED_FILE="./expected_output.txt"

# Run queries.sh but filter to extract only answer lines (skip description lines)
QUERIES_OUTPUT=$(bash $QUERIES_FILE | awk '!/:$/' | grep -v "^$")

# Convert the queries output into an array (splitting by new lines)
IFS=$'\n' read -d '' -r -a OUTPUT_ARRAY <<< "$QUERIES_OUTPUT"

# Read expected output into an array
mapfile -t EXPECTED_ARRAY < "$EXPECTED_FILE"

# Counters for correct and incorrect results
correct_count=0
incorrect_count=0

# Compare the results
for i in "${!EXPECTED_ARRAY[@]}"; do
  # Handle multi-line results (lists) by using array slicing
  expected="${EXPECTED_ARRAY[$i]}"
  actual="${OUTPUT_ARRAY[$i]}"

  if [[ "$actual" == "$expected" ]]; then
    ((correct_count++))
  else
    ((incorrect_count++))
    echo "Query $((i+1)): Incorrect"
    echo "Expected: ${expected}"
    echo "Got: ${actual}"
  fi
done

# Print summary
echo -e "\nSummary:"
echo "Correct: $correct_count"
echo "Incorrect: $incorrect_count"
