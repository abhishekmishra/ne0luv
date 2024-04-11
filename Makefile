.PHONY: all build luaenv

luaenv:
	@echo "Setting up luaenv... "
	@echo "IMPORTANT: RUN this from x64 Native Tools Command Prompt for VS"
	hererocks .luaenv --lua 5.4 --luarocks latest
	powershell ".luaenv/bin/activate.ps1 ; luarocks install luafilesystem"

build:
	@echo "Building..."
	lua ./build.lua
