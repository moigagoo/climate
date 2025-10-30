import std/[unittest, os, osproc, strutils, strformat]

const clifile = "tests" / "basicmath"

suite "Basic CLI":
  discard execCmd("nim c " & clifile)

  test "Two arguments expected, two given":
    const
      a = 2
      b = 3

    let (output, code) = execCmdEx &"{findExe(clifile)} sum {a} {b}"

    check code == 0
    check parseInt(strip(output)) == a + b

  test "Two arguments expected, three given":
    const
      a = 2
      b = 3
      c = 4

    let (output, code) = execCmdEx &"{findExe(clifile)} sum {a} {b} {c}"

    check code == 1
    check (strip(output)) == "The command expects exactly two arguments."

  test "Two arguments expected, none given":
    let (output, code) = execCmdEx &"{findExe(clifile)} sum"

    check code == 2
    check (strip(output)) == "The command expects exactly two arguments."

  test "Multiple arguments expected, multiple given":
    const
      a = 2
      b = 3
      c = 4

    let (output, code) = execCmdEx &"{findExe(clifile)} multisum {a} {b} {c}"

    check code == 0
    check parseInt(strip(output)) == a + b + c

  test "Multiple arguments expected, one given":
    const a = 2

    let (output, code) = execCmdEx &"{findExe(clifile)} multisum {a}"

    check code == 0
    check parseInt(strip(output)) == a

  test "Multiple arguments expected, none given":
    let (output, code) = execCmdEx &"{findExe(clifile)} multisum"

    check code == 2
    check (strip(output)) == "The command expects at least one argument."

  test "Command missing":
    let (output, code) = execCmdEx &"{findExe(clifile)}"

    check code == 0
    check (strip(output)) == "Available commands: sum."
