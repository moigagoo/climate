# Package

version       = "1.1.3"
author        = "Constantine Molchanov"
description   = "Library for building command-line interfaces."
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.2"

# Tasks

before docs:
  rmDir "docs"

task docs, "Generate docs":
  exec "nimble doc --outdir:docs --project --index:on src/climate"

