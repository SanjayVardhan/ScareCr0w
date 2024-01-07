import os
import subprocess
import re
import multiprocessing
from openai import OpenAI

api_key = os.environ["OPENAI_KEY"]
client = OpenAI(api_key=api_key)

def compile_c_program(source_file):
    compile_command = ["gcc", source_file, "-o", "program"]
    compilation_result = subprocess.run(compile_command, capture_output=True, text=True)
    return compilation_result

def execute_c_program():
    execute_command = ["./program"]
    execution_result = subprocess.run(execute_command, capture_output=True, text=True)
    return execution_result
def extract_diff(input_text):
    pattern = r'```diff(.+?)```'
    match = re.search(pattern, input_text, re.DOTALL)    
    if match:
        diff_content = match.group(1).strip() 
        return diff_content
    else:
        print("idk might work")
        print(input_text)
        return input_text

def apply_patch(source_file, patch_data):
    patch_file = source_file + '.patch'
    with open(patch_file, 'w') as f:
        f.write(patch_data)

    result = subprocess.run(["patch", "-u", source_file, patch_file], capture_output=True, text=True)
    os.remove(patch_file)  # Clean up patch file
    return result

def analyze_file(source_file):
    with open(source_file, 'r') as f:
        source_code = f.read()

    if client:
        chat_completion = client.chat.completions.create(
            messages=[
                {
                    "role": "system",
                    "content": "You are an advanced code analysis tool. Your task is to review C/C++ source code for potential memory corruption vulnerabilities, such as buffer overflows, stack overflows, heap corruption, use-after-free issues, and uninitialized memory accesses. After identifying any vulnerabilities, generate a diff file in the standard Unix patch format to suggest fixes for these issues. Ensure the diff adheres to the standard format with headers, hunk headers, and change indicators. Do not include line numbers in the diff. Focus on accuracy and relevance, providing context-aware solutions."
                },
                {
                    "role": "user",
                    "content": f"filename: {source_file}\nsource:\n{source_code}"
                }
            ],
            model="gpt-4-1106-preview",
        )
        diff_data = chat_completion.choices[0].message.content
        return diff_data
    else:
        print("OpenAI API key not set.")
        return None

def process_file(file_path):
    print(f"Analyzing {file_path}")
    res = analyze_file(file_path)
    if res:
        diff_data = extract_diff(res)
        # print(diff_data)
        patch_result = apply_patch(file_path, diff_data)
        if patch_result.returncode == 0:
            print(f"Patch applied successfully to {file_path}")
        else:
            print(f"Failed to apply patch to {file_path}: {patch_result.stderr}")

def traverse_directories(root_dir):
    # Create a process pool
    with multiprocessing.Pool() as pool:
        tasks = []

        for subdir, dirs, files in os.walk(root_dir):
            for file in files:
                if file.endswith(('.c', '.cpp', '.h')):
                    file_path = os.path.join(subdir, file)
                    # Add the file processing task to the pool
                    task = pool.apply_async(process_file, (file_path,))
                    tasks.append(task)

        # Wait for all tasks to complete
        for task in tasks:
            task.get()  # This will block until the specific task is completed

def main():
    root_dir = input("Enter the root directory of the codebase: ").strip()
    traverse_directories(root_dir)

if __name__ == "__main__":
    multiprocessing.freeze_support()  # For Windows support
    main()

