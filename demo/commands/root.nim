import std/with

import climate/[context, sugar]


proc root*(context: Context): int =
  echo "Welcome to FakeGit!"

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

