import std/[strutils, strformat, with]

import climate

proc createShip(context: Context): int =
  var shipName = "Boaty McBoatFace"

  with context:
    opt "name", "n":
      shipName = val
    do:
      echo "HINT: to specify the ship name, use `--name|-n=<STRING>` option."

  echo fmt"Creating ship {shipName}."

proc moveShip(context: Context): int =
  var
    x = -1
    y = -1

  with context:
    opt "", "x":
      x = parseInt(val)
    do:
      echo "HINT: to specify the x coordinate, use `-x=<NUMBER>` option."

    opt "", "y":
      y = parseInt(val)
    do:
      echo "HINT: to specify the y coordinate, use `-y=<NUMBER>` option."

  echo fmt"Moving ship: x = {x}, y = {y}."

proc turnShip(context: Context): int =
  var
    angle = -1
    counterClockWise = false

  with context:
    opt "angle", "a":
      angle = parseInt(val)
    do:
      quit("Angle is mandatory: --angle|-a=<NUMBER>", 1)

    flag "counterclockwise", "c":
      counterClockWise = true
    do:
      echo "HINT: to turn the ship counterclockwise, pass `--counterclockwise|-c` flag."
      counterClockWise = false

  echo fmt"Turning ship: angle = {angle}, counterclockwise = {counterClockWise}."

proc rootCommand(context: Context): int =
  with context:
    flag "help", "h":
      echo "Available commands: new, ship move, ship turn."
      return 0

    flag "version", "v":
      echo "Battleship v.0.1.0"
      return 0

  echo "Invalid command. Run 'battleship --help' to see available commands."
  return 1

const commands = {"new": createShip, "ship move": moveShip, "ship turn": turnShip}

when isMainModule:
  quit parseCommands(commands, defaultHandler = rootCommand)
