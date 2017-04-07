import terminal
import colorize
import streams, strutils

var input = readFile("test.nim")
var buffer = newStringStream(input)
var strBuf = buffer.readAll()
var lineCount = strBuf.count("\n") + 1
buffer.setPosition(0)
var
  cursorX = 0
  cursorY = 0

while true:
  eraseScreen()
  buffer.setPosition(0)
  strBuf = buffer.readAll()
  lineCount = strBuf.count("\n") + 1
  setCursorPos(1, 1)
  var count = 0
  for line in strBuf.split("\n"):
    count += 1
    var strCount = $count
    stdout.write strCount.bgWhite.fgBlack & "  " & line & "\n"

  var keyInput = getch()

  if ord(keyInput) == 13:
    buffer.write("\n")
    cursorY += 1
  else:
    buffer.write keyInput
    cursorX += 1



  if ord(keyInput) == 3: quit()