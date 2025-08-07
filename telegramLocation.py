import os
from pyrogram import Client

# Read all settings from environment variables
api_id = int(os.getenv('TELEGRAM_API_ID'))
api_hash = os.getenv('TELEGRAM_API_HASH')
chat_id = os.getenv('TELEGRAM_CHAT_ID')

# Handle coordinates (supports "120,25" format)
coordinates = os.getenv('TELEGRAM_COORDINATES')
if coordinates:
    try:
        longitude, latitude = map(float, coordinates.split(','))
    except ValueError:
        print("Error: TELEGRAM_COORDINATES format is incorrect. Please use 'longitude,latitude' format, e.g., '120,25'")
        exit(1)
else:
    # If coordinates not set, use separate variables
    latitude = float(os.getenv('TELEGRAM_LATITUDE'))
    longitude = float(os.getenv('TELEGRAM_LONGITUDE'))

# Validate required parameters
if not api_id or not api_hash or not chat_id:
    print("Error: Please set the following environment variables:")
    print("- TELEGRAM_API_ID")
    print("- TELEGRAM_API_HASH")
    print("- TELEGRAM_CHAT_ID")
    exit(1)

# Validate coordinate parameters
if not coordinates:
    print("Error: Please set coordinates using one of the following methods:")
    print("- TELEGRAM_COORDINATES=longitude,latitude (e.g., 120,25)")
    exit(1)

print(f"Preparing to send location to: {chat_id}")
print(f"Coordinates: {longitude}, {latitude}")

# This code will start your Telegram client session
with Client("/app/sessions/my_session", api_id=api_id, api_hash=api_hash) as app:
    # Send location
    app.send_location(
        chat_id=chat_id,
        latitude=latitude,
        longitude=longitude,
    )
    print("Location message sent!")