# Docker Build Script Usage Guide

## Overview
This script automates the process of building a Docker image for your project. It synchronizes your project directory to a temporary location, builds a Docker image using this directory, and then pushes the image to a Docker registry.

## Prerequisites
- Docker installed and running on your machine.
- Bash shell environment (commonly available on Linux and macOS).
- Your project directory with a Dockerfile at the same level as this script.

## Steps to Use
1. **Place the Script**: Ensure the script is located beside your Dockerfile.

2. **Prepare Your Project**: Your project should be in a directory that is accessible from the script's location.

3. **Run the Script**: 
   - Open a terminal.
   - Navigate to the directory where the script is located.
   - Run the script using the command:
     ```bash
     ./build_script.sh [path-to-your-project]
     ```
     Replace `[path-to-your-project]` with the relative or absolute path to your project directory. If omitted, the script uses a default path "../../dolly-v2-3b".

4. **Enter Docker Credentials**: 
   - When prompted, enter your Docker registry username and password. This is required for pushing the built image to the Docker registry.

5. **Build and Push**: The script will build the Docker image and then push it to your specified Docker registry.

## Notes
- The script will create a temporary directory to store your project's files during the build process. This directory is automatically removed after the build is completed.
- If you encounter any errors during the build, the script will stop execution and display an error message.
- The Docker image is tagged with the name and tag specified in the script (`comprcompr/arash:latest` by default).
- It's crucial that your Dockerfile includes an `ARG` directive to accept the project directory as an argument. This ensures that the script can dynamically specify the project directory during the build process.

This script simplifies the Docker image building process, ensuring a consistent and error-free build and deployment workflow.
