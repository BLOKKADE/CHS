import os
import re

# Filepath to the main file containing the globals section
main_file_path = r"c:\CHS\CHS\Trigger\03-Data\01-Generic\IdLibrary.j"
chs_folder_path = r"c:\CHS\CHS"

# Regex to extract variables from the globals section
globals_pattern = re.compile(r"constant integer (\w+)\s+=\s+'([A-Za-z0-9]+)'")

def extract_globals(file_path):
    """Extract variable names and values from the globals section."""
    with open(file_path, "r", encoding="utf-8") as file:
        content = file.read()

    # Find all matches in the globals section
    matches = globals_pattern.findall(content)
    return {value: name for name, value in matches}

def replace_values_in_files(folder_path, replacements):
    """Search all .j files in the folder and replace values with variable names."""
    for root, _, files in os.walk(folder_path):
        for file in files:
            if file.endswith(".j"):
                file_path = os.path.join(root, file)
                if not should_process_file(file_path):
                    continue
                process_file(file_path, replacements)

def should_process_file(file_path):
    """Check if the file should be processed."""
    return os.path.abspath(file_path) != os.path.abspath(main_file_path)

def process_file(file_path, replacements):
    """Read, update, and write the file content."""
    content = read_file(file_path)
    updated_content = replace_values(content, replacements)
    if content != updated_content:
        write_file(file_path, updated_content)
        print(f"Updated file: {file_path}")

def read_file(file_path):
    """Read the content of a file."""
    with open(file_path, "r", encoding="utf-8") as f:
        return f.read()

def replace_values(content, replacements):
    """Replace values in the content with variable names."""
    for value, name in replacements.items():
        content = re.sub(rf"'{value}'", name, content)
    return content

def write_file(file_path, content):
    """Write updated content back to the file."""
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content)

def main():
    # Step 1: Extract globals from the main file
    print("Extracting globals...")
    replacements = extract_globals(main_file_path)
    print(f"Found {len(replacements)} globals.")

    # Step 2: Replace values in all .j files in the CHS folder
    print("Replacing values in .j files...")
    replace_values_in_files(chs_folder_path, replacements)
    print("Replacement complete.")

if __name__ == "__main__":
    main()