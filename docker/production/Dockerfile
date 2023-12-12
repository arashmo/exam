# Use an official Python runtime as a parent image
#FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel as base
FROM python:3.8 as base
ARG SOURCE_DIR
ENV PYTHONUNBUFFERED 1
RUN apt update && apt install openjdk-17-jdk -y 
# torchserv needed java
# lets keep the image as small as possible and load the model into the stroage through a proxy downloader 
# RUN git lfs install
WORKDIR /src/app
COPY $SOURCE_DIR /src/app/
ENV SOURCE_DIR=$SOURCE_DIR
# Install any needed packages specified in requirements.txt
#RUN  pip install --upgrade pip && \
RUN pip install --no-cache-dir -r requirements.txt
# Make port 80 available to the world outside this container
EXPOSE 8000
# Define environment variable
ENV NAME World
# Run app.py when the container launches
CMD ["/bin/bash", "-c", "gunicorn --config config.py main:app"]