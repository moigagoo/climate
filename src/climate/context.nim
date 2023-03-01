import std/tables


export tables


type
  Context* = object of RootObj
    cmdArguments*: seq[string]
    cmdOptions*: Table[string, string]


proc initContext*(cmdArguments: seq[string] = @[], cmdOptions = initTable[string, string]()): Context =
  Context(cmdArguments: cmdArguments, cmdOptions: cmdOptions)

