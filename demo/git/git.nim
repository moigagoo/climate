import climate

import commands/[root, flow]
import commands/flow/release


const commands = {
  "add": root.add,
  "flow init": flow.init,
  "flow release start": release.start
}


when isMainModule:
  quit parseCommands(commands, defaultHandler = root.root)

