.PHONY: all build luaenv

# see https://gist.github.com/sighingnow/deee806603ec9274fd47
# for details on the following snippet to get the OS
# (removed the flags about arch as it is not needed for now)
OSFLAG :=
ifeq ($(OS),Windows_NT)
	OSFLAG = WIN32
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OSFLAG = LINUX
	endif
	ifeq ($(UNAME_S),Darwin)
		OSFLAG = OSX
	endif
endif

luaenv:
	@echo "Setting up luaenv... "
ifeq ($(OSFLAG),WIN32)
	@echo "IMPORTANT: RUN this from x64 Native Tools Command Prompt for VS"
endif
	hererocks .luaenv --lua 5.4 --luarocks latest
ifeq ($(OSFLAG),WIN32)
	powershell ".luaenv/bin/activate.ps1 ; luarocks install luafilesystem"
else
	bash -c "source .luaenv/bin/activate; luarocks install luafilesystem"
endif

build: clean
	@echo "Building..."
	mkdir -p dist/
ifeq ($(OSFLAG),WIN32)
	powershell ".luaenv/bin/activate.ps1 ; lua ./litpd/litpd.lua src/ne0luv.md --to=html --standalone --toc --output=dist/ne0luv.html"
else
	bash -c "source .luaenv/bin/activate; lua ${LITPD_HOME}/litpd.lua src/ne0luv.md --to=html --standalone --toc --output=dist/ne0luv.html"
endif
	mv ne0luv.lua dist/

clean:
	@echo "Cleaning..."
	rm -f dist/*