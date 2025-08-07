FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements file from parent directory
COPY ./requirements.txt .

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy program files from parent directory
COPY ./telegramLocation.py .

# Create sessions directory
RUN mkdir -p /app/sessions

# Execute command
CMD ["python", "telegramLocation.py"] 