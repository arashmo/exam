#!/bin/bash 
set -e
# TODO: create a dev builder, production ready builder --flags here 
#docker system prune -a -f && echo "docker system prune done"
# TODO: # TODO: check if model.bin exist inside the  and size is larger than 5G 
readonly PROJECT_DIR="${1:-"../../src/dolly-v2-3b"}"
readonly IMAGE_NAME="${2:-"comprcompr/arash"}"
readonly IMAGE_TAG="${3:-"latest"}"
readonly HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readonly DOCKER_REGISTRY_URL="https://index.docker.io/v1/"
readonly CACHEBUST=$(date +%s)
## change it to the docker relative path to the script dir if same just type HERE here :)
DOCKERFILE="$HERE"
BUILD_CONTEXT="$HERE/build-context"
# Create build context directory
mkdir -p "$BUILD_CONTEXT"
BUILD_CONTEXT_PROJECT="./build-context/$(basename "${PROJECT_DIR}")"
# add auto docker volume generator
rsync -av  --exclude=pytorch_model.bin --exclude=.git   "$PROJECT_DIR" "$BUILD_CONTEXT"
# add it later it is very slow  

DOCKER_BUILDKIT=1 docker build\
 --build-arg $CACHEBUST\
 --build-arg SOURCE_DIR=${BUILD_CONTEXT_PROJECT}\
 -t $IMAGE_NAME:$IMAGE_TAG "$DOCKERFILE"

if [[ $? -eq 0 ]]; then
 echo "Docker image "${IMAGE_NAME}":"${IMAGE_TAG}" built successfully."
 else
    echo "Error: Docker image build failed."
    exit 1
fi
# let's keep it clean removing BUILD_CONTEXT
rm -rf "$BUILD_CONTEXT"
# Ask user if they want to push the image to the registry
echo -n "Images saved do you need to push it to registry as well? (y/n):"
read push_response && echo "the response is $push_response"
case $push_response in
    [Yy]* )
        echo "Please enter your Docker registry credentials."
        read -p "Username: " docker_username
        read -p "Password: " docker_password
        echo  $docker_password | docker login --username $docker_username --password-stdin $DOCKER_REGISTRY_URL
        if [ $? -ne 0 ]; then
            echo "Error: Docker login failed."
            exit 1
        fi
        docker push $IMAGE_NAME:$IMAGE_TAG
        echo "Docker image pushed to the registry."
        ;;
    [Nn]* )
        echo "Docker image not pushed to the registry."
        ;;
    * )
        echo "Invalid response. Exiting without pushing to the registry."
        exit 1
        ;;
esac
