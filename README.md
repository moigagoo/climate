# Climate

**Climate** is a library to create CLIs. It's your CLI mate 😜

It allows you to think in high-level abstractions like commands and subcommands instead of parsers and tokens.


# Installation

Install Climate with Nimble:

```
$ nimble install -y climate
```

or add it to your .nimble file:

```nim
requires "climate >= 1.0.0"
```


# Usage

Defining CLIs with Climate is easy. There are just three terms you need to know: route, handler, and context.

**Route** is a unique sequence of words that correspond to a CLI command. For example, in git-flow, ``flow release start`` is a route.

**Handler** is a Nim proc invoked when the command is called by the user. It accepts a ``Context`` object and returns an ``int``.

**Context** is an object that holds the values for the arguments and options from the command line.

Context has a ``cmdArguments`` sequence and ``cmdOptions`` table.


## Example

Here's a fake git implemented with Climate:

1. Define routes:
```nim
# git.nim
import climate

import commands/flow
import commands/flow/release


const commands = {
  "flow init": flow.init,
  "flow release start": release.start,
  "flow release finish": release.finish
}
```

2. Define handlers:

```nim
# commands/flow.nim
import climate/context


proc init*(context: Context): int =
  stdout.write "Initializing Git flow..."

  if context.cmdOptions.hasKey("d") or context.cmdOptions.hasKey("default"):
    stdout.write "using default settings..."

  echo "done!"
```

3. Parse the command line by calling ``parseCommands``:

```nim
# git.nim
quit parseCommands(commands)
```

See the complete example in ``demo`` folder.


## Sugar

To make it easier to work with arguments and options, Climate offers `arg(Context)`, `args(Context)`, and `opt(Context)` templates in `climate/sugar` module.

- `arg` checks that the command has been invoked with exactly one argument and captures its value; if the command was invoked with zero or more than one arguments, the fallback code is executed:

```nim
proc start*(context: Context): int =
  context.arg:
    stdout.write fmt"Starting release {arg}..."
    echo "done!"
  do:
    echo "Release name is mandatory"
    return 1
```

- `args` checks that the command has been invoked with at least one argument and captures the values of the passed arguments; if the command was invoked with no arguments, the fallback code is executed:

```nim
proc add*(context: Context): int =
  context.args:
    for filename in args:
      echo "Adding " & filename
  do:
    echo "No filename provided"
    return 1
```

- `opt` checks if the command has been invoked with a certain option defined by its short and long names and captures its value:

```nim
proc root*(context: Context): int =
  context.opt "version", "":
    echo "Version 1.0.0"

  context.opt "help", "h":
    echo "Usage: ..."
```


## Supersugar

To make it even sweeter, combine `std/with` with `climate/sugar`:

```nim
proc root*(context: Context): int =
  echo "Welcome to FakeGit!"

  with context:
    opt "version", "":
      echo "Version 1.0.0"

    opt "help", "h":
      echo "Usage: ..."
```

