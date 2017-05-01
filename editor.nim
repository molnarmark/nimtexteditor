import terminal
import colorize
import streams, strutils, os, asyncdispatch, sequtils

var input = readFile("test.nim").split("\n")

var
  # the actual, current position of the cursor
  cursorY = input.len - 1
  cursorX = input[cursorY].len + 1

proc main() =
  while true:
    eraseScreen()
    setCursorPos(0, 0)
    for line in input:
      stdout.write line & "\n"

    # draw
    setCursorPos(cursorX, cursorY + 1)

    var keyInput = getch()

    if ord(keyInput) == 3:
      setCursorPos(0, 0)
      eraseScreen()
      quit()

    elif ord(keyInput) == 13:
      input[cursorY] = input[cursorY]
      cursorY += 1
      cursorX = 1
      input.add("")

    elif ord(keyInput) == 68:
      if cursorX == 1: continue
      cursorX -= 1

    elif ord(keyInput) == 67:
      if cursorX <= input[cursorY].len:
        cursorX += 1

    elif ord(keyInput) == 127:
      if cursorX == 1: continue
      var removeX = cursorX - 3
      var removeEndX = cursorX - 1
      input[cursorY] = input[cursorY][..removeX] & input[cursorY][removeEndX..input[cursorY].len]
      cursorX -= 1

    elif ord(keyInput) == 51:
      var removeX = cursorX - 2
      var removeEndX = cursorX
      input[cursorY] = input[cursorY][..removeX] & input[cursorY][removeEndX..input[cursorY].len]
      # cursorX -= 1

    elif ord(keyInput) != 68 and ord(keyInput) != 27 and ord(keyInput) != 91 and ord(keyInput) != 126:
      input[cursorY] = input[cursorY][..cursorX] & keyInput & input[cursorY][cursorX..input[cursorY].len]
      cursorX += 1

main()