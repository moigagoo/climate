import std/[parseopt, strutils]

import types


export types


proc parseCommands*(commands: openArray[Command], defaultHandler: Handler = nil): int =
  ##[ Parse command-line params, store the arguments and options in context, and invoke the matching handler.

  Returns the exit code that should be returned by your app to the caller.
  ]##

  var
    parser = initOptParser()
    cmdComponents: seq[string]
    handler = defaultHandler
    context: Context
    route = ""

  block findHandler:
    for (kind, key, val) in getopt(parser):
      case kind
      of cmdArgument:
        cmdComponents.add(key)
        route = cmdComponents.join(" ")
      of cmdShortOption, cmdLongOption:
        context.cmdOptions[key] = val
        if len(val) == 0:
          context.cmdFlags.add(key)
      of cmdEnd:
        break

      for command in commands:
        if command.route == route:
          handler = command.handler
          break findHandler

  if handler.isNil:
    quit("Command not found", 1)

  if len(parser.remainingArgs) > 0:
    for (kind, key, val) in getopt(parser.remainingArgs):
      case kind
      of cmdArgument:
        context.cmdArguments.add(key)
      of cmdShortOption, cmdLongOption:
        context.cmdOptions[key] = val
        if len(val) == 0:
          context.cmdFlags.add(key)
      of cmdEnd:
        break

  handler(context)

