import std/strutils

import climate


proc sum(context: Context): int =
  context.args:
    if len(args) != 2:
      echo "The command expects exactly two arguments."
      return 1

    echo parseInt(args[0]) + parseInt(args[1])

  do:
    echo "The command expects exactly two arguments."
    return 2


proc multisum(context: Context): int =
  var accum = 0

  context.args:
    for arg in args:
      accum += parseInt(arg)

  do:
    echo "The command expects at least one argument."
    return 2

  echo accum


proc root(context: Context): int =
  echo "Available commands: sum."


const commands = {
  "sum": sum,
  "multisum": multisum,
}


quit parseCommands(commands, defaultHandler = root)

