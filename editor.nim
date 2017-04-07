import terminal
import colorize
import streams, strutils, os, asyncdispatch

var input = readFile("test.nim")
var buffer = newStringStream(input)
var strBuf = buffer.readAll()
var lineCount = strBuf.count("\n") + 1

var

  # the actual, current position of the cursor (might be able to deprecate)
  cursorX = 0
  cursorY = 0

  # variables tracking the latest position of the cursor
  cursorLastX = 0
  cursorLastY = 0

  restLinesLength = 0
  firstRun = true

proc main() =
  while true:
    showCursor()
    eraseScreen()
    buffer.setPosition(0)
    strBuf = buffer.readAll()
    lineCount = strBuf.count("\n") + 1
    var count = 0
    setCursorPos(0, 0)
    restLinesLength = 0

    for line in strBuf.split("\n"):
      count += 1
      var strCount = $count

      if count == 1:
        stdout.write strCount.bgWhite.fgBlack & "  " & line
      else:
        stdout.write "\n" &  strCount.bgWhite.fgBlack & "  " & line

      cursorX = line.len
      cursorY = lineCount

    setCursorPos(cursorLastX + 3, cursorY)
    var keyInput = getch()

    if ord(keyInput) == 13:
      buffer.write("\n")

    elif ord(keyInput) == 3:
      setCursorPos(0, 0)
      eraseScreen()
      quit()

    elif ord(keyInput) == 67:
      buffer.setPosition(buffer.getPosition() - cursorLastX)
      if cursorLastX > 0: cursorLastX += 1 else: cursorLastX = cursorX + 1

    elif ord(keyInput) == 68:
      buffer.setPosition(buffer.getPosition() - cursorLastX)
      if cursorLastX > 0: cursorLastX -= 1 else: cursorLastX = cursorX - 1


    elif ord(keyInput) != 68 and ord(keyInput) != 27 and ord(keyInput) != 91:
    # else:
      buffer.write keyInput

main()
echo "dakdhas"