# Cub3D parsing tester

This tester is designed to validate the parsing functionality of the Cub3D program. It automatically checks various map files to ensure that Cub3D correctly handles invalid map inputs according to the project specifications. The tester helps identify parsing errors, edge cases, and compliance with required map formats, making it easier to debug and improve the robustness of your Cub3D implementation.


> **⚠️ WARNING:**
> Only invalid maps are tested. Other tests have to be done afterward to fully validate the project.


> **⚠️ WARNING:**
> Detected errors can be resulting of a specific syntax that **I** decided to tag as incorrect. But some of them can be discussed and justified during the correction. **Do not automatically consider a potential error as a failure during the correction!** Try the failed tests manually and discuss it.

## Requirements

The `Cub3D` executable must return an exit code different from `0` (success) and `124` (timeout) and `139` (segfault) when a parsing error occurs.

## Usage

1. **Clone the repository:**
   ```bash
   git clone git@github.com:acardona123/42_tester_cub3d_parsing.git <tester_destination_path>
   ```

2. **Navigate to the tester directory:**
   ```bash
   cd <tester_destination_path>
   ```

3. **Run the tester:**
   - **Option 1:** Provide the path to the directory containing your `Cub3D` executable:
     ```bash
     ./test_maps.sh /path/to/cub3d_directory
     ```
   - **Option 2:** Copy your `Cub3D` executable into the tester directory and run the script without arguments:
     ```bash
     cp /path/to/Cub3D ./Cub3D
     ./test_maps.sh
     ```

## Note
Cub3D uses a graphical library called **mlx** that creates a window as soon as it is initialized, even before textures are imported. Therefore, it is highly likely that during the tests, such windows will be briefly opened.
The tester detects that a parsing error has not been properly managed by finding that the Cub3D program segfaulted or started the game despite the invalidity of the map.

If you find any other parsing test case to add about invalid maps please contact me and i'll be glad to include them.