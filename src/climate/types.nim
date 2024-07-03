import std/tables


export tables


type
  Handler* = proc(context: Context): int {.nimcall.}
  Command* = tuple[route: string, handler: Handler]
  Context* = object of RootObj
    cmdArguments*: seq[string]
    cmdOptions*: Table[string, string]

