import os
import sys

def scan_directory_for_j_files(directory, output_file):
    try:
        with open(output_file, 'w') as output:
            for root, _, files in os.walk(directory):
                for file in files:
                    if file.endswith('.j'):
                        file_path = os.path.join(root, file)
                        output.write(f'//! import "{file_path}"\n')
        print(f"Output written to {output_file}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <directory> <output>")
    else:
        directory = sys.argv[1]
        output_file = sys.argv[2]
        scan_directory_for_j_files(directory, output_file)