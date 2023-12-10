import os
import torch
from transformers import AutoModelForCausalLM, AutoTokenizer, TextGenerationPipeline
from ts.torch_handler.base_handler import BaseHandler

class LLMHandler(BaseHandler):
    def __init__(self):
        super(LLMHandler, self).__init__()
        self.initialized = False

    def initialize(self, context):
        # Retrieve model directory from properties if set, otherwise use environment variables
        properties = context.system_properties
        model_dir = properties.get("model_dir", os.environ.get('BIN_MODEL_PATH'))
        local_model_name = os.environ.get('BIN_MODEL_NAME')

        if not model_dir:
            raise EnvironmentError("BIN_MODEL_PATH environment variable not set.")
        if not local_model_name:
            raise EnvironmentError("BIN_MODEL_NAME environment variable not set.")

        model_bin_path = os.path.join(model_dir, local_model_name)
        if not os.path.exists(model_bin_path):
            raise FileNotFoundError(f"{model_bin_path} does not exist.")

        current_directory = os.path.dirname(os.path.abspath(__file__))
        self.tokenizer = AutoTokenizer.from_pretrained(model_dir, padding_side="left")
        self.model = AutoModelForCausalLM.from_pretrained(
            model_dir, 
            local_files_only=True, 
            device_map="auto", 
            torch_dtype=torch.bfloat16
        )

        self.pipeline = TextGenerationPipeline(model=self.model, tokenizer=self.tokenizer)
        self.initialized = True

    def preprocess(self, data):
        # Assuming the instruction is sent as a part of the request
        instruction = data[0].get("data") or data[0].get("body")
        if not instruction:
            raise ValueError("No instruction provided")
        return instruction

    def inference(self, instruction):
        with torch.no_grad():
            generated_text = self.pipeline(instruction, max_length=50)
        return [generated_text]

    def postprocess(self, inference_output):
        # Postprocessing step to format the output as desired
        return inference_output

# The main function is not needed for TorchServe, but can be kept for local testing
if __name__ == "__main__":
    handler = LLMHandler()

    # Manually initialize the handler as TorchServe would do
    class MockContext:
        def __init__(self):
            self.system_properties = {
                "model_dir": "/model/model_dev/pytorch_model"  # Set this to the path of your model directory
            }

    # Create a mock context and initialize the handler
    mock_context = MockContext()
    handler.initialize(mock_context)

    # Test instruction
    test_instruction = "Explain the theory of relativity"

    # Now you can call inference
    print("Model Output:", handler.inference(test_instruction)[0])