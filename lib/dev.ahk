; Checks if MS Code is open with script name in title, 
; and reloads the script on save - for easier development
; TODO use A_ScriptName

#IfWinActive ahk_exe Code.exe
    ~^s::Reload
Return