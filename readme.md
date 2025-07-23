# Cub3D parsing tester

This tester is designed to validate the parsing functionality of the Cub3D program. It automatically checks various map files to ensure that Cub3D correctly handles invalid map inputs according to the project specifications. The tester helps identify parsing errors, edge cases, and compliance with required map formats, making it easier to debug and improve the robustness of your Cub3D implementation.


> **⚠️ WARNING:**
> Only invalid maps are tested. Other tests have to be done afterward to fully validate the project.


> **⚠️ WARNING:**
> Detected errors can be resulting of a specific syntax that **I** decided to tag as incorrect. But some of them can be discussed and justified during the correction. **Do not automatically consider a potential error as a failure during the correction!** Try the failed tests manually and discuss it.

## Requirements

The `Cub3D` executable must return an exit code different from `0` (success) and `124` (timeout) and `139` (custom value for segfault) when a parsing error occurs.

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
   ```bash
   ./cub3d_parsing_tester.sh [/path/to/cub3d_directory] [-v]
   ```
   - `/path/to/cub3d_directory` (optional): if given, then points to the directory that contains the tested cub3D executable. If not provided then the current directory is used.
   - `-v` (optional): if present the cub3D is tested with valgrind to check memory leaks, invalid read/write and so on. **Warning** : this slows down the tests quite significantly.


If some tests fail with a timeout message instead of passing, which can occur if your Cub3D parsing step is veryyyyyy slow, then manually increase the values of the variables `TIMEOUT_CLASSIC` and `TIMEOUT_VALGRIND` in the script.

> **⚠️ WARNING:**
> If your bonuses depend on an external library that generate leaks that are unavoidable (like the mlx when using the mlx_mouse_hide function), then the tester will fail because of those. To correctly ignore those leaks:
> 1. **Create an executable that reproduce the leak**
> 2. **Navigate to the valgrind suppressions directory:**
>    ```bash
>    cd <tester_destination_path>/valgrind_suppr
>    ```
> 3. **Run the suppression generator**
>    ```bash
>    ./generate_valgrind_extra_suppressions.sh <exec_generating_the_leak> <name_to_save_the_leak_file>
>    ```


## Notes
Cub3D uses a graphical library called **mlx** that creates a window as soon as it is initialized, even before textures are imported. Therefore, it is highly likely that during the tests, such windows may be briefly opened.
The tester considers a parsing error as not properly managed if Cub3D segfaults or starts the game despite the map being invalid.

If you find any other invalid map parsing test cases to add, please contact me and I'll be glad to include them.

And most importantly: have fun with the project !