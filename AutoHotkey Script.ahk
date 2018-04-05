#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force


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
<!.::Send, {End}
<!,::Send, {Backspace}

<!+m::Send, +{Home}
<!+.::Send, +{End}

<^<!m::Send, ^{Home}
<^<!.::Send, ^{End}

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

; --- SQLyog hotkeys remap ---
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

#IfWinActive


;^+F::
;	Send, ^c
;	Sleep 100
;	Run, http://google.com/search?q=%clipboard%
;Return
