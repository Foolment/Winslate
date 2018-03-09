# Winslate
![v2.0-screen-capture](https://raw.githubusercontent.com/Foolment/Winslate/master/v2.0-screen-capture.gif)

A lightweight windows switcher on Windows platform written by [AutoHotKey](https://autohotkey.com/).
Inspired by [slate](https://github.com/jigish/slate) which is a window management application working on Mas OS. The Windows Hints function is attracted to me, so I build a little Windows version.
> With [slate](https://github.com/jigish/slate) project stopping maintain many years ago I recommend [Hammerspoon](http://www.hammerspoon.org/) as alternatives on Mac OS which is an powerful and  awesome tools for automation.

## Version
2.0

## Usage
1. Run `winslate.ahk` (You need to install AutoHotKey first, download [here](https://autohotkey.com/download/)).
2. After you press `[Ctrl] + [Alt] + [E]`, you will see the windows hints on your screen.
3. Press a letter on hint to switch to specific window.

You can change hotkey to your favorite by modify `winslate.ahk` line 5:
```
; Keymap: Control+Alt+E
^!e::
```
> reference [Hotkeys](https://autohotkey.com/docs/Hotkeys.htm)
