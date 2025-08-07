# Telegram API Location Sharing Program

This program uses the Pyrogram library to send location messages to Telegram.

## Installation Requirements

Before running the program, please install the required packages:

```bash
pip install -r requirements.txt
```

Or install manually:

```bash
pip install pyrogram tgcrypto
```

## Setup Instructions

1. Go to [my.telegram.org](https://my.telegram.org) and log in to your Telegram account
2. Create a new application
3. Choose one of the following methods to set up API credentials:

### Method 1: Direct Code Editing (Simplest)
Add `api_id` and `api_hash` to the `telegramLocation.py` file

### Method 2: Using Environment Variables (Recommended)
```bash
export TELEGRAM_API_ID=your_api_id
export TELEGRAM_API_HASH=your_api_hash
export TELEGRAM_CHAT_ID=@username
export TELEGRAM_COORDINATES=120,25
python telegramLocation.py
```

### Method 3: Using .env File
1. Create a `.env` file and fill in all required parameters:
```
TELEGRAM_API_ID=your_api_id
TELEGRAM_API_HASH=your_api_hash
TELEGRAM_CHAT_ID=@username
TELEGRAM_COORDINATES=120,25
```
2. Run `python telegramLocation.py`

### Method 4: Using Docker (Recommended for production)
```bash
# Build the Docker image
docker build -t telegram-location .

# Run with parameters
docker run --rm -it \
  -e TELEGRAM_API_ID=your_api_id \
  -e TELEGRAM_API_HASH=your_api_hash \
  -e TELEGRAM_CHAT_ID=@username \
  -e TELEGRAM_COORDINATES=120,25 \
  -v $(pwd)/sessions:/app/sessions \
  telegram-location
```

## Usage

Edit the corresponding file based on your chosen method:

### Method 1: Direct Code Editing
Edit the `telegramLocation.py` file:
- Replace `api_id` and `api_hash` with your values
- Replace `chat_id` with your target recipient
- Modify `latitude` and `longitude` to your desired location coordinates

### Method 2: Using External Files
Edit the corresponding program file:
- Replace `chat_id` with your target recipient
- Modify `latitude` and `longitude` to your desired location coordinates

Run the program:
```bash
# Method 1
python telegramLocation.py

# Method 2
docker run --rm -it -e TELEGRAM_API_ID=your_api_id -e TELEGRAM_API_HASH=your_api_hash -e TELEGRAM_CHAT_ID=@username -e TELEGRAM_COORDINATES=120,25 -v $(pwd)/sessions:/app/sessions telegram-location
```

## Docker Usage

### Environment Variables

| Variable Name | Required | Description | Example |
|---------------|----------|-------------|---------|
| `TELEGRAM_API_ID` | ✅ | Telegram API ID | `api_id` |
| `TELEGRAM_API_HASH` | ✅ | Telegram API Hash | `"api_hash"` |
| `TELEGRAM_CHAT_ID` | ✅ | Target chat ID | `"@username"` or `123456789` |
| `TELEGRAM_COORDINATES` | ✅ | Coordinates (longitude,latitude) | `"120,25"` |

### Docker Methods

#### Method 1: Using the interactive run script (Easiest)
```bash
# Run the script and enter parameters when prompted
./run.sh
```

The script will interactively ask you to enter:
- API ID
- API Hash  
- Chat ID (e.g., @username or 123456789)
- Coordinates (longitude,latitude e.g., 120,25)

**Note**: On first run, you'll need to enter your phone number and verification code when prompted by Telegram.

#### Method 2: Direct docker run with interactive terminal
```bash
# Build the image
docker build -t telegram-location .

# Run with interactive terminal
docker run --rm -it \
  -e TELEGRAM_API_ID=your_api_id \
  -e TELEGRAM_API_HASH=your_api_hash \
  -e TELEGRAM_CHAT_ID=@username \
  -e TELEGRAM_COORDINATES=120,25 \
  -v $(pwd)/sessions:/app/sessions \
  telegram-location
```

#### Method 3: Using docker-compose with interactive terminal
```bash
# Set environment variables
export TELEGRAM_API_ID=your_api_id
export TELEGRAM_API_HASH=your_api_hash
export TELEGRAM_CHAT_ID=@username
export TELEGRAM_COORDINATES=120,25

# Run with interactive terminal
docker-compose up --build
```

### Quick Start Example

```bash
# Build the image
docker build -t telegram-location .

# Run with your parameters
docker run --rm -it \
  -e TELEGRAM_API_ID=your_api_id \
  -e TELEGRAM_API_HASH=your_api_hash \
  -e TELEGRAM_CHAT_ID=@your_username \
  -e TELEGRAM_COORDINATES=120,25 \
  -v $(pwd)/sessions:/app/sessions \
  telegram-location
```

## Notes

- **Interactive terminal**: Use `-it` flag to enable interactive input
- **First run**: Container will ask for your phone number and verification code
- **Session files**: Will be stored in `./sessions/` directory
- **Environment variables**: All parameters must be set correctly
- **Network connection**: Ensure container can connect to Telegram servers

## Troubleshooting

### Error: Environment variables not found
```
Error: Please set the following environment variables:
- TELEGRAM_API_ID
- TELEGRAM_API_HASH
- TELEGRAM_CHAT_ID
- TELEGRAM_COORDINATES
```
**Solution**: Make sure all required environment variables are set in your docker run command

### Error: Cannot read input
**Solution**: Make sure to use `-it` flag for interactive terminal:
```bash
docker run --rm -it [other_options] telegram-location
```

### Error: Authentication failed
**Solution**: Delete `sessions/` directory and re-authenticate

### Error: Network connection issues
**Solution**: Check network connection and firewall settings