Author: Soop

Instruction on how to run and play the game:
1. Run AcademiaSim.exe

**For viewing code**
In order to access the .gd scripts as well as the .tscn, Godot Engine must be installed preferably to view the codes as well as the game's backend structure.

Download link: https://godotengine.org/

Note: This project is created using Godot 4.2.2

Instruction:
1. Go to the download link and click on Download Latest:

2. To Setup on Viewing the Code and Debugging:
a) Create New Project after opening Godot by clicking on +New
b) Name your project name
c) For Project Path, select the directory containing the project files(all the files listed below) for example:
C:\Users\wilem\OneDrive\Desktop\Desktop Apps\UNM\Year 3\FYP\MyFYP\COMP3025_20297525
d) Choose Renderer as Compatibility and click on Create & Edit
e) If Godot gives warnings on files containing non-empty folder, press ok
f) Now that you are in the engine the following steps will setup the project on Godot

3. To Setup Compiling the Project:
a) Go to Project> Project Settings and select Autoload
b) Click on the 'file' icon next to Node Name and Select: GameState.gd under scripts
c) REMEMBER TO: Click on Add
d) If you have done correct, you should see GameState now listed, by default Global Variable checkbox for GameState.gd is enabled
e) Repeat step b) to d) by selecting AudioManager.gd
f) Now Go to Project> Project Settings, on your left you should see a dropdown list
g) On Application > Run, click on the 'file' icon and navigate to scenes
h) Select sceneMainMenu.tscn and click on Open
i) CTRL + S to refresh and reload, and you should see no warnings or errors
j) Click on the start button on to right to start compiling the project!


If any errors encountered while compiled, it is most likely the directory changed, please ensure it is done correctly.
I have tested that the application compiles and runs well and contains no errors or debug errors.


This folder contains the following files:

AcademiaSim.exe - The executable file for the application.

AcademiaSim.pck - The package file that contains all the data used by the executable.

assets - This folder contains all the assets used in the game like graphics, sounds, etc.

scenes - Contains the scene files used in my Godot project.

scripts - Contains the GDScript files, which are crucial for the logic and functioning of my game.

icon.svg and icon.svg.import - These are the icon files for my game, for identifying my application visually.

project.godot - The project file that includes configuration settings and other important details needed to open the project in Godot.

export_presets.cfg - Configuration file for export settings, which is important if the project needs to be re-exported or modified for different platforms.

**Extra Notes**
-Instruction 3 is done to ensure that Godot knows that Gamestate.gd and AudioManager are set as the global variable and it will access these two files

-Additionally, instruction 3 also sets the project's main scene as Main Menu so that when you open the project it shows Main Menu scene
