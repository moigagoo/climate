import std/with

import climate


proc root*(context: Context): int =
  echo "Welcome to FakeGit!"

  if len(context.cmdArguments) == 0 and len(context.cmdOptions) == 0:
    quit "Invalid command. Run 'git --help' to see the available commands."

  with context:
    opt "version", "":
      echo "Version 1.0.0"

    opt "help", "h":
      echo "Usage: ..."

proc add*(context: Context): int =
  with context:
    args: 
      for filename in args:
        echo "Adding " & filename
    do:
      echo "No filename provided"
      return 1
  
    opt "tag", "T":
      echo "Tag: " & val

