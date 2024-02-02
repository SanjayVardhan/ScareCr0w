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


# Upload a file with an "assistants" purpose
file = client.files.create(
  file=open("source.c", "rb"),
  purpose='assistants'
)

# Create an assistant using the file ID
assistant = client.beta.assistants.create(
  instructions="You are an advanced code analysis tool. Your task is to review C/C++ source code for potential memory corruption vulnerabilities, such as buffer overflows, stack overflows, heap corruption, use-after-free issues, and uninitialized memory accesses. After identifying any vulnerabilities, generate a diff file in the standard patch format to suggest fixes for these issues. The diff should not include line numbers. Focus on accuracy and relevance, providing context-aware solutions.",
  model="gpt-4-1106-preview",
  tools=[{"type": "code_interpreter"}],
  file_ids=[file.id]
)



source_path = "source.c"
# testcase_path = input("Enter Testcase Path: ").replace("\n", "")

# verify(source_path, testcase_path)

with open(source_path, 'r') as f:
    lines = f.readlines()

buffer = [f'{i+1}: {line}' for i, line in enumerate(lines)]
source_code = ''.join(buffer)


thread = client.beta.threads.create(
  messages=[
    {
      "role": "user",
      "content": "filename: " + source_path + "\nsource:\n" + source_code,
      "file_ids": [file.id]
    }
  ]
)

# Run

run = client.beta.threads.runs.create(
  thread_id=thread.id,
  assistant_id=assistant.id,
  model="gpt-4-1106-preview",
  tools=[{"type": "code_interpreter"}]
)

print(run)

