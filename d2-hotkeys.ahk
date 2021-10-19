#NoEnv
#Warn 

#Include, lib\gui.ahk

; Setup for tray icon
TrayIcon = %A_ScriptDir%\assets\D2Hotkeys.ico
IfExist, %TrayIcon%
Menu, Tray, Icon, %TrayIcon%

/*
; TODO setup reading of ini
; Read ini file
IniRead, IniConfiguration, %A_ScriptDir%\config.ini, Configuration
IniRead, IniHotkeys, %A_ScriptDir%\config.ini, Hotkeys

IniConfigurationSplitted := StrSplit(IniConfiguration,"`n","`r")◘
for k, v in IniConfigurationSplitted {
    line := StrSplit(v, "=")
    for k, v in line {
        MsgBox, % "key " . k
        MsgBox, % "value " . v
    }
}
*/

HOTKEYS := ["q", "w", "e", "r", "t"]
IS_PRODUCTION := true
SHOW_GUI := true
KEY_THAT_CASTS_SPELLS := "RButton"

; Setup the GUI
if (SHOW_GUI) {
    SetupGui()
}

; Setup all hotkeys
SetupHotkeys()

; Switches the Button that is used to cast spells and also 
; updates the GUI Text
SwitchCasterButton() {
    global KEY_THAT_CASTS_SPELLS
    global GUI_TEXT_ELEMENT
    global SHOW_GUI

    KEY_THAT_CASTS_SPELLS := (KEY_THAT_CASTS_SPELLS == "RButton")
        ? "LButton"
        : "RButton"

    if (SHOW_GUI) {
        GuiControl, Text, %GUI_TEXT_ELEMENT%, % "  D2 Hotkeys: On. Skill Button: [" . KEY_THAT_CASTS_SPELLS . "]  " 
    }
}

SendKey() {
    global KEY_THAT_CASTS_SPELLS

    Send, % "+{" . KEY_THAT_CASTS_SPELLS . "}" ; "+" equals the shift key
}

ExitApp() {
    ExitApp
}

; TODO get hotkeys from the config file
; Create all hotkeys in a loop
SetupHotkeys() {
    global KEY_THAT_CASTS_SPELLS
    global HOTKEYS

    Hotkey, IfWinActive, ahk_exe Discord.exe ; Makes all following hotkeys context-sensitive
    Hotkey, ~F10, SwitchCasterButton
    Hotkey, ~F11, ExitApp

    Loop, % HOTKEYS.Length() {
        CurrentHotkey := Hotkeys[A_Index]
        Hotkey, ~%CurrentHotkey%, SendKey
    }
}

; Including a reload hotkey for easier development
#Include, lib\gui.ahk