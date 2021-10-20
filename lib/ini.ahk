Config := {}

; Read ini file into the global CONFIG object
FileRead, Ini, %A_ScriptDir%\config.ini
IniLineByLine := StrSplit(Ini, "`n","`r") ; Split after line-breaks

CurrentSection := ""
CurrentLine := ""
Loop, % IniLineByLine.Length() {
    CurrentLine := IniLineByLine[A_Index]

    if (RegExMatch(CurrentLine, "\[.*\]")) ; Match for section header with square brackets
    {
        CurrentSection := RegExReplace(CurrentLine, "\[|\]", "") ; Remove square brackets from section name
        CONFIG[CurrentSection] := {}
    } 
    else if (RegExMatch(CurrentLine, "\S+")) ; Filter out empty Lines (at least one non-whitespace char)
    { 
        KeyValue := StrSplit(CurrentLine, " = ") ; Array with key and value
        CONFIG[CurrentSection][KeyValue[1]] := KeyValue[2]
    }
}