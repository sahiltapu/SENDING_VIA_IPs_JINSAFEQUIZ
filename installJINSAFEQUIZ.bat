@echo off
setlocal enabledelayedexpansion

rem Set the name of the zip file (modify this with your zip file name)
set "zipfilename=jinsafe.zip"

call :checkFileExistence "%zipfilename%"
if %errorlevel% neq 0 (
    exit /b 1
)

call :getFullPath "%zipfilename%" zipfile
call :getFolderPath "%zipfile%" destination

call :unzipFile "%zipfile%" "%destination%"
if %errorlevel% neq 0 (
    exit /b 1
)

call :runBatchFile "%destination%set_daily_JINSAFE.bat"
if %errorlevel% neq 0 (
    echo Warning: The 'set_daily_JINSAFE.bat' file was not found or encountered an error during execution.
)

echo The file "%zipfilename%" was successfully unzipped in the same folder.
exit /b 0

:checkFileExistence
if not exist "%~1" (
    echo Error: The specified file "%~1" does not exist.
    exit /b 1
)
exit /b 0

:getFullPath
for %%F in ("%~1") do set "%~2=%%~fF"
exit /b 0

:getFolderPath
for %%F in ("%~1") do set "%~2=%%~dpF"
exit /b 0

:unzipFile
powershell -noprofile -command "try { Expand-Archive -Path '%~1' -DestinationPath '%~2' -Force; exit 0 } catch { exit 1 }"
exit /b %errorlevel%

:runBatchFile
if exist "%~1" (
    echo Running batch file: "%~1"
    "%~1"
    exit /b %errorlevel%
) else (
    exit /b 1
)
