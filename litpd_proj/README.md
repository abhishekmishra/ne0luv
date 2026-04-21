# ne0luv
Love2d UI, state management, math and miscellaneous utils

# Build

## Lua Environment Setup

After the first checkout setup a local lua environment using `hererocks`. On
windows run this commmand in a "x64 Visual Studio Command Prompt".

This commmand sets up **lua version 5.4** and **luarocks latest version**.

```bash
hererocks .luaenv -l 5.4 -r latest
```

## Run the build

Run the following to create a new build. The output files will be generated in
the `dist` folder.

```powershell
# Activate the lua environment
.luaenv/bin/activate.ps1

# Run the build
make build
```