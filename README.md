# Climate

**Climate** is a library to create CLIs. It's your CLI mate. Got it?

Climate won't (yet) do too much fancy stuff for you now, like generating help messages or checking incoming arguments.

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

