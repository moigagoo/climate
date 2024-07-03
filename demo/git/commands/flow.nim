import climate


proc init*(context: Context): int =
  stdout.write "Initializing Git flow..."

  if context.cmdOptions.hasKey("d") or context.cmdOptions.hasKey("default"):
    stdout.write "using default settings..."

  echo "done!"

