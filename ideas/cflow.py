import subprocess

def generate_flow_graph(source_file, output_file):
    """Generate a flow graph using cflow and save it to a file."""
    try:
        with open(output_file, 'w') as outfile:
            subprocess.check_call(['cflow', source_file], stdout=outfile)
        print(f"Flow graph generated and saved to {output_file}")
    except subprocess.CalledProcessError as e:
        print(f"Failed to generate flow graph: {e}")
        exit(1)

if __name__ == "__main__":
    source_code_file = "source.c"
    flow_graph_file = "flow_graph.txt"

    generate_flow_graph(source_code_file, flow_graph_file)