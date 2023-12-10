from llm_handler import LLMHandler


def test_handler(handler, sample_text):
    print("Input Text:", sample_text)
    generated_output = handler.inference(sample_text)
    return generated_output

# Set the model name or path
model_name_or_path = '/source_dev'  # Replace with the actual path inside the docker 

# Create a handler instance
handler = LLMHandler(model_name_or_path)

# Test with a sample text
sample_text = "Your sample input text here"
output = test_handler(handler, sample_text)
print("Generated Output:", output)

# Set the path to your model

