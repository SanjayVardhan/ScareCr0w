# ScareCr0w

A Tool which finds vulnerabilities in programs, generates patches, and fixes it.

It uses openai api under the hood to find the vulnerabilities.


## V2:
1. Added support for small codebases.
2. Added multiprocessing.
3. A little better vuln detection.

# Lessons Learnt
1. Using OpenAI API/GPT-4 might not be a good approach for complex programs and codebases. 
2. A custom trained LLM is a better option in the long run.
3. Static Analysis before feeding the entire code to gpt is a must, since OpenAI API can get really expensive.

## TODO:
1. Better vuln detection.
2. Patch generation is still not consistent, Need to tweak the parameters.
3. Need to think of a better approach to handle larger codebases. 