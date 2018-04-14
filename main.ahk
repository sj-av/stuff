#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

; # - Win (Windows logo key)
; ! - is for ALT key
; ^ - is for CTRL key
; + - is for SHIFT key
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

<!SC032::Send, {Home}		; "m" - button on eng layout
<!SC034::Send, {End}		; "." - button on eng layout
<!SC033::Send, {Backspace} 	; "," - button on eng layout

<!+SC032::Send, +{Home}		; "m" - button on eng layout
<!+SC034::Send, +{End}		; "." - button on eng layout

<^<!SC032::Send, ^{Home}  	; "m" - button on eng layout
<^<!SC034::Send, ^{End}   	; "." - button on eng layout

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
!SC029:: ; Next window 			; "`" - button on eng layout
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

!^SC029:: ; Last window  		; "`" - button on eng layout
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
    Send, !3!vn{enter}ln
Return
#IfWinActive


;Open google
#f::
    Run, http://google.com
Return

;Search in google text in clipboard
#+f::
    Send, ^c
    Sleep, 100
    Run, http://google.com/search?q=%clipboard%
Return

;Open youtube
#SC015::
    Run, https://youtube.com
Return

;Search in youtube
#+y::
    Send, ^c
    Sleep, 100
    Run, https://www.youtube.com/results?search_query=%clipboard%
Return