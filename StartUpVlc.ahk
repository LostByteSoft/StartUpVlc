;;--- Head --- Informations --- AHK ---

;;	Vlc startup
;;	Compatibility: Windows 11 x64
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	First Release: 2026-04-14
;;	Update: 2026-04-19

;;--------------------------------------------------------------------------- SEPARATOR ---------------------------------------------------------------------------
;;--- Softwares options ---

	;; #NoTrayIcon                  ; Must be at the very top
	#NoEnv
	#SingleInstance Force
	#Persistent
	SetWorkingDir, %A_ScriptDir%
	SetTitleMatchMode, 2
	SetTitleMatchMode, Slow
	DetectHiddenText, On

	SetEnv, title, StartUpVlc
	SetEnv, mode, Vlc Start Options
	SetEnv, version, Version 2026-04-16
	SetEnv, Author, LostByteSoft
	SetEnv, icofolder, %A_AppData%
	SetEnv, logoicon, ico_vlc2.ico
	SetEnv, comp, w11 (x64)

	;; specific files

	FileInstall, StartUpVlc.ini, StartUpVlc.ini,0

	;; Program icons

	FileInstall, ProgIcons/ico_maximize.ico, %icofolder%\ico_maximize.ico, 0
	FileInstall, ProgIcons/ico_minimize.ico, %icofolder%\ico_minimize.ico, 0
	FileInstall, ProgIcons/ico_vlc2.ico, %icofolder%\ico_vlc2.ico, 0
	
	;; Common ico

	FileInstall, SharedIcons/ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, SharedIcons/ico_debug.ico, %icofolder%\ico_debug.ico, 0
	FileInstall, SharedIcons/ico_debug_white.ico, %icofolder%\ico_debug_white.ico, 0
	FileInstall, SharedIcons/ico_folder.ico, %icofolder%\ico_folder.ico, 0
	FileInstall, SharedIcons/ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, SharedIcons/ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, SharedIcons/ico_loupe.ico, %icofolder%\ico_loupe.ico, 0
	FileInstall, SharedIcons/ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, SharedIcons/ico_pause.ico, %icofolder%\ico_pause.ico, 0
	FileInstall, SharedIcons/ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, SharedIcons/ico_Save.ico, %icofolder%\ico_Save.ico, 0
	FileInstall, SharedIcons/ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, SharedIcons/ico_secret.ico, %icofolder%\ico_secret.ico, 0
	FileInstall, SharedIcons/ico_windows.ico, %icofolder%\ico_windows.ico, 0

	;; ini read
	IniRead, delay, StartUpVlc.ini, options, delay
	IniRead, minimize, StartUpVlc.ini, options, minimize
	IniRead, Maximize, StartUpVlc.ini, options, maximize
	IniRead, donothing, StartUpVlc.ini, options, donothing
	IniRead, runfullscreen, StartUpVlc.ini, options, runfullscreen
	IniRead, path, StartUpVlc.ini, options, path
	IniRead, autorun, StartUpVlc.ini, options, autorun
	IniRead, debug, StartUpVlc.ini, options, debug
	IniRead, video, StartUpVlc.ini, options, video

;;--------------------------------------------------------------------------- SEPARATOR ---------------------------------------------------------------------------
;;--- Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, authorabout
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, authorabout
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, authorabout
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, authorabout
	menu, tray, disable, %version%

	menu, tray, add
	Menu, tray, add, --== Control ==--, authorabout
	Menu, Tray, Icon, --== Control ==--, %icofolder%\ico_options.ico
	Menu, tray, Disable, --== Control ==--
	Menu, tray, add, Exit %title%, ExitApp					; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh %mode%, doReload				; Reload the script.
	Menu, Tray, Icon, Refresh %mode%, %icofolder%\ico_reboot.ico, 1
	Menu, tray, add, Windows Start Link, OpenStartup
	Menu, Tray, Icon, Windows Start Link, %icofolder%\ico_windows.ico


	menu, tray, add
	menu, tray, add, --== Options ==--, authorabout
	Menu, Tray, Icon, --== Options ==--, %icofolder%\ico_options.ico
	Menu, tray, Disable, --== Options ==--
	Menu, tray, add, Set Debug (Toggle), debug				; debug msg
	Menu, Tray, Icon, Set Debug (Toggle), %icofolder%\ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause					; pause the script
	Menu, Tray, Icon, Pause (Toggle), %icofolder%\ico_pause.ico
	Menu, tray, add, Autorun On/Off = %autorun%, autorunonoff		; autorun
	menu, tray, add, Start Delay = %delay%, startdelay
	Menu, tray, add, Open StartUpVlc.ini, openini
	Menu, tray, add, Open A_WorkingDir, A_WorkingDir			; open where the exe is
	Menu, Tray, Icon, Open A_WorkingDir, %icofolder%\ico_folder.ico

	menu, tray, add
	Menu, tray, add, Vlc Close, close					; Close
	Menu, Tray, Icon, Vlc Close, %icofolder%\ico_shut.ico, 1
	Menu, tray, add, Minimize, minimize
	Menu, Tray, Icon, Minimize, %icofolder%\ico_minimize.ico, 1
	Menu, tray, add, Maximize, maximize
	Menu, Tray, Icon, Maximize, %icofolder%\ico_maximize.ico, 1
	Menu, tray, add, WinActivate, winactivate

	menu, tray, add
	Menu, tray, add, ---=== Start menu options ===---, authorabout
	;Menu, Tray, Icon, ---=== Start menu options ===---, %icofolder%\%logoicon%

	Menu, tray, add, Simulate fullscreen at startup, Simulatefullsceen
	menu, tray, Default, Simulate fullscreen at startup
	Menu, Tray, Icon, Simulate fullscreen, %icofolder%\ico_vlc2.ico, 1

	Menu, tray, add, Start fullscreen Vlc, runfullsceen
	menu, tray, Default, Start fullscreen Vlc
	Menu, Tray, Icon, Start fullscreen Vlc, %icofolder%\ico_vlc2.ico, 1

	Menu, tray, add, Start/Open Vlc (Same as click), run			;; Start new
	menu, tray, Default, Start/Open Vlc (Same as click)
	Menu, Tray, Icon, Start/Open Vlc (Same as click), %icofolder%\ico_vlc2.ico, 1

	menu, tray, add

