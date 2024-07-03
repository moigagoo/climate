import std/[strutils, strformat, with]

import climate


proc createShip(context: Context): int =
  var
    shipName = "Boaty McBoatFace"

  with context:
    opt "name", "n":
      shipName = val

  echo fmt"Creating ship {shipName}."
        
proc moveShip(context: Context): int =
  var
    x = -1
    y = -1

  with context:
    opt "", "x":
      x = parseInt(val)
    opt "", "y":
      y = parseInt(val)

  echo fmt"Moving ship: x = {x}, y = {y}."

proc turnShip(context: Context): int =
  var
    angle = -1
    counterClockWise = false

  with context:
    opt "angle", "a":
      angle = parseInt(val)
    opt "counterclockwise", "c":
      counterClockWise = true

  echo fmt"Turning ship: angle = {angle}, counterclockwise = {counterClockWise}."

proc rootCommand(context: Context): int =
  if len(context.cmdArguments) == 0 and len(context.cmdOptions) == 0:
    echo "Invalid command. Run 'battleship --help' to see available commands."
    return 1

  with context:
    opt "help", "h":
      echo "This is help string."

    opt "version", "v":
      echo "Battleship v.0.1.0"


const commands = {
  "new": createShip,
  "ship move": moveShip,
  "ship turn": turnShip,
}


when isMainModule:
  quit parseCommands(commands, defaultHandler = rootCommand)

