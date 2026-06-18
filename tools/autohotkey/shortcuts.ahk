#Requires AutoHotkey v2.0
#SingleInstance Force

; Possible to implement cycling between windows of the same application. 

LocalAppData := EnvGet("LOCALAPPDATA")

; Type ;email and it expands
::;email::xuhanchengandrew@gmail.com

ActivateOrRun(windowQuery, runTarget) {
    if WinExist(windowQuery) {
        WinActivate
    } else {
        Run runTarget
    }
}

; Hyper app launchers from the App layer.
#!^+g::ActivateOrRun("ahk_exe zen.exe", "zen.exe")
#!^+h::ActivateOrRun("ahk_exe Code.exe", "Code.exe")
#!^+i::ActivateOrRun("ahk_exe Discord.exe", LocalAppData "\Discord\Update.exe --processStart Discord.exe")
#!^+j::ActivateOrRun("ahk_exe Notion.exe", LocalAppData "\Programs\Notion\Notion.exe")
#!^+c::ActivateOrRun("ahk_exe Codex.exe", "Codex.exe")
#!^+m::ActivateOrRun("ahk_exe WindowsTerminal.exe", "wt.exe")
