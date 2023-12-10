#!/bin/bash 
readonly IMAGE_NAME="ubuntu"
readonly IMAGE_TAG="latest"
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
## change it to the docker relative path to the script dir if same just type HERE here :)
DOCKERFILE_PATH="$HERE"
# let's login to my repo for this 
echo "Please enter your Docker registry credentials."
read -p "Username: " docker_username
read -sp "Password: " docker_password

# not necessary but safer
DOCKER_REGISTRY_URL="https://index.docker.io/v1/"

# Log into Docker
echo "Logging into Docker..."
echo -n $docker_password | docker login --username $docker_username --password-stdin $DOCKER_REGISTRY_URL
if [ $? -ne 0 ]; then
    echo "Error: Docker login failed."
    exit 1
fi


echo " building now"
docker build -t $IMAGE_NAME:$IMAGE_TAG $DOCKERFILE_PATH

if [[ $? -eq 0 ]]; then
    echo "Docker image '$IMAGE_NAME:$IMAGE_TAG' built successfully."
else
    echo "Error: Docker image build failed."
    exit 1
fi
# docker push 
docker push $IMAGE_NAME:$IMAGE_TAG