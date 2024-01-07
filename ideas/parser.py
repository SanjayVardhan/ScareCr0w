import os
import re
import networkx as nx
import matplotlib.pyplot as plt
from typing import Set, Dict

def read_source_file(file_path: str) -> str:
    """Read the contents of a C/C++ source file."""
    with open(file_path, 'r') as file:
        return file.read()

def find_functions(code: str) -> Set[str]:
    """Find function definitions in the C/C++ code."""
    function_pattern = r'\b[a-zA-Z_][a-zA-Z0-9_]*\s+[a-zA-Z_][a-zA-Z0-9_]*\s*\([^)]*\)\s*\{'
    matches = re.finditer(function_pattern, code, re.MULTILINE)
    return set(match.group().split()[1].split('(')[0] for match in matches)

def find_function_calls(code: str, function_names: Set[str]) -> Dict[str, Set[str]]:
    """Find calls to functions in the code."""
    calls = {fn_name: set() for fn_name in function_names}
    for fn_name in function_names:
        pattern = rf'\b{fn_name}\s*\('
        matches = re.finditer(pattern, code)
        for match in matches:
            caller_line = code[:match.start()].splitlines()[-1]
            caller_name = re.search(r'[a-zA-Z_][a-zA-Z0-9_]*\s*$', caller_line)
            if caller_name:
                caller = caller_name.group().strip()
                if caller in function_names:
                    calls[caller].add(fn_name)
    return calls

def build_and_draw_graph(function_calls: Dict[str, Set[str]]):
    """Build and draw a graph from the function calls."""
    G = nx.DiGraph()
    for caller, callees in function_calls.items():
        for callee in callees:
            G.add_edge(caller, callee)

    plt.figure(figsize=(12, 8))
    nx.draw(G, with_labels=True, node_color='lightblue', font_size=10, node_size=2000)
    plt.title("Function Call Graph")
    plt.show()

def process_codebase(directory: str):
    """Process all C/C++ files in a given directory."""
    all_functions = set()
    all_function_calls = {}

    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(('.c', '.cpp', '.h', '.hpp')):
                file_path = os.path.join(root, file)
                code = read_source_file(file_path)
                functions = find_functions(code)
                all_functions.update(functions)

    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(('.c', '.cpp', '.h', '.hpp')):
                file_path = os.path.join(root, file)
                code = read_source_file(file_path)
                function_calls = find_function_calls(code, all_functions)
                for caller, callees in function_calls.items():
                    if caller in all_function_calls:
                        all_function_calls[caller].update(callees)
                    else:
                        all_function_calls[caller] = callees

    build_and_draw_graph(all_function_calls)
if __name__ == "__main__":
    codebase_path = input("Enter Path: ").replace("\n", "")
    process_codebase(codebase_path)
