# CHANGELOG
This file documents major changes in every release of the project.  The project
follows [Semantic Versioning](https://semver.org/). There is a section for each
release - which lists major changes made in the release.

**0.1.0-alpha.0**  2024-06-08 Abhishek Mishra  <abhishekmishra3@gmail.com>

- This is the first alpha release of the `ne0luv` library. The program
  has been around for some time as it is used in some of my hobby simulation
  projects.
- The goal of the program is to provide a kitchen sink of utilities which are
  useful when building simples games and utilities in Love2D game engine.
- The whole program is written as one literate program in the markdown document
  at `src/ne0luv.md`. Examples of the usage of the program are available in the
  program's html output.
- To build the program and generate both the readable html program and the lua
  source code to be used in love2d programs, run the `make build` command in the
  root folder of the project.
- The library currently provides the following utilites:
    - A Vector API similar to the p5.js Vector API.
    - Some simple GUI utilities like panels, text boxes and sliders for use in
      simulation UIs.
    - A simple state machine for creating mulitples states in love2d games.
