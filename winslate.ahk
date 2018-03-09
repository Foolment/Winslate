; Author: foolment
; Version: 2.0

; Keymap: Control+Alt+E
^!e::
WinGet, windowIdList, LIST,,, Program Manager
windowCount := 0
hintWindowInfoList := []
availableWindowIds := []
Loop %windowIdList% {
  windowId := windowIdList%A_Index%
  WinGetTitle, windowTitle, ahk_id %windowId%
  WinGetPos, x, y, w, h, ahk_id %windowId%
  if (w != 0 and h != 0 and windowTitle != "开始" and windowTitle != "") {
    availableWindowIds[++windowCount] := windowId
    key := GetIndexKey(windowCount)

    WinGet, proPath, ProcessPath, ahk_id %windowId%

    Gui, hintWindow%A_Index%: +LastFound +AlwaysOnTop +ToolWindow -Caption
    Gui, hintWindow%A_Index%: Color, FFFFFF
    Gui, hintWindow%A_Index%: Margin, 0, 0

    Gui, hintWindow%A_Index%: Add, Text, x0 y0 w32 h32 hwndicontext 0x3
    ; Get window's icon
    SendMessage, 0x0170, ExtractAssociatedIcon(proPath), 0,, ahk_id %icontext%

    Gui, hintWindow%A_Index%: Font, s20, Microsoft Yahei
    Gui, hintWindow%A_Index%: Add, Text, x0 y0 w32 h32 +BackgroundTrans +Center, %key%
    WinSet, Transparent, 200
    
    ; Get application's name
    fileDesc := FileGetInfo(proPath).FileDescription
    if (fileDesc = "Windows 资源管理器" or fileDesc = "Android Studio") {
      if (fileDesc = "Android Studio") {
        pos := InStr(windowTitle, " -")
        if (pos != 0) {
          StringLeft, simpleWindowTitle, windowTitle, pos - 1
          windowTitle := simpleWindowTitle
        }
      }
      Gui, hintWindow%A_Index%: Font, s14, Microsoft Yahei
      Gui, hintWindow%A_Index%: Add, Text, x32 y0 h32 0x200 +BackgroundTrans, %windowTitle%
    } else if StrLen(windowTitle) < 10 {
      Gui, hintWindow%A_Index%: Font, s14, Microsoft Yahei
      Gui, hintWindow%A_Index%: Add, Text, x32 y0 h32 0x200 +BackgroundTrans, %windowTitle%
    }

    info := {x: x+w/2-16, y: y+h/2-16, id: A_Index}

    conflict := true
    while conflict and windowCount != 1 {
      for index, eInfo in hintWindowInfoList {
        conflict := Sqrt((info.x-eInfo.x)**2+(info.y-eInfo.y)**2) < 32
        if (conflict) {
          info.x := info.x+32
          info.y := info.y+32
          break
        }
      }
    }

    xPos := info.x
    yPos := info.y
    Gui, hintWindow%A_Index%: Show, x%xPos% y%yPos% AutoSize
    hintWindowInfoList[windowCount] := info
  }
}

Input singleKey, L1,, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
if (ErrorLevel = "Match") {
  keyIndex := GetKeyIndex(singleKey)
  if (keyIndex > 0 and keyIndex <= windowCount) {
    activeId := availableWindowIds[keyIndex]
    WinActivate, ahk_id %activeId%
  }
}
for index, info in hintWindowInfoList {
  hintWindowId := info.id
  Gui, hintWindow%hintWindowId%: Destroy
  ; Release object
  info := ""
}

; Release object
hintWindowInfoList := ""
availableWindowIds := ""
return

GetKeyIndex(key) {
  index := Asc(key)
  if (index >= 65 and index <= 90) {
    index -= 38
  } else if (index >= 97 and index <= 122) {
    index -= 96
  }
  return index
}

GetIndexKey(index) {
  if (index >= 1 && index <= 26) {
    index += 96
  } else if (index >= 27 && index <= 52) {
    index += 38
  }
  return Chr(index)
}

FileGetInfo(lptstrFilename) {
  List := "Comments InternalName ProductName CompanyName LegalCopyright ProductVersion" . " FileDescription LegalTrademarks PrivateBuild FileVersion OriginalFilename SpecialBuild"
  dwLen := DllCall("Version.dll\GetFileVersionInfoSize", "Str", lptstrFilename, "Ptr", 0)
  dwLen := VarSetCapacity( lpData, dwLen + A_PtrSize)
  DllCall("Version.dll\GetFileVersionInfo", "Str", lptstrFilename, "UInt", 0, "UInt", dwLen, "Ptr", &lpData) 
  DllCall("Version.dll\VerQueryValue", "Ptr", &lpData, "Str", "\VarFileInfo\Translation", "PtrP", lplpBuffer, "PtrP", puLen )
  sLangCP := Format("{:04X}{:04X}", NumGet(lplpBuffer+0, "UShort"), NumGet(lplpBuffer+2, "UShort"))
  i := {}
  Loop, Parse, % List, %A_Space%
    DllCall("Version.dll\VerQueryValue", "Ptr", &lpData, "Str", "\StringFileInfo\" sLangCp "\" A_LoopField, "PtrP", lplpBuffer, "PtrP", puLen ) ? i[A_LoopField] := StrGet(lplpBuffer, puLen) : ""
  return i
}

ExtractAssociatedIcon(filePath) {
  ptr := A_PtrSize = 8 ? "ptr" : "uint"
  return DllCall("Shell32\ExtractAssociatedIcon" (A_IsUnicode ? "W" : "A"), ptr, DllCall("GetModuleHandle", ptr, 0, ptr), str, filePath, "ushort*", lpiIcon, ptr)
}
