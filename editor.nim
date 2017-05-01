import terminal
import colorize
import streams, strutils, os, asyncdispatch, sequtils

var input = readFile("test.nim").split("\n")

var
  # the actual, current position of the cursor
  cursorY = input.len - 1
  cursorX = input[cursorY].len + 1


proc handleCharAdd(c: char) =
  input[cursorY] = input[cursorY][..cursorX] & c & input[cursorY][cursorX..input[cursorY].len]
  cursorX += 1

proc handleBackspace() =
  if cursorX == 1 and cursorY > 1:
    cursorY -= 1
    cursorX = input[cursorY].len + 1
  else:
    var removeX = cursorX - 3
    var removeEndX = cursorX - 1
    input[cursorY] = input[cursorY][..removeX] & input[cursorY][removeEndX..input[cursorY].len]
    cursorX -= 1

proc handleDelete() =
  if cursorX == 1 and cursorY > 1:
    cursorY -= 1
    cursorX = input[cursorY].len + 1
  else:
    var removeX = cursorX - 2
    var removeEndX = cursorX
    input[cursorY] = input[cursorY][..removeX] & input[cursorY][removeEndX..input[cursorY].len]

proc handleNewline() =
  input[cursorY] = input[cursorY]
  cursorY += 1
  cursorX = 1
  input.add("")

proc drawEditor() =
  eraseScreen()
  setCursorPos(0, 0)
  for line in input:
    stdout.write line & "\n"

  setCursorPos(cursorX, cursorY + 1)

proc getInput() =
  var keyInput = getch()

  if ord(keyInput) == 3:
    setCursorPos(0, 0)
    eraseScreen()
    quit()

  elif ord(keyInput) == 13:
    handleNewline()

  # Going backwards
  elif ord(keyInput) == 68:
    if cursorX == 1: return
    cursorX -= 1

  # Going forwards
  elif ord(keyInput) == 67:
    if cursorX <= input[cursorY].len:
      cursorX += 1

  elif ord(keyInput) == 127:
    handleBackspace()

  elif ord(keyInput) == 51:
    handleDelete()

  elif ord(keyInput) != 68 and ord(keyInput) != 27 and ord(keyInput) != 91 and ord(keyInput) != 126:
    handleCharAdd(keyInput)

proc main() =
  while true:
    drawEditor()
    getInput()

main()