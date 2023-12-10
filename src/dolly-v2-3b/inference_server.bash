#!/bin/bash
torchserve --start --ncs --model-store $BIN_MODEL_PATH \
--models mymodel=dolly-v2-3b.mar --ts-config /src/app/inference_server/torch.conf 