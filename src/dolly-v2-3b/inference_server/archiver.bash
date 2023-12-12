#!/bin/bash

BIN_MODEL_PATH=$1
BIN_MODEL_NAME=$2

torch-model-archiver --model-name dolly-v2-3b \
                     --version 1.0 \
                     --serialized-file "$BIN_MODEL_PATH/$BIN_MODEL_NAME" \
                     --handler "/$SOURCE_DIR/main.py" \
                     --extra-files "$BIN_MODEL_PATH/special_tokens_map.json,$BIN_MODEL_PATH/tokenizer.json,$BIN_MODEL_PATH/tokenizer_config.json" \
                     --export-path "$BIN_MODEL_PATH" -f
