import std/[unittest, os, osproc, strutils, strformat]


const clifile = "tests" / "basicmath"

suite "Basic CLI":
  discard execCmd("nim c " & clifile)

  test "Run command with two arguments":
    const
      a = 2
      b = 3

    let (output, code) = execCmdEx &"{findExe(clifile)} sum {a} {b}"

    check code == 0
    check parseInt(strip(output)) == a + b

  test "Run command with too many arguments":
    const
      a = 2
      b = 3
      c = 4

    let (output, code) = execCmdEx &"{findExe(clifile)} sum {a} {b} {c}"

    check code == 1
    check (strip(output)) == "The command expects exactly two arguments"

  test "Run command without arguments":
    let (output, code) = execCmdEx &"{findExe(clifile)} sum"

    check code == 2
    check (strip(output)) == "The command expects exactly two arguments"

  test "Run without command":
    let (output, code) = execCmdEx &"{findExe(clifile)}"

    check code == 0
    check (strip(output)) == "Available commands: sum."

