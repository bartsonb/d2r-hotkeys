GUI_HEIGHT := 20
GUI_PADDING := 15

; Setting timer for updating the HotkeyDisplay whenever the 
; state of the D2 Window changes
Settimer, UpdateGuiState, 1000

; Setup for GUI
SetupGui() {
    global BUTTON_THAT_CASTS_SKILL
    global GUI_HEIGHT
    global GUI_PADDING

    GuiPosition := GetPositionForGui(GUI_HEIGHT, GUI_PADDING)

    ; 0x200 = vertical center alignment of text
    Gui, HotkeyDisplay:New, +AlwaysOnTop +ToolWindow -Caption -SysMenu -Border, HotkeyDisplay
    Gui, HotkeyDisplay:Margin, 0, 0
    Gui, HotkeyDisplay:Font, cWhite s8 ; c = color, s = size
    Gui, HotkeyDisplay:Color, 111111
    Gui, HotkeyDisplay:Add, Text, x0 y0 h%GUI_HEIGHT% HwndGUI_TEXT_ELEMENT 0x200, % "  D2 Hotkeys: On, Skill Button: [" . BUTTON_THAT_CASTS_SKILL . "]  "
    Gui, HotkeyDisplay:Show, % "x" . GuiPosition["X"] . "y" . GuiPosition["Y"] . "NoActivate"
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