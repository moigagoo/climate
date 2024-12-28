import types


export types


template flag*(context: Context, longName, shortName: string, body, fallback: untyped): untyped =
  block findFlag:
    for nameVariant in  [longName, shortName]:
      if nameVariant in context.cmdFlags:
        body
        break findFlag

    fallback

template flag*(context: Context, longName, shortName: string, body: untyped): untyped =
  for nameVariant in  [longName, shortName]:
    if nameVariant in context.cmdFlags:
      body
      break

template opt*(context: Context, longName, shortName: string, body, fallback: untyped): untyped =
  block findOpt:
    for nameVariant in  [longName, shortName]:
      if context.cmdOptions.hasKey(nameVariant):
        let val {.inject, used.} = context.cmdOptions[nameVariant]
        body
        break findOpt

    fallback

template opt*(context: Context, longName, shortName: string, body: untyped): untyped =
  for nameVariant in  [longName, shortName]:
    if context.cmdOptions.hasKey(nameVariant):
      let val {.inject, used.} = context.cmdOptions[nameVariant]
      body
      break

template arg*(context: Context, body, fallback: untyped): untyped =
  if len(context.cmdArguments) == 0:
    fallback

  else:
    let arg {.inject.} = context.cmdArguments[0]
    body

template arg*(context: Context, body: untyped): untyped =
  if len(context.cmdArguments) > 0:
    let arg {.inject.} = context.cmdArguments[0]
    body

template args*(context: Context, body, fallback: untyped): untyped =
  if len(context.cmdArguments) == 0:
    fallback

  else:
    let args {.inject.} = context.cmdArguments
    body

template args*(context: Context, body): untyped =
  if len(context.cmdArguments) > 0:
    let args {.inject.} = context.cmdArguments
    body

