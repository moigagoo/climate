import std/os
import std/parseopt
import std/tables
import std/strformat
import std/sequtils
import std/strutils
import std/math


export tables


type
  Context = object of RootObj
    cmdArguments: seq[string]
    cmdOptions: Table[string, string]
  Handler = proc(context: Context): int {.nimcall.}
  Command = tuple[name: string, handler: Handler]

proc hello(context: Context): int =
  var greeting = fmt"Hello {context.cmdArguments[0]}!"

  if "s" in context.cmdOptions or "shout" in context.cmdOptions:
    greeting = greeting.toUpper()

  echo greeting

proc sumAll(context: Context): int =
  let
    parsedArgs = context.cmdArguments.map(parseInt)
    mult =
      if "mult" in context.cmdOptions:
        parseInt(context.cmdOptions["mult"])
      elif "m" in context.cmdOptions:
        parseInt(context.cmdOptions["m"])
      else:
        1
    res = sum(parsedArgs) * mult

  echo fmt"Sum of all entered integers multiplied by {mult} is: " & $res


const commands: seq[Command] = @{
  "hello": hello,
  "math sum": sumAll,
}


var
  parser = initOptParser(commandLineParams())
  cmdComponents: seq[string]
  matchingCommands: seq[Command]
  context: Context

for (kind, key, val) in getopt(parser):
  case kind
  of cmdArgument:
    cmdComponents.add(key)
    matchingCommands = commands.filterIt(it[0] == cmdComponents.join(" "))
  else:
    continue

  if len(matchingCommands) == 1:
    break
  else:
    continue

for (kind, key, val) in getopt(parser.remainingArgs):
  case kind
  of cmdArgument:
    context.cmdArguments.add(key)
  of cmdShortOption, cmdLongOption:
    context.cmdOptions[key] = val
  of cmdEnd:
    break 


if len(matchingCommands) == 1:
  quit matchingCommands[0].handler(context)
else:
  echo "No matching command found."
  echo "Available commands:"
  for command in commands:
    echo command.name.indent(1, "\t")
  quit 1

