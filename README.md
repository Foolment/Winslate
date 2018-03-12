# Winslate
![v2.0-screen-capture](https://raw.githubusercontent.com/Foolment/Winslate/master/v2.0-screen-capture.gif)

A lightweight windows switcher on Windows platform written by [AutoHotKey](https://autohotkey.com/).
Inspired by [slate](https://github.com/jigish/slate) which is a window management application working on Mas OS. The Windows Hints function is attracted to me, so I build a little Windows version.
> With [slate](https://github.com/jigish/slate) project stopping maintain many years ago I recommend [Hammerspoon](http://www.hammerspoon.org/) as alternatives on Mac OS which is an powerful and  awesome tools for automation.

## Version
2.0

## Usage
1. Run `winslate.exe`
2. Press <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>E</kbd>, you can see the windows hints on your screen.
3. Press a letter on hint to switch to specific window.

You can change hotkey to your favorite by modify `winslate.ahk` line 5:
```
; Keymap: Control+Alt+E
^!e::
```
> reference [Hotkeys](https://autohotkey.com/docs/Hotkeys.htm)

## Development
1. modify `winslate.ahk`
2. run `Ahk2Exe.exe /in winslate.ahk /icon icon.ico`(You need to install AutoHotKey first, download [here](https://autohotkey.com/download/)).
