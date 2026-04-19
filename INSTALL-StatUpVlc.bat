echo off
pushd "%~dp0
@echo -------------------------===== Install Start. =====-------------------------
echo You must run this in run as administrator mode.
@echo -------------------------------------
@echo Software: StartUpVlc
@echo LostByteSoft
@echo Install version 2026-04-13
@echo Architecture: x64
@echo Compatibility : w11
@echo -------------------------------------
tasklist /FI "IMAGENAME eq StartUpVlc.exe" | findstr /I "StartUpVlc.exe"
if %ERRORLEVEL% equ 0 (
@echo StartUpVlc.exe is running. Attempting to terminate...
	taskkill /IM "StartUpVlc.exe" /F
	if %ERRORLEVEL% equ 0 (
@echo StartUpVlc.exe terminated successfully.
	) else (
@echo Failed to terminate StartUpVlc.exe.
	)
	) else (
@echo StartUpVlc.exe is not running.
	)
@echo -------------------------------------
@echo COPY "ProgIcons\*.ico" TO "C:\Program Files\Common Files"
@copy "ProgIcons\*.ico" "C:\Program Files\Common Files"
@echo COPY "SharedIcons\*.ico" TO "C:\Program Files\Common Files"
@copy "SharedIcons\*.ico" "C:\Program Files\Common Files"
@echo -------------------------------------
@echo Delete files.
del "C:\Program Files\StartUpVlc.exe"
@echo Copy files.
@copy "*.lnk" "C:\Users\Public\Desktop\"
@copy "StartUpVlc.exe" "C:\Program Files\"
@copy "StartUpVlc.ini" "C:\Program Files\"
@echo -------------------------------------
@echo Take ownership of StartUpVlc.ini
takeown /F "C:\Program Files\StartUpVlc.ini" /A
cmd.exe /C icacls "C:\Program Files\StartUpVlc.ini" /grant Everyone:F
@echo ------------------------===== Install end. =====-----------------------
@echo "You must close this command windows"
@"C:\Program Files\StartUpVlc.exe"
pause
exit
