#!/bin/bash

# Read addresses from TOML file and convert to JSON
addresses=$(yj -tj < addresses.toml)

# Process each IDL file in source-idls directory
for idl_file in source-idls/*.json; do
    # Get the filename without path and extension
    filename=$(basename "$idl_file" .json)
    
    # Get the corresponding address from the TOML data
    address=$(echo "$addresses" | jq -r ".addresses.$filename // empty")
    
    if [ -z "$address" ]; then
        echo "Warning: No address found for $filename, skipping..."
        continue
    fi
    
    echo "Processing $filename with address $address"
    
    # Create a temporary file with the metadata.address field added
    temp_file="/tmp/${filename}_temp.json"
    jq --arg addr "$address" '. + {metadata: {address: $addr}}' "$idl_file" > "$temp_file"
    
    # Run anchor idl convert on the temporary file
    echo "Converting $filename.json with anchor idl convert..."
    anchor idl convert "$temp_file" > "idls/$filename.json"
    
    # Clean up temporary file
    rm "$temp_file"
    
    # Format the output file with Biome
    npx biome format --write "idls/$filename.json"
done

echo "Processing complete!"