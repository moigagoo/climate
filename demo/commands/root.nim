import climate/context


proc root*(context: Context): int =
  echo "Welcome to Sauer!"

  if context.cmdOptions.hasKey("v") or context.cmdOptions.hasKey("version"):
    echo "Version 1.0.0"

  if context.cmdOptions.hasKey("h") or context.cmdOptions.hasKey("help"):
    echo "Usage: ..."

