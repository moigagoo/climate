import std/strformat

import climate/context


proc start*(context: Context): int =
  if len(context.cmdArguments) == 0:
    echo "Release name is mandatory"
    return 1

  stdout.write fmt"Starting release {context.cmdArguments[0]}..."
  echo "done!"


proc finish*(context: Context): int =
  if len(context.cmdArguments) == 0:
    echo "Release name is mandatory"
    return 1

  stdout.write fmt"Finishing release {context.cmdArguments[0]}..."
  echo "done!"

