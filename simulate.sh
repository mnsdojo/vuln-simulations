#!/bin/bash

ATTACKS_DIR="./attacks"

usage() {
  echo "Usage: $0 {xss|sql_injection} [additional arguments]"
  exit 1
}

# Make sure both scripts are executable
chmod +x "$ATTACKS_DIR/sqlite-injection/sqlite-injection.sh"
chmod +x "$ATTACKS_DIR/xss/xss.sh"

# Function to run XSS simulation
run_xss() {
  echo "Simulating XSS attack..."
  bash "$ATTACKS_DIR/xss/xss.sh"
}

# Function to run SQL Injection simulation
run_sql_injection() {
  echo "Simulating SQL Injection attack..."
  bash "$ATTACKS_DIR/sqlite-injection/sql_injection.sh"
}

# Check if the user has provided at least one argument
if [[ $# -lt 1 ]]; then
  # If not, display usage instructions
  usage
fi

case $1 in
xss)
  run_xss
  ;;
sql_injection)
  run_sql_injection
  ;;
# If the argument doesn't match any known attack type, display usage instructions
*)
  usage
  ;;
esac
