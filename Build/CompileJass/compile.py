import shutil
import subprocess
from pathlib import Path

# Define paths
JASS_FOLDER = Path("../../Trigger")
COMMON_J = Path("./JassHelper/common.jh")
BLIZZARD_J = Path("./JassHelper/blizzard.jh")
OUTPUT_J = Path("war3map.j")
LOGS = [
    Path("./logs/currentmapscript.j"),
    Path("./logs/inputwar3map.j"),
    Path("./logs/outputwar3map.j"),
]
BACKUPS = Path("./backups/")
GENERATED_J = Path("collection.j")
JASSHELPER = Path("./JassHelper/JassHelper/jasshelper.exe")
MAIN_FUNCTION_FILE = Path("./Code/main.j")

def create_generated_file():
    """Create the GeneratedJ file from all relevant input files."""
    try:
        input_files = list(JASS_FOLDER.rglob("*.j")) + list(JASS_FOLDER.rglob("*.reqj")) + list(JASS_FOLDER.rglob("*.zn"))
        with GENERATED_J.open("w", encoding="utf-8") as gen_file:
            for file in input_files:
                gen_file.write(file.read_text(encoding="utf-8") + "\n")
            gen_file.write(MAIN_FUNCTION_FILE.read_text(encoding="utf-8"))
        print(f"Generated file created: {GENERATED_J} with {len(input_files)} input files.")
    except Exception as e:
        print(f"Error creating generated file: {e}")


def kill_jasshelper_process():
    """Kill any running jasshelper process."""
    try:
        processes = subprocess.check_output(["tasklist"], shell=True).decode().splitlines()
        for proc in processes:
            if "jasshelper.exe" in proc.lower():
                pid = int(proc.split()[1])
                subprocess.run(["taskkill", "/PID", str(pid), "/F"], shell=True, check=True)
                print(f"Killed jasshelper process with PID: {pid}")
    except subprocess.CalledProcessError as e:
        print(f"Error killing jasshelper process: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")

def run_jasshelper():
    """Run jasshelper to compile the map script and wait for it to close."""
    try:
        params = ['--scriptonly', str(COMMON_J), str(BLIZZARD_J), str(GENERATED_J), str(OUTPUT_J)]
        process = subprocess.Popen([str(JASSHELPER)] + params, shell=True)
        process.wait()  # Wait for the process to complete

        # Wait until no process called jasshelper exists
        while True:
            processes = subprocess.check_output(["tasklist"], shell=True).decode().splitlines()
            if not any("jasshelper.exe" in proc.lower() for proc in processes):
                break

        if process.returncode == 0:
            print("JassHelper ran successfully.")
        else:
            print(f"JassHelper exited with return code: {process.returncode}, {process.pid}")
    except subprocess.CalledProcessError as e:
        print(f"Error running JassHelper: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")


def clean_up():
    """Clean up generated files, logs, and backups."""
    try:
        for file in [GENERATED_J, OUTPUT_J]:
            if file.exists():
                file.unlink()
                print(f"Deleted file: {file}")
        for log in LOGS:
            if log.exists():
                log.unlink()
                print(f"Deleted log file: {log}")
        if BACKUPS.exists():
            shutil.rmtree(BACKUPS)
            print(f"Deleted backups directory: {BACKUPS}")
    except Exception as e:
        print(f"Error during cleanup: {e}")


# Main execution
if __name__ == "__main__":
    try:
        print("Starting script...")
        create_generated_file()
        kill_jasshelper_process()
        run_jasshelper()
    finally:
        clean_up()
        print("Script finished.")