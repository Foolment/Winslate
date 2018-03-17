# Winslate
![v2.0-screen-capture](https://raw.githubusercontent.com/Foolment/Winslate/master/v2.0-screen-capture.gif)

A lightweight windows switcher on Windows platform written by [AutoHotKey](https://autohotkey.com/).
It's inspired by [slate](https://github.com/jigish/slate) which is a window management application working on Mas OS. I'm attracted to the Windows Hints function, so I build a little Windows version.
> As [slate](https://github.com/jigish/slate) project is stopped maintain many years I recommend [Hammerspoon](http://www.hammerspoon.org/) as alternatives. Hammerspoon is an powerful and  awesome tools for automation.

## Version
2.0

## Usage
1. Run `winslate.exe`
2. Press <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>E</kbd> and you can see the windows hints on your screen.
3. Press the letter on hint to switch to specific window.

You can change hotkey to your favorite by modify line 5 on `winslate.ahk`:
```
; Keymap: Control+Alt+E
^!e::
```
> Please reference [Hotkeys](https://autohotkey.com/docs/Hotkeys.htm).

## Development
1. Modify `winslate.ahk`
2. Run `Ahk2Exe.exe /in winslate.ahk /icon icon.ico`(You need to install AutoHotKey first, download [here](https://autohotkey.com/download/)).