;;--------------------------------------------------------------------------- SEPARATOR ---------------------------------------------------------------------------
;;--- Software start here ---

IfExist, %path%, Goto, Start
	MsgBox, Vlc is not installed in %path%.
	ExitApp

start:
	IfWinExist, VLC media player
		{
		goto, maximize
		}
	goto, run
	msgbox, Error to detect if Vlc is running already!
	ExitApp

Run:
	IfEqual, autorun, 0, goto, wait
	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	IfGreater, t_UpTime, %delay%, goto, skip	; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	sleep, %delay%000
	skip:
	IfWinNotExist, VLC media player
		{
		Run, %path%
		Sleep, 500
		}
	WinWait, VLC media player
	IfEqual, debug, 0, goto, skipdebug001
		msgbox, minimize=%minimize% maximize=%maximize% donothing=%donothing% runfullscreen=%runfullscreen%
		skipdebug001:
	IfEqual, minimize, 1, goto, minimize
	IfEqual, maximize, 1, goto, maximize
	IfEqual, donothing, 1, goto, wait
	IfEqual, runfullscreen, 1, goto, runfullsceen
	msgbox, Error (variable?) StartUpVlc.ini
	Goto, wait

runfullsceen:
	IfWinNotExist, VLC media player
		{
		Run, %path%
		Sleep, 3000
		}
	WinMaximize, VLC media player
	WinActivate, VLC media player
	IfEqual, autoplayvideo, 0, goto, skipvideo003
		msgbox, play video = %video%
		run, %path% "%video%"
		Send {f}
		skipvideo003:
	Goto, wait

Simulatefullsceen:
	IfWinNotExist, VLC media player
		{
		Run, %path%
		Sleep, 3000
		}
	WinMaximize, VLC media player
	WinActivate, VLC media player
	IniRead, video, StartUpVlc.ini, options, video
	run, %path% "%video%"
	Send {f}
	Goto, wait

wait:
	sleep, 2147483647			; 24 days
	goto, wait

;;--------------------------------------------------------------------------- SEPARATOR ---------------------------------------------------------------------------

minimize:
	WinMinimize,VLC media player				;; Minimize even if is not on top.
	Goto, wait

maximize:
	WinMaximize, VLC media player
	;;WinActivate, VLC media player
	Goto, wait

winactivate:
	TrayTip , Baloon, WinActivate
	Sleep, 250
	WinShow, VLC media player
	WinActivate, VLC media player
	Goto, wait

;;--------------------------------------------------------------------------- SEPARATOR ---------------------------------------------------------------------------

openini:
	run, notepad.exe "StartUpVlc.ini"
	return

startdelay:
	IniRead, delay, StartUpVlc.ini, options, delay
	SetENv, olddelay, %delay%
	InputBox, newdelay, StartUpVlc, Set new timer start in seconds ? Now time is %delay% sec. Set between 1 and 240 seconds
		if ErrorLevel
			goto, wait
	IniWrite, %newdelay%, StartUpVlc.ini, options, delay
	msgbox, old=%olddelay% ... new=%newdelay%
	IfGreater, newdelay, 240, Goto, startdelay
	IfLess, newdelay, 1, Goto, startdelay
	Menu, Tray, Rename, Start Delay = %olddelay%, Start Delay = %newdelay%
	goto, wait

