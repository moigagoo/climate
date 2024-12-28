import types


export types


template flag*(context: Context, longName, shortName: string, body, fallback: untyped): untyped =
  ##[ Check that a flag defined by its long and short names is present in the context.

  Call ``body`` if it is, call ``fallback`` if it isn't.
  ]##


  block findFlag:
    for nameVariant in  [longName, shortName]:
      if nameVariant in context.cmdFlags:
        body
        break findFlag

    fallback

template flag*(context: Context, longName, shortName: string, body: untyped): untyped =
  ##[ Check that a flag defined by its long and short names is present in the context.

  Call ``body`` if it is, do nothing if if isn't.
  ]##

  for nameVariant in  [longName, shortName]:
    if nameVariant in context.cmdFlags:
      body
      break

template opt*(context: Context, longName, shortName: string, body, fallback: untyped): untyped =
  ##[ Check that an option defined by its long and short names is present in the context.

  Call ``body`` and capture the option value if it is, call ``fallback`` if it isn't.
  ]##

  block findOpt:
    for nameVariant in  [longName, shortName]:
      if context.cmdOptions.hasKey(nameVariant):
        let val {.inject, used.} = context.cmdOptions[nameVariant]
        body
        break findOpt

    fallback

template opt*(context: Context, longName, shortName: string, body: untyped): untyped =
  ##[ Check that an option defined by its long and short names is present in the context.

  Call ``body`` and capture the option value if it is, do nothing if it isn't.
  ]##

  for nameVariant in  [longName, shortName]:
    if context.cmdOptions.hasKey(nameVariant):
      let val {.inject, used.} = context.cmdOptions[nameVariant]
      body
      break

template arg*(context: Context, body, fallback: untyped): untyped =
  ##[ Check that exactly one argument is present in the context.

  Call ``body`` and capture the argument value if it is, call ``fallback`` if it isn't.
  ]##

  if len(context.cmdArguments) == 0:
    fallback

  else:
    let arg {.inject.} = context.cmdArguments[0]
    body

template arg*(context: Context, body: untyped): untyped =
  ##[ Check that exactly one argument is present in the context.

  Call ``body`` and capture the argument value if it is, do nothing if it isn't.
  ]##

  if len(context.cmdArguments) > 0:
    let arg {.inject.} = context.cmdArguments[0]
    body

template args*(context: Context, body, fallback: untyped): untyped =
  ##[ Check that one or more arguments are present in the context.

  Call ``body`` and capture the argument values if they are, call ``fallback`` if they aren't.
  ]##

  if len(context.cmdArguments) == 0:
    fallback

  else:
    let args {.inject.} = context.cmdArguments
    body

template args*(context: Context, body): untyped =
  ##[ Check that one or more arguments are present in the context.

  Call ``body`` and capture the argument values if they are, do nothing if they aren't.
  ]##

  if len(context.cmdArguments) > 0:
    let args {.inject.} = context.cmdArguments
    body

