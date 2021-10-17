#NoEnv
#Warn 

/*
; TODO setup reading of ini
; Read ini file
IniRead, IniConfiguration, %A_ScriptDir%\config.ini, Configuration
IniRead, IniHotkeys, %A_ScriptDir%\config.ini, Hotkeys

IniConfigurationSplitted := StrSplit(IniConfiguration,"`n","`r")
for k, v in IniConfigurationSplitted {
    line := StrSplit(v, "=")
    for k, v in line {
        MsgBox, % "key " . k
        MsgBox, % "value " . v
    }
}
*/

IS_PRODUCTION := true
SHOW_GUI := true
BUTTON_THAT_CASTS_SKILL := "RButton"

#Include, lib\gui.ahk

; Setup the GUI
SetupGui()

; Setup for tray icon
TrayIcon = %A_ScriptDir%\assets\D2Hotkeys.ico
IfExist, %TrayIcon%
Menu, Tray, Icon, %TrayIcon%

; Gets the position of the D2 window and returns the relative 
; position for the gui 
GetPositionForGui(GuiHeight, GuiPadding) {
    WinGetPos, D2X, D2Y, D2W, D2H, ahk_exe D2R.exe

    X := D2X + GuiPadding
    Y := D2Y + (D2H - (GuiHeight + GuiPadding))

    Return Object("X", X, "Y", Y)
    ; return {"x": X, "y": Y}
}

; Switches the Button that is used to cast spells and also 
; updates the GUI Text
SwitchCasterButton() {
    global BUTTON_THAT_CASTS_SKILL
    global GUI_TEXT_ELEMENT

    BUTTON_THAT_CASTS_SKILL := (BUTTON_THAT_CASTS_SKILL == "RButton")
        ? "LButton"
        : "RButton"

    GuiControl, Text, %GUI_TEXT_ELEMENT%, % "  D2 Hotkeys: On. Skill Button: [" . BUTTON_THAT_CASTS_SKILL . "]  " 
}

; Checks if MS Code is open with script name in title, 
; and reloads the script on save - for easier development
; TODO use A_ScriptName
#IfWinActive, ahk_exe Code.exe
    ~^s::
        Reload
    Return

; TODO get hotkeys from the config file
; Setup keybinds for D2 skills
; "+" equals the shift key
#IfWinActive, ahk_exe D2R.exe
    ~q::Send, % "+{" . BUTTON_THAT_CASTS_SKILL . "}"
    ~w::Send, % "+{" . BUTTON_THAT_CASTS_SKILL . "}"
    ~e::Send, % "+{" . BUTTON_THAT_CASTS_SKILL . "}"
    ~r::Send, % "+{" . BUTTON_THAT_CASTS_SKILL . "}"
    ~t::Send, % "+{" . BUTTON_THAT_CASTS_SKILL . "}"
 
    ~F10::SwitchCasterButton()
    ~F11::ExitApp
    Return