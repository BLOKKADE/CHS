# CHS 1.9.30

This is the map and code of the Warcraft 3 map Custom Hero Survival.

WARNING: CHS.W3X is readable in the World Editor but cannot be saved without first following the "Setup the map" tutorial below.

Setup the map:
1. Download the project and save it in a directory
2. Open command line to the project directory (With explorer open to the project directory, Right Click > Open in Windows Terminal)
3. Copy paste: ./CreateImportFile.exe "Trigger" "TriggerList.j" and press enter. Close the command line.
4. Open "CHS.w3x" in the Warcraft 3 World Editor
5. Go to the trigger editor and open the "Import" trigger in the "JASS" category.
6. Replace the path in 
//! import "C:\Users\Eigenaar\Projects\CHS\TriggerList.j"
with the path of the TriggerList.j file in the project you saved.
5. Save the map, if it doesn't give an error you're done.

To include new .j files (jass code files) in the map you can use one of these 3 methods:

Manually:
1. Get the path of the file you created.
2. Add it into the TriggerList.j file
3. Save the map in the editor.
4. Success

Automatically (with VS Code)
1. Open the project in vscode
2. Ensure the file you've created is somewhere in the "Trigger" directory in the project
2. Run the "Create Import File" task (or press Ctrl+Shift+B)
3. Success

Automatically (without VS Code)
1. Ensure you have all the code you want to be imported in (sub)folders of one big folder.
2. Open command line and start CreateImportFile.exe. To do that it requires 2 arguments:
  2a. Argument 1: The folder of files you want to import. For example "C:/Warcraft/CHS/Trigger"
  2b. Argument 2: The path and name of the "import file" you want it to create. For example: "TriggerList.j"
  
For example you can start it like this: ./CreateImportFile.exe "C:/Warcraft/CHS/Trigger" "TriggerList.j"
3. Success

To make the jass compile command work:
1. Unzip the JassHelper.zip in the JassHelper Req folder into the directory above the CHS directory (this project). 
  so it ends up looking like this:
    C:\
      CHS
        CHS
          Readme.md
          CHS.w3x
          -all other files in the project-
        JassHelper
          common.j
          Blizzard.j
          JassHelper
            -lots of files-
2. Run the build task