# Owl

Owl 🦉 is a command line tool that collects the licenses etc. of the Swift packages you use. It is intended to be called
during the Xcode build process.

## Installation

You can install `owl` either with [Homebrew](https://brew.sh) or from source.

### Install with Homebrew

```shell-script
brew install qultist/formulae/owl
```

### Install from source

```shell-script
rake install
```

## Usage

Add the following Run Script Phase to your Xcode project. Make sure that the output directory exists!

```shell-script
if which owl >/dev/null; then
  owl -b "$BUILD_DIR" -o "$SOURCE_ROOT/AwesomeProject/Resources/Licenses"
else
  echo "warning: Owl is not installed, you can download it from https://github.com/qultist/owl"
fi
```

> The `BUILD_DIR` and `SOURCE_ROOT` environment variables are provided by Xcode during build.

Owl will then create a `packages.json` file containing some information about the Swift packages and copy their license
and notice files. Then it is up to you what you do with these files. :wink: You can have a look at the
[example](Example) to see how I integrate Owl and use the files.

## License

Owl is released under the MIT license. See [LICENSE](./LICENSE) for details.