autorunonoff:
	SetEnv, oldautorunonoff, %autorunonoff%
	IfEqual, autorun, 1, goto, disableautorun
	IfEqual, autorun, 0, goto, enableautorun
	msgbox, error_02 autorun error variable must be 1 or 0
	Menu, Tray, Icon, %icofolder%\ico_vlc2.ico
	Goto, wait

	enableautorun:
	IniWrite, 1, StartUpVlc.ini, options, autorun
	SetEnv, autorun, 1
	TrayTip, %title%, Autorun enabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 0, Autorun On/Off = 1
	Menu, Tray, Icon, %icofolder%\ico_vlc2.ico
	Goto, wait

	disableautorun:
	IniWrite, 0, StartUpVlc.ini, options, autorun
	SetEnv, autorun, 0
	TrayTip, %title%, Autorun disabled - %autorun%, 2, 2
	Menu, Tray, Rename, Autorun On/Off = 1, Autorun On/Off = 0
	Menu, Tray, Icon, %icofolder%\ico_vlc2.ico
	Goto, wait

;;--- Common options : Debug , pause , A_WorkingDir ---

debug:
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0

	debug0:
	SetEnv, debug, 0
	TrayTip, %title%, Deactivated ! debug=%debug%, 1, 2
	Menu, Tray, Icon, %icofolder%\%logoicon%
	Goto, wait

	debug1:
	SetEnv, debug, 1
	TrayTip, %title%, Activated ! debug=%debug%, 1, 2
	Menu, Tray, Icon, %icofolder%\ico_debug_white.ico
	Goto, wait

pause:
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused

	paused:
	SetEnv, pause, 1
	Menu, Tray, Icon, %icofolder%\ico_pause.ico
	goto, wait

	unpaused:	
	SetEnv, pause, 0
	Menu, Tray, Icon, %icofolder%\%logoicon%
	Goto, wait

	;sleep:
	;Menu, Tray, Icon, %icofolder%\ico_pause.ico
	;goto, wait

	;sleep2:
	;sleep, 500000
	;goto, sleep2

A_WorkingDir:
	IfEqual, debug, 1, msgbox, run, explorer.exe "%A_WorkingDir%"
	run, explorer.exe "%A_WorkingDir%"
	Return

OpenStartup:
	;;run, explorer.exe "%A_AppData%\Microsoft\Windows\Start Menu\Programs\Startup"
	run, explorer.exe "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
	Return

;;--------------------------------------------------------------------------- SEPARATOR ---------------------------------------------------------------------------
;;--- Quit (escape , esc) ---

exitapp:
	ExitApp

;Escape::		; For debug & testing
	ExitApp

doReload:
	Reload
	Return

;;--------------------------------------------------------------------------- SEPARATOR ---------------------------------------------------------------------------
;;--- Tray Bar (must be at end of file) ---

traystart:
	IfEqual, debug, 0, goto, skipdebug002
		msgbox, minimize=%minimize% maximize=%maximize% donothing=%donothing% runfullscreen=%runfullscreen%
		skipdebug002:
	IfWinExist, VLC media player
		{
		goto, winactivate
		}
	goto, run

	;Run, %path%
	;Sleep, 500
	;WinWait, VLC media player
	;Sleep, 250
	;Goto, winactivate

Secret:
	Menu, Tray, Icon, %icofolder%\ico_secret.ico
	IniRead, delay, StartUpVlc.ini, options, delay
	IniRead, minimize, StartUpVlc.ini, options, minimize
	IniRead, Maximize, StartUpVlc.ini, options, maximize
	IniRead, donothing, StartUpVlc.ini, options, donothing
	IniRead, runfullscreen, StartUpVlc.ini, options, runfullscreen
	IniRead, path, StartUpVlc.ini, options, path
	IniRead, autorun, StartUpVlc.ini, options, autorun
	IniRead, debug, StartUpVlc.ini, options, debug
	IniRead, video, StartUpVlc.ini, options, video
	MsgBox, 0, StartUpVlc Secret MsgBox ALL variables show.,`n`nA_WorkingDir=%A_WorkingDir%`n`nA_AppData=%A_AppData%`n`npath=%path%`n`ndelay=%delay% minimize=%minimize% maximize=%maximize% donothing=%donothing% runfullscreen=%runfullscreen% autorun=%autorun% debug=%debug%`n`nvideo=%video%`n`nWinStartUp="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
	Menu, Tray, Icon, %icofolder%\%logoicon%
	Return

close:
	WinClose, VLC media player
	Return

authorabout:
	MsgBox, 64, %title%, %title% %version% %author% %mode% %version%. This software is usefull to strat Vlc with delay.`n`n`tGo to https://github.com/LostByteSoft
	Return

GuiLogo:
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	;;Gui, 4:Color, 000000
	Sleep, 500
	Return

	4GuiClose:
	Gui 4:Cancel
	return

;;--------------------------------------------------------------------------- SEPARATOR ---------------------------------------------------------------------------
;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;		     NO FUCKING WARRANTY AT ALL
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---   
