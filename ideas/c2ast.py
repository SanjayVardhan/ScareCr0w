import sys
from clang.cindex import Index, CursorKind

def print_ast(node, indent=0):
    """Recursively print the AST nodes."""
    text = node.spelling or node.displayname
    kind = str(node.kind)[str(node.kind).index('.')+1:]
    print('  ' * indent + f'{kind}: {text}')

    for child in node.get_children():
        print_ast(child, indent + 1)

def parse_file(filename):
    """Parse the given C file and print its AST."""
    index = Index.create()
    translation_unit = index.parse(filename)
    print_ast(translation_unit.cursor)

if __name__ == '__main__':
    path = input("Enter the path of the file: ").replace("\n", "")
    parse_file(path)