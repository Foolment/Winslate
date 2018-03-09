; Author: foolment
; Version: 1.0

; Keymap: Control+Alt+E
^!e::
WinGet, windowIdList, LIST,,, Program Manager
windowCount := 0
availableWindowIds := []
Gui, appListWindow: +LastFound +AlwaysOnTop +ToolWindow -Caption
Gui, appListWindow: Color, FFFFFF
Gui, applistwindow: Margin, 0, 0
WinSet, Transparent, 200
Loop %windowIdList% {
  windowId := windowIdList%A_Index%
  WinGetTitle, windowTitle, ahk_id %windowId%
  WinGetPos, x, y, w, h, ahk_id %windowId%
  if (w != 0 and h != 0 and windowTitle != "开始" and windowTitle != "") {
    availableWindowIds[++windowCount] := windowId
    WinGet, proPath, ProcessPath, ahk_id %windowId%
    fileDesc := FileGetInfo(proPath).FileDescription
    iconMargin := 32 * (windowCount - 1)
    key := GetIndexKey(windowCount)
    Gui, appListWindow: Add, Text, x0 y%iconMargin% w32 h32 hwndicontext 0x3
    SendMessage, 0x0170, ExtractAssociatedIcon(proPath), 0,, ahk_id %icontext%
    Gui, appListWindow: Font, s20, Microsoft Yahei
    Gui, appListWindow: Add, Text, xp yp w32 h32 +BackgroundTrans +Center, %key%
    if (fileDesc = "Windows 资源管理器" or fileDesc = "Android Studio") {
      Gui, appListWindow: Font, s14, Microsoft Yahei
      if (fileDesc = "Android Studio") {
        pos := InStr(windowTitle, " -")
        if (pos != 0) {
          StringLeft, simpleWindowTitle, windowTitle, pos - 1
          windowTitle := simpleWindowTitle
        }
      }
      Gui, appListWindow: Add, Text, x32 y%iconMargin% h32 0x200 +BackgroundTrans, %windowTitle%
    }
  }
}
Gui, appListWindow: Show, AutoSize xCenter yCenter

Input singleKey, L1,, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
if (ErrorLevel = "Match") {
  keyIndex := GetKeyIndex(singleKey)
  if (keyIndex > 0 and keyIndex <= windowCount) {
    activeId := availableWindowIds[keyIndex]
    WinActivate, ahk_id %activeId%
  }
}
Gui, appListWindow: Destroy
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
