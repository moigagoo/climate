import types


export types


template opt*(context: Context, longName, shortName: string, body: untyped): untyped =
  for nameVariant in  [longName, shortName]:
    if context.cmdOptions.hasKey(nameVariant):
      let val {.inject, used.} = context.cmdOptions[nameVariant]
      body
      break

template arg*(context: Context, body, missing: untyped): untyped =
  if len(context.cmdArguments) == 0:
    missing

  let arg {.inject.} = context.cmdArguments[0]

  body

template args*(context: Context, body, missing: untyped): untyped =
  if len(context.cmdArguments) == 0:
    missing

  let args {.inject.} = context.cmdArguments

  body

