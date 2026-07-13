#Requires AutoHotkey v2.0
#SingleInstance Force

; Possible to implement cycling between windows of the same application. 

LocalAppData := EnvGet("LOCALAPPDATA")

; Type a shortcut followed by a termination key to expand it.
::;email::xuhanchengandrew@gmail.com
::;phone::5083738166
::;addr::20 Hidden Brick Rd
::;city::Hopkinton, MA 01748

::;date::FormatTime(, "yyyy-MM-dd")
::;time::FormatTime(, "HH:mm")
::;now::FormatTime(, "yyyy-MM-dd HH:mm")

ActivateOrRun(windowQuery, runTarget) {
    if WinExist(windowQuery) {
        WinActivate
    } else {
        Run runTarget
    }
}

; Meh app launchers from the App layer.
!^+g::ActivateOrRun("ahk_exe zen.exe", "zen.exe")
!^+h::ActivateOrRun("ahk_exe Code.exe", "Code.exe")
!^+i::ActivateOrRun("ahk_exe Discord.exe", LocalAppData "\Discord\Update.exe --processStart Discord.exe")
!^+j::ActivateOrRun("ahk_exe Notion.exe", LocalAppData "\Programs\Notion\Notion.exe")
!^+c::ActivateOrRun("ahk_exe Codex.exe", "Codex.exe")
!^+m::ActivateOrRun("ahk_exe WindowsTerminal.exe", "wt.exe")

