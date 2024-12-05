import std/[strformat, with]

import climate


proc start*(context: Context): int =
  with context:
    arg:
      stdout.write fmt"Starting release {arg}..."
      echo "done!"


proc finish*(context: Context): int =
  with context:
    arg:
      stdout.write fmt"Finishing release {arg}..."
      echo "done!"

    do:
      echo "Release name is mandatory"

