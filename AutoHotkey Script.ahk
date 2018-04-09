#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

; # - Win (Windows logo key)
; ! - is for ALT key
; ^ - is for CTRL key
; + - is for CTRL key
; & - An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

; ------------------ Basic movement ------------------

#<!Capslock::Capslock
#Capslock::Esc


<!j::Send, {Down}
<!k::Send, {Up}
<!h::Send, {Left}
<!l::Send, {Right}

<^<!l::Send, ^{Right}
<^<!h::Send, ^{Left}

<^<!+h::Send, ^+{Left}
<^<!+l::Send, ^+{Right}

<!m::Send, {Home}
<!ю::Send, {End}
<!б::Send, {Backspace}

<!+m::Send, +{Home}
<!+ю::Send, +{End}

<^<!m::Send, ^{Home}
<^<!ю::Send, ^{End}

<!+h::Send, +{Left}
<!+l::Send, +{Right}
<!+k::Send, +{Up}
<!+j::Send, +{Down}

<!o::
     Send, {End}
     Send, {Enter}
Return


; ------------------ End basic movement ------------------


;Enter empty line above
<!+o::
     Send, {Home}
     Send, {Enter}
     Send, {Up}
Return

; --- SQLyog hotkeys remap START ---
#IfWinActive ahk_exe SQLyog.exe

<^Return:: 
	Send, {F9}
Return

<^/:: 
	Send, ^+c
Return

<^+/:: 
	Send, ^+r
Return

<^+Return:: 
	Send, ^{F9}
Return

<^Tab:: 
	Send, ^{PgDn}
Return

<^+Tab:: 
	Send, ^{PgUp}
Return

<^+z:: 
	Send, ^y
Return

; --- SQLyog hotkeys remap END ---


; --- Switch between running instances of one application ---
; --- START ---
!ё:: ; Next window
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
Loop, % List
{
    index := List - A_Index + 1
    WinGet, State, MinMax, % "ahk_id " List%index%
    if (State <> -1)
    {
        WinID := List%index%
        break
    }
}
WinActivate, % "ahk_id " WinID
return

!^ё:: ; Last window
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
Loop, % List
{
    index := List - A_Index + 1
    WinGet, State, MinMax, % "ahk_id " List%index%
    if (State <> -1)
    {
        WinID := List%index%
        break
    }
}
WinActivate, % "ahk_id " WinID
return

; --- END ---

; Toggle Windows navigation panel
#IfWinActive ahk_class CabinetWClass
#a::
Send !d!vn{enter}ln