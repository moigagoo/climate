import std/strutils

import climate


proc sum(context: Context): int =
  context.args:
    if len(args) != 2:
      echo "The command expects exactly two arguments"
      return 1

    echo parseInt(args[0]) + parseInt(args[1])

  do:
    echo "The command expects exactly two arguments"
    return 2

proc root(context: Context): int =
  echo "Available commands: sum."


quit parseCommands({"sum": sum}, defaultHandler = root)

