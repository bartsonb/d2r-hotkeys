#NoEnv
#Warn 

#Include, lib\gui.ahk
#Include, lib\ini.ahk

; Setup for tray icon
TrayIcon = %A_ScriptDir%\assets\D2Hotkeys.ico
IfExist, %TrayIcon%
Menu, Tray, Icon, %TrayIcon%

; Setup all hotkeys
SetupHotkeys()

; Setup the GUI
if (Config["MAIN"]["SHOW_GUI"]) {
    SetupGui()
}

; Switches the Button that is used to cast spells and also 
; updates the GUI Text
SwitchCasterButton() {    
    global

    Config["MAIN"]["CASTER_KEY"] := (Config["MAIN"]["CASTER_KEY"] == "RButton")
        ? "LButton"
        : "RButton"

    if (Config["MAIN"]["SHOW_GUI"]) {
        GuiControl, Text, %GUI_TEXT_ELEMENT%, % "  D2 Hotkeys: On. Skill Button: [" . Config["MAIN"]["CASTER_KEY"] . "]  " 
    }
}

SendKey() {
    global

    Send, % "+{" . Config["MAIN"]["CASTER_KEY"] . "}" ; "+" equals the shift key
}

ExitApp() {
    ExitApp
}

; Create all hotkeys
SetupHotkeys() {
    global

    ExitKey := Config["MAIN"]["EXIT_KEY"]
    CasterKeySwitch := Config["MAIN"]["CASTER_KEY_SWITCH"]

    Hotkey, IfWinActive, ahk_exe D2R.exe ; Makes all following hotkeys context-sensitive
    Hotkey, ~%CasterKeySwitch%, SwitchCasterButton
    Hotkey, ~%ExitKey%, ExitApp

    ; Create all remaining hotkeys in a loop
    for key, value in Config["HOTKEYS"] {
        Hotkey, ~%key%, SendKey
    }
}

#Include, lib\dev.ahk