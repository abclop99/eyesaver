#!/bin/bash

#### Tests the config file reader ####

# Set up a test config file
cat > test.conf << EOF
# Test config file
var1=value1
var2=value2
var3=value3
var5=value5

  # Indented
  var6=value6
EOF

# Define a list of known variables
known_variables="var1 var2 var3 var4 var6"

# Run the script you wrote and pass the test config file and known variables as arguments
source read_config.sh test.conf "$known_variables"

# Test that the variables were exported correctly
if [[ $var1 = "value1" && $var2 = "value2" && $var3 = "value3" && $var6 = "value6" ]]; then
  echo "Test passed: variables were exported correctly."
else
  echo "Test failed: variables were not exported correctly."
  echo var1=$var1
  echo var2=$var2
  echo var3=$var3
  echo var4=$var4
  echo var5=$var5
  echo var6=$var6
fi

# Clean up
rm test.conf
