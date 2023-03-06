import climate

import commands/[root, flow]
import commands/flow/release


const commands = {
  "flow init": flow.init,
  "flow release start": release.start,
  "flow release finish": release.finish
}


when isMainModule:
  quit parseCommands(commands, defaultHandler = root.root)

