#!/bin/bash

# Define the directory where the attack scripts are stored
ATTACKS_DIR="./attacks"

# Colors for output
RED='\033[0;31m'    # Red color for errors
GREEN='\033[0;32m'  # Green color for success
YELLOW='\033[0;33m' # Yellow color for warnings
RESET='\033[0m'     # Reset color to default

# Function to display usage instructions with color
usage() {
  echo -e "${YELLOW}Usage: $0 {xss|sql_injection} [additional arguments]${RESET}"
  exit 1
}

# Make sure both attack scripts are executable
chmod +x "$ATTACKS_DIR/sqlite-injection/sqlite-injection.sh"
chmod +x "$ATTACKS_DIR/xss/xss.sh"

# Function to run the XSS simulation with color output
run_xss() {
  echo -e "${GREEN}Simulating XSS attack...${RESET}"
  bash "$ATTACKS_DIR/xss/xss.sh" # Execute the XSS attack script
}

# Function to run the SQL Injection simulation with color output
run_sql_injection() {
  echo -e "${GREEN}Simulating SQL Injection attack...${RESET}"
  bash "$ATTACKS_DIR/sqlite-injection/sql_injection.sh" # Execute the SQL Injection attack script
}

# Check if the user has provided at least one argument
if [[ $# -lt 1 ]]; then
  # If no arguments are passed, display usage instructions
  echo -e "${RED}Error: No arguments provided.${RESET}"
  usage
fi

# Process the command line argument and run the corresponding simulation
case $1 in
xss)      # If the argument is "xss"
  run_xss # Run the XSS simulation
  ;;
sql_injection)      # If the argument is "sql_injection"
  run_sql_injection # Run the SQL Injection simulation
  ;;
*) # If the argument is anything else
  echo -e "${RED}Error: Invalid argument provided.${RESET}"
  usage # Show usage instructions for invalid inputs
  ;;
esac
