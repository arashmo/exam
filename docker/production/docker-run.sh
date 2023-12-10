#!/bin/bash 
set -e 
readonly IMAGE_NAME="comprcompr/arash"
readonly IMAGE_TAG="latest"
readonly IMAGE_DEV_TAG="dev"
readonly BIN_MODEL_PATH=/model/model_dev/pytorch_model
readonly BIN_MODEL_VOL=/mnt
readonly BIN_MODEL_NAME="pytorch_model.bin"
readonly SOURCE_DIR="$(pwd)/../../dolly-v2-3b"
# TODO: " have to fixed readonly MEMORY="$(free -m | awk '/Mem/{print $2 - 1024}')"
echo $MEMORY
## create check fucntion impretive not googd
echo $SOURCE_DIR
# Function to run the container in development mode, this mode will map the source dir 
# limit the memory to max possible on the host $
run_dev_mode() {
    docker run -it \
    --network host \
    -e BIN_MODEL_PATH=$BIN_MODEL_PATH\
    -e BIN_MODEL_NAME=$BIN_MODEL_NAME\
    -v $BIN_MODEL_VOL:/model/ \
    -e SOURCE_DIR:$SOURCE_DIR \
    -v $SOURCE_DIR:/source_dev/\
    $IMAGE_NAME:latest\
     bash
    }

# Function to run the container in production mode
run_prod_mode() {
  docker run -it \
    $IMAGE_NAME:$IMAGE_TAG
    -p 8000:8000\
    -v $BIN_MODEL_PATH:/model/ \
   
}

# Check for arguments
case "$1" in
    -v)
        run_dev_mode
        ;;
    -p)
        run_prod_mode
        ;;
    -c)
        run_bash_mode
        ;;
    *)
        echo "Invalid argument. Use -v for dev mode, -p for prod mode, or -c for bash."
        exit 1
        ;;
esac







#docker run -p 5000:5000 -v /mnt/model_dev/:/model  comprcompr/arash:latest
# rather than copyin 
