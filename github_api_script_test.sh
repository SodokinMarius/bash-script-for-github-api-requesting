#!/bin/bash

# Check if user passed in a Github username as the first argument
if [ -z "$1" ]; then
    echo "Error: Missing Github username"
    exit 1
fi

# Set the Github API endpoint
API_ENDPOINT="https://api.github.com/users/$1"

# Make the API call and store the response in a variable
RESPONSE=$(curl -s "$API_ENDPOINT")

# Check if user passed in a specific property to output
if [ -z "$2" ]; then
    # If no specific property was passed in, print the entire response
    echo "$RESPONSE"
else
    # Extract value of the passed property from json 
    echo "Property : $2"

    echo "value: $(echo  $RESPONSE | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep $2 | cut -d':' -f2- | tr -d '"' )"
    
fi