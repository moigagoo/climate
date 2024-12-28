import std/with

import climate


proc root*(context: Context): int =
  echo "Welcome to FakeGit!"

  if len(context.cmdArguments) == 0 and len(context.cmdOptions) == 0:
    quit "Invalid command. Run 'git --help' to see the available commands."

  with context:
    flag "version", "":
      echo "Version 1.0.0"

    flag "help", "h":
      echo "Usage: ..."

proc add*(context: Context): int =
  with context:
    args: 
      for filename in args:
        echo "Adding " & filename
    do:
      quit("No filename provided", 1)
  
    opt "tag", "T":
      echo "Tag: " & val
    do:
      quit("Tag is mandatory", 1)

proc reset*(context: Context): int =
  with context:
    args: 
      for filename in args:
        echo "Resetting " & filename

  echo "Reset finished"

