GUI_HEIGHT := 20
GUI_PADDING := 15
WARNING_SHOWN := false

; Setting timer for updating the HotkeyDisplay whenever the 
; state of the D2 Window changes
Settimer, UpdateGuiState, 1000

; Setup for GUI once script is started.
; Also warns the user when D2R has not been launched and waits for D2R
; to be opened. 
SetupGui() {
    global WARNING_SHOWN
    global KEY_THAT_CASTS_SPELLS
    global GUI_HEIGHT
    global GUI_PADDING

    if WinExist("ahk_exe D2R.exe") {
        SetTimer, SetupGui, Off

        GuiPosition := GetPositionForGui(GUI_HEIGHT, GUI_PADDING)

        ; 0x200 = vertical center alignment of text
        Gui, HotkeyDisplay:New, +AlwaysOnTop +ToolWindow -Caption -SysMenu -Border, HotkeyDisplay
        Gui, HotkeyDisplay:Margin, 0, 0
        Gui, HotkeyDisplay:Font, cWhite s8 ; c = color, s = size
        Gui, HotkeyDisplay:Color, 111111
        Gui, HotkeyDisplay:Add, Text, x0 y0 h%GUI_HEIGHT% HwndGUI_TEXT_ELEMENT 0x200, % "  D2 Hotkeys: On, Skill Button: [" . KEY_THAT_CASTS_SPELLS . "]  "
        Gui, HotkeyDisplay:Show, % "x" . GuiPosition["X"] . "y" . GuiPosition["Y"] . "NoActivate"
    } else {
        SetTimer, SetupGui, 3000

        if (WARNING_SHOWN == false) {
            WARNING_SHOWN := true
            MsgBox, "Overlay will open once D2R has been launched."
        }
    }
}

; Updates position and show/hide state of the gui depending on 
; the active state of the D2 Window
UpdateGuiState() {
    DetectHiddenWindows, on

    global GUI_HEIGHT
    global GUI_PADDING

    if WinActive("ahk_exe D2R.exe") {
        Gui, HotkeyDisplay:Show, NoActivate

        GuiPos := GetPositionForGui(GUI_HEIGHT, GUI_PADDING)
        WinMove, HotkeyDisplay,, % GuiPos["X"], % GuiPos["Y"]
    } else {
        Gui, HotkeyDisplay:Hide
    }
}

; Gets the position of the D2 window and returns the relative 
; position for the gui 
GetPositionForGui(GuiHeight, GuiPadding) {
    WinGetPos, D2X, D2Y, D2W, D2H, ahk_exe D2R.exe

    X := D2X + GuiPadding
    Y := D2Y + (D2H - (GuiHeight + GuiPadding))

    Return Object("X", X, "Y", Y)
    ; return {"x": X, "y": Y}
}