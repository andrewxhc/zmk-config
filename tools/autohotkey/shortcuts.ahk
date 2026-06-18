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

; Meh app launchers from the App layer.
!^+g::ActivateOrRun("ahk_exe zen.exe", "zen.exe")
!^+h::ActivateOrRun("ahk_exe Code.exe", "Code.exe")
!^+i::ActivateOrRun("ahk_exe Discord.exe", LocalAppData "\Discord\Update.exe --processStart Discord.exe")
!^+j::ActivateOrRun("ahk_exe Notion.exe", LocalAppData "\Programs\Notion\Notion.exe")
!^+c::ActivateOrRun("ahk_exe Codex.exe", "Codex.exe")
!^+m::ActivateOrRun("ahk_exe WindowsTerminal.exe", "wt.exe")

TiledWindowBounds := Map()

TileActiveWindow(position) {
    global TiledWindowBounds

    hwnd := WinGetID("A")
    if !hwnd
        return

    key := hwnd ""

    if !TiledWindowBounds.Has(key) {
        WinGetPos &savedX, &savedY, &savedW, &savedH, "ahk_id " hwnd
        TiledWindowBounds[key] := {X: savedX, Y: savedY, W: savedW, H: savedH}
    }

    if position = "restore" {
        if TiledWindowBounds.Has(key) {
            bounds := TiledWindowBounds[key]
            WinRestore "ahk_id " hwnd
            WinMove bounds.X, bounds.Y, bounds.W, bounds.H, "ahk_id " hwnd
            TiledWindowBounds.Delete(key)
        } else {
            WinRestore "ahk_id " hwnd
        }
        return
    }

    if position = "fill" {
        WinMaximize "ahk_id " hwnd
        return
    }

    WinRestore "ahk_id " hwnd
    workArea := GetWindowMonitorWorkArea(hwnd)
    x := workArea.Left
    y := workArea.Top
    w := workArea.Right - workArea.Left
    h := workArea.Bottom - workArea.Top

    switch position {
        case "left":
            WinMove x, y, w // 2, h, "ahk_id " hwnd
        case "right":
            WinMove x + (w // 2), y, w // 2, h, "ahk_id " hwnd
    }
}

GetWindowMonitorWorkArea(hwnd) {
    monitorIndex := GetWindowMonitorIndex(hwnd)
    return GetMonitorWorkArea(monitorIndex)
}

GetWindowMonitorIndex(hwnd) {
    WinGetPos &wx, &wy, &ww, &wh, "ahk_id " hwnd
    cx := wx + (ww // 2)
    cy := wy + (wh // 2)

    monitorCount := MonitorGetCount()
    Loop monitorCount {
        MonitorGetWorkArea A_Index, &left, &top, &right, &bottom
        if cx >= left && cx < right && cy >= top && cy < bottom {
            return A_Index
        }
    }

    return 1
}

GetMonitorWorkArea(monitorIndex) {
    MonitorGetWorkArea monitorIndex, &left, &top, &right, &bottom
    return {Left: left, Top: top, Right: right, Bottom: bottom}
}

MoveActiveWindowToNextMonitor() {
    hwnd := WinGetID("A")
    if !hwnd
        return

    monitorCount := MonitorGetCount()
    if monitorCount < 2
        return

    currentIndex := GetWindowMonitorIndex(hwnd)
    targetIndex := currentIndex = monitorCount ? 1 : currentIndex + 1
    current := GetMonitorWorkArea(currentIndex)
    target := GetMonitorWorkArea(targetIndex)

    wasMaximized := WinGetMinMax("ahk_id " hwnd) = 1
    if wasMaximized
        WinRestore "ahk_id " hwnd

    WinGetPos &wx, &wy, &ww, &wh, "ahk_id " hwnd

    currentW := current.Right - current.Left
    currentH := current.Bottom - current.Top
    targetW := target.Right - target.Left
    targetH := target.Bottom - target.Top

    relX := currentW > 0 ? (wx - current.Left) / currentW : 0
    relY := currentH > 0 ? (wy - current.Top) / currentH : 0
    newW := Min(ww, targetW)
    newH := Min(wh, targetH)
    newX := target.Left + Round(relX * targetW)
    newY := target.Top + Round(relY * targetH)
    newX := Max(target.Left, Min(newX, target.Right - newW))
    newY := Max(target.Top, Min(newY, target.Bottom - newH))

    WinMove newX, newY, newW, newH, "ahk_id " hwnd

    if wasMaximized
        WinMaximize "ahk_id " hwnd
}

MinimizeActiveWindow() {
    hwnd := WinGetID("A")
    if hwnd
        WinMinimize "ahk_id " hwnd
}

; Absolute Windows tiling from the App layer.
!^+Left::TileActiveWindow("left")
!^+Right::TileActiveWindow("right")
!^+Enter::TileActiveWindow("fill")
!^+Backspace::TileActiveWindow("restore")
!^+PgDn::MoveActiveWindowToNextMonitor()
!^+-::MinimizeActiveWindow()
