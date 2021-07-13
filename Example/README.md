# Example

The _License Viewer_ App demonstrates how I use Owl in my apps.

> The example app is not intended to demonstrate SwiftUI best practices. :slightly_smiling_face:

## Steps

1. Create a new folder and place a `.gitkeep` file in it. 
2. Have all files in this folder ignored by git except the `.gitkeep`. This way the generated files will not be tracked
   and your colleagues will not have to recreate the directory.
3. Add the folder to your project. Make sure to select "Create folder references". In the Project Navigator, the folder
   should a have a blue icon instead of yellow. Using a folder reference Xcode will include all files automatically.
4. Add the following Run Script Phase to your project.
	```shell-script
	if which owl >/dev/null; then
	  owl -b "$BUILD_DIR" -o "$SOURCE_ROOT/LicenseViewer/Resources/Licenses"
	else
	  echo "warning: Owl is not installed, you can download it from https://github.com/qultist/owl"
	fi
	```
5. Use the generated `packages.json` to display an overview of the packages used and to decide whether a license,
   notice or both are available.