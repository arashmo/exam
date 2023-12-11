# gunicorn_config.py

# Set the number of worker processes (adjust as needed)
workers = 4

# Set a longer worker timeout to accommodate slow app startup
timeout = 360  # 6 minutes

# Load the app before forking worker processes (preloading)
preload = True

# Set a graceful timeout for worker termination
graceful_timeout = 300  # 5 minutes

# Log settings
accesslog = "-"  # Log to stdout
errorlog = "-"   # Log to stdout
loglevel = "info" # set log level to infro
# Set the host and port for your Flask app
bind = "127.0.0.1:8000"  # Replace with your desired host and port

# Set logging level and log file


