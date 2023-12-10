import os
import torch
from flask import Flask, request, jsonify
from instruct_pipeline import InstructionTextGenerationPipeline
from transformers import AutoModelForCausalLM, AutoTokenizer
app = Flask(__name__)
def load_model():
    downloader_model_name = "databricks/dolly-v2-3b"
    current_directory = os.path.dirname(os.path.abspath(__file__))
    # Get the path to the directory containing pytorch_model.bin from an environment variable
    bin_directory = os.environ.get('BIN_MODEL_PATH')
    local_model_name = os.environ.get('BIN_MODEL_NAME')
    if not bin_directory:
        raise EnvironmentError("BIN_MODEL_PATH environment variable not set.")
    if not bin_directory:
        raise EnvironmentError("BIN_MODEL_PATH environment variable not set.")

    # Path to the pytorch_model.bin file
    model_bin_path = os.path.join(bin_directory, local_model_name)
    if not os.path.exists(model_bin_path):
        raise FileNotFoundError(f"{model_bin_path} does not exist.")
    # Load tokenizer from default location
   #     tokenizer = AutoTokenizer.from_pretrained(model_name, padding_side="left")
    tokenizer = AutoTokenizer.from_pretrained(current_directory, padding_side="left")
    # Load model from the pytorch_model.bin file
    model = AutoModelForCausalLM.from_pretrained(bin_directory, local_files_only=True, device_map="auto", torch_dtype=torch.bfloat16)

    return InstructionTextGenerationPipeline(model=model, tokenizer=tokenizer)

generate_text = load_model()

if __name__ == '__main__': 
    app.run(debug=True)