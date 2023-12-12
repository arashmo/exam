import os
import torch
from transformers import AutoModelForCausalLM, AutoTokenizer, TextGenerationPipeline
from ts.torch_handler.base_handler import BaseHandler
from huggingface_hub import HfApi
import re

api = HfApi()

    # Retrieve model directory from properties if set, otherwise use environment variables
    properties = context.system_properties
    model_dir = properties.get("model_dir", os.environ.get('BIN_MODEL_PATH'))
    local_model_name = os.environ.get('BIN_MODEL_NAME')
    current_directory = os.path.dirname(os.path.abspath(__file__))
    model_bin_path = os.path.join(model_dir, local_model_name)
    arch_file_path = os.path.join(model_dir, f"{local_model_name}.mar")

    if not model_dir:
        raise EnvironmentError("BIN_MODEL_PATH environment variable not set.")
    if not local_model_name:
        raise EnvironmentError("BIN_MODEL_NAME environment variable not set.")

    if not os.path.exists(model_bin_path):
        print(f"{model_bin_path} does not exist. Downloading the model...")
        # Convert hyphens to slashes in the model name

        model_name_with_slashes = re.sub(r'-', '/', local_model_name)
       # model = Automodel.from_pretrained(model_name_with_slashes)
        model_files = api.model_list(model_name_with_slashes, revision="main")
    for model_file in model_files:
        file_url = model_file.rfilename
        api.download_file(model_name_with_slashes, file_url, os.path.join(model_dir, file_url))  
        os.rename(os.path.join(model_dir, 'pytorch_model.bin'), local_model_name)
    else:
     # Check if the .mar file already exists
    arch_file_path = os.path.join(model_dir, f"{local_model_name}.mar")
    if not os.path.exists(arch_file_path):
        print(f"{arch_file_path} does not exist. Archiving the model...")
        # create a model archive based on main.py using toch-model-archiver
        os.system(f"bash {current_directory}/inference_server/archiver.bash {model_dir} {local_model_name}")
        if os.path.exists(arch_file_path):
            print(f"{arch_file_path} created successfully. Starting the server...")
            # Run the script to start the server
            os.system(f"bash {current_directory}/inference_server/inference_server.bash {arch_file_path}")
        else:
            print(f"{arch_file_path} does not exist. Server cannot be started.")
