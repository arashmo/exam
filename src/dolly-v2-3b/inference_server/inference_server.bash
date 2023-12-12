#!/bin/bash
BIN_MODEL_ARCH = $1
torchserve --start --ncs --model-store $BIN_MODEL_PATH \
--models mymodel=$BIN_MODEL_ARCH --ts-config $SOURCE_DIR/inference_server/torch.conf 