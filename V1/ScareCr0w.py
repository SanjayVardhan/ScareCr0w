from openai import OpenAI
import sys
import re
import subprocess
import pwn
import os


api_key = os.environ["OPENAI_KEY"] 
client = OpenAI(
    api_key=api_key,
)

def compile_c_program(source_file):
    compile_command = ["gcc", source_file, "-o", "program"]
    compilation_result = subprocess.run(compile_command, capture_output=True, text=True)

    if compilation_result.returncode != 0:
        return {"success": False, "error": compilation_result.stderr, "output": compilation_result.stdout}

    return {"success": True}

def execute_c_program(testcase_file):
    execute_command = f"./program < {testcase_file}"
    execution_result = subprocess.run(execute_command, shell=True, capture_output=True, text=True)

    if execution_result.returncode != 0:
        return {"success": False, "error": execution_result.stderr, "output": execution_result.stdout}

    return True

def verify(source_file, testcase_file):
    compile_result = compile_c_program(source_file)
    if compile_result['success']:
        execute_result = execute_c_program(testcase_file)
        if execute_result:
            print("Program executed successfully.")
            return True
    else:
        print(compile_result)
        return False


def apply_patch1(source_file, patch_file):
    #TODO
    for i in range(3):
        result = subprocess.run(["patch","-t","-F50", source_file, patch_file], capture_output=True, text=True)
    if result.returncode == 0:
        print('Patch applied successfully.')
        return True
    else:
        print('Output:', result.stdout)
        print('Error:', result.stderr)
        return False

def extract_diff_and_write_to_file(input_text):
    pattern = r'```diff(.+?)```'
    # pattern1 = r'```(.+?)```'
    match = re.search(pattern, input_text, re.DOTALL)
    # match2 = re.search(pattern1, input_text, re.DOTALL)
    
    if match:
        diff_content = match.group(1).strip() 
        with open('patch.diff', 'w') as f:
            f.write(diff_content)
    # elif match2:
    #     diff_content = match2.group(1).strip()
    #     with open('patch.diff', 'w') as f:
    #         f.write(diff_content)
    else:
        # write input text to file
        with open('patch.diff', 'w') as f:
            f.write(input_text)
            print("idk might work")
        # print("Looks like there is no vulnerability in the code.")
        # exit()

source_path = input("Enter Path: ").replace("\n", "")
testcase_path = input("Enter Testcase Path: ").replace("\n", "")

# verify(source_path, testcase_path)

with open(source_path, 'r') as f:
    lines = f.readlines()

buffer = [f'{i+1}: {line}' for i, line in enumerate(lines)]
source_code = ''.join(buffer)

print("[+] Source Code Read Successfully")

chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "system",
            "content": "You are an advanced code analysis tool. Your task is to review C/C++ source code for potential memory corruption vulnerabilities, such as buffer overflows, stack overflows, heap corruption, use-after-free issues, and uninitialized memory accesses. After identifying any vulnerabilities, generate a diff file in the standard patch format to suggest fixes for these issues. The diff should not include line numbers. Focus on accuracy and relevance, providing context-aware solutions."
        },
        {
            "role": "user",
            "content": "filename: " + source_path + "\nsource:\n" + source_code
        }
    ],
    model="gpt-4",
)

diff_data = chat_completion.choices[0].message.content
# print(diff_data)

print("\n[+] Got the diff content.\n")

extract_diff_and_write_to_file(diff_data)
print("\n[+] Diff file generated.\n")

patch_res = apply_patch1(source_path, 'patch.diff')

if patch_res:
    print("\n[+] Patch applied successfully.\n")
    verify(source_path, testcase_path)
else:
    print("\n[+] Patch failed.\n")
    exit()