#!/bin/bash

#### Config file reader ####
# Reads a provided config file and
# sets any of the variables from a provided list
# Syntax: source read_config.sh <config file> <known_variables>

# Check if a config file was provided as an argument
if [ -z "$1" ]; then
  echo "Error: No config file provided."
  exit 1
fi

# Check if a list of known variables was provided as an argument
if [ -z "$2" ]; then
  echo "Error: No list of known variables provided."
  exit 1
fi

# Read the config file and store its contents in a variable
config_file="$1"
config=$(<"$config_file")

# Read the list of known variables and store it in a variable
known_variables="$2"

# Keep track of the line number
line_num=0

# Loop through each line of the config file
while IFS= read -r line; do

  line_num=$((line_num+1))

  # Remove leading whitespace
  line=$(echo $line | sed 's/^[ \t]*//g')

  # Ignore lines beginning with # as comments
  re='^[ \t]*#.*$'
  if [[ "$line" =~ $re ]]
  then
    continue
  fi

  # Split a non-comment line to 
  IFS="=" read -r var value <<< "$line"

  # Check if the variable is in the list of known variables
  # Also, ignore empty values. They are not setting variables.
  if [[ -z "$value" ]]
  then
    :
  elif [[ " ${known_variables[@]} " =~ " ${var} " ]]; then
    export "$var"="$value"
  else
    echo Unknown variable: \[$var\] \($1:$line_num\) >&2
  fi

done <<< "$config"
