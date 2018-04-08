#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;F11::
;   Run, http://google.com
;   WinWaitActive, Google
;   Sleep, 3000
;   Send, Fuck
;Return


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
#y::
	Run, https://youtube.com
Return

;Search in youtube
#+y::
	Send, ^c
	Sleep, 100
	Run, https://www.youtube.com/results?search_query=%clipboard%
Return