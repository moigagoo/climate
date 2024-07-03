import std/strformat

import climate


proc start*(context: Context): int =
  context.arg:
    stdout.write fmt"Starting release {arg}..."
    echo "done!"
  do:
    echo "Release name is mandatory"
    return 1

