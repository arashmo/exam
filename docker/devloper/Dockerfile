# Use an official Ubuntu base image
FROM ubuntu:latest

# Install git and git-lfs
RUN apt-get update && \
    apt-get install -y git git-lfs && \
    git lfs install

# Any other setup you need
# ...
# for the huggingn face lets create a pub key
RUN mkdir /root/.ssh && \
    ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -N "" && \
    cat /root/.ssh/id_rsa.pub > /root/.ssh/public_key

# Print the public key when the container starts
# Define default command (optional)

RUN --mount=type=bind,target=/model,source=/path/on/host/machine 
WORKDIR /model/
RUN [ ! -f pytorch_model.bin ] && curl -o pytorch_model.bin https://huggingface.co/databricks/dolly-v2-3b/resolve/main/pytorch_model.bin 
CMD cat /root/.ssh/public_key && tail -f /dev/null