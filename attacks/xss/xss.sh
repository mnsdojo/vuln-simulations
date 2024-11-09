#!/bin/bash

# Set the target URL of the server
TARGET_URL="http://localhost:3000/comment"

# XSS payload to inject (e.g., a malicious script)
XSS_PAYLOAD='<script>alert("XSS Attack!")</script>'

# Step 1: Run bun --watch in the background
bun --watch index.ts &

# Step 2: Wait for some time (e.g., 5 seconds)
echo "Waiting for the server to start..."
sleep 5 # Wait for 5 seconds or adjust as needed

# Step 3: Use curl to make a POST request to the server, sending the malicious payload
echo "Simulating XSS attack..."
curl -X POST $TARGET_URL \
  -d "comment=$XSS_PAYLOAD" \
  -H "Content-Type: application/x-www-form-urlencoded"

# Wait for the background process to finish
wait
