import subprocess
import re

def compile_to_llvm_ir(source_file, output_file):
    """Compile C/C++ source code to LLVM IR using Clang."""
    try:
        subprocess.check_call(['clang', '-S', '-emit-llvm', source_file, '-o', output_file])
        print(f"Compiled {source_file} to LLVM IR {output_file}")
    except subprocess.CalledProcessError as e:
        print(f"Failed to compile {source_file} to LLVM IR: {e}")
        exit(1)

def extract_functions(llvm_ir):
    """Extract functions and their names from LLVM IR."""
    function_pattern = r'define [^\{]+\{[^}]+\}'
    function_ir = re.findall(function_pattern, llvm_ir, re.DOTALL)

    function_names = []
    for func in function_ir:
        # Find the function name
        match = re.search(r'define [^\s]+ @(\w+)', func)
        if match:
            function_names.append(match.group(1))
        else:
            function_names.append("Unknown")

    return list(zip(function_names, function_ir))

def print_functions(functions):
    """Print the function names and their LLVM IR."""
    for i, (name, function) in enumerate(functions, start=1):
        print(f"Function {i} ({name}):\n{function}\n")

if __name__ == "__main__":
    source_code_file = "source.c"
    llvm_ir_file = "output.ll"

    compile_to_llvm_ir(source_code_file, llvm_ir_file)

    with open(llvm_ir_file, 'r') as file:
        llvm_ir = file.read()

    functions = extract_functions(llvm_ir)
    print_functions(functions)