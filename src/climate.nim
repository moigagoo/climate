import std/[parseopt, strutils]

import climate/context


export context


type
  Handler = proc(context: Context): int {.nimcall.}
  Command = tuple[route: string, handler: Handler]


proc parseCommands*(commands: openArray[Command]): int =
  ##[ Parse command-line params, store the arguments and options in context, and invoke the matching handler.
  
  Returns the exit code that should be returned by your app to the caller.
  ]##

  var
    parser = initOptParser()
    cmdComponents: seq[string]
    handler: Handler
    context: Context

  block findHandler:
    for (kind, key, val) in getopt(parser):
      if kind == cmdArgument:
        cmdComponents.add(key)

      let route = cmdComponents.join(" ")

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
      of cmdEnd:
        break 

  handler(context) 

