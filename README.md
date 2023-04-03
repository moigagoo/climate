# Climate

**Climate** is a library to create CLIs. It's your CLI mate. Got it?

Climate won't (yet) do too much fancy stuff for you, like generating help messages or checking incoming arguments.

On the other hand, it allows you to think in high-level abstractions like commands and subcommands instead of parsers and tokens. That's a lot already, I'm telling you.


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

**Command** is defined by a **route** and a **handler**.

Route is how you call your command. For example, ``flow release start`` is a route.

Handler is the proc that is invoked when the command is called. It accepts a ``Context`` object and returns an ``int``.

**Context** is an object that holds the values for the arguments and options from the command line stored as a ``cmdArguments`` sequence and ``cmdOptions`` table.

Command definition my look something like this:

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

Then define your handlers:

```nim
# commands/flow.nim
import climate/context


proc init*(context: Context): int =
  stdout.write "Initializing Git flow..."

  if context.cmdOptions.hasKey("d") or context.cmdOptions.hasKey("default"):
    stdout.write "using default settings..."

  echo "done!"
```

Finally, run the app by calling ``parseCommands`` with your commands:

```nim
# git.nim
quit parseCommands(commands)
```

See the full example in ``demo`` folder.


## Sugar

To make it easier to work with arguments and options, Climate offers `arg`, `args`, and `opt` templates in `climate/sugar` module.

`arg` checks that the command has been invoked with exactly one argument and captures its value; if the command was invoked with zero or more than one arguments, the fallback code is executed:

```nim
proc start*(context: Context): int =
  context.arg:
    stdout.write fmt"Starting release {arg}..."
    echo "done!"
  do:
    echo "Release name is mandatory"
    return 1
```

`args` checks that the command has been invoked with at least one argument and captures the values of the passed arguments; if the command was invoked with no arguments, the fallback code is executed:

```nim
proc add*(context: Context): int =
  context.args:
    for filename in args:
      echo "Adding " & filename
  do:
    echo "No filename provided"
    return 1
```

`opt` checks if the command has been invoked with a certain option defined by its short and long names and captures its value:

```nim
proc root*(context: Context): int =
  context.opt "version", "":
    echo "Version 1.0.0"

  context.opt "help", "h":
    echo "Usage: ..."
```

