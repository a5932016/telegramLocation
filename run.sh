#!/bin/bash

# Telegram API Docker Runner Script
# Usage: ./run.sh

echo "Telegram API Docker Runner"
echo "=========================="

# Function to read input with default value
read_input() {
    local prompt="$1"
    local default="$2"
    local var_name="$3"
    
    if [ -n "$default" ]; then
        read -p "$prompt [$default]: " input
        if [ -z "$input" ]; then
            input="$default"
        fi
    else
        read -p "$prompt: " input
    fi
    
    eval "$var_name=\"$input\""
}

# Get user inputs
echo "Please enter your Telegram API credentials:"
echo ""

read_input "Enter API ID" "" "api_id"
read_input "Enter API Hash" "" "api_hash"
read_input "Enter Chat ID (e.g., @username or 123456789)" "" "chat_id"
read_input "Enter Coordinates (longitude,latitude e.g., 120,25)" "120,25" "coordinates"

echo ""
echo "Building Docker image..."
cd .. && docker build -f docker/Dockerfile -t telegram-location .

echo ""
echo "Running container with parameters:"
echo "  API ID: $api_id"
echo "  Chat ID: $chat_id"
echo "  Coordinates: $coordinates"
echo ""

docker run --rm -it \
  -e TELEGRAM_API_ID="$api_id" \
  -e TELEGRAM_API_HASH="$api_hash" \
  -e TELEGRAM_CHAT_ID="$chat_id" \
  -e TELEGRAM_COORDINATES="$coordinates" \
  -v "$(pwd)/sessions:/app/sessions" \
  telegram-location 