@echo off
setlocal enabledelayedexpansion

REM Set the CSV file path relative to the script's folder
set "csvFile=%~dp0credentials.csv"
set "failedIPsFile=%~dp0failed_ips.csv"
set "successIPFile=%~dp0success_ips.csv"
set /a index=0

REM Replace 'User' and 'Password' with the desired values
set "User=#"
set "Password=#"

REM Populate the arrays with the given User and Password
for /f "usebackq tokens=1,2 delims=," %%A in ("%csvFile%") do (
    set "ips[!index!]=%%A"
    set /a index+=1
)

REM Loop through the array and execute the commands for each set of credentials
for /L %%i in (0,1,%index%) do (
    echo Connecting to IP: !ips[%%i]!, User: %User%, Password: %Password% 

    net use \\!ips[%%i]!\C$ /user:%User% %Password%
    if !errorlevel! neq 0 (
        echo Failed to connect to the remote machine.
        REM Append the failed IP address to the failed_ips.csv file
        echo !ips[%%i]! >> "%failedIPsFile%"
    ) else (
        robocopy "D:\jindal\trial" "\\!ips[%%i]!\C$\Users\Public\Downloads" "installJINSAFEQUIZ.bat"
        robocopy "D:\jindal\trial" "\\!ips[%%i]!\C$\Users\Public\Downloads" "jinsafe.zip"
        echo !ips[%%i]! >> "%successIPFile%"
        @REM Run the runner.bat file after successful copy
        @REM psexec \\!ips[%%i]! -u %User% -p %Password% "C:\Users\Public\Application Files\runner.bat"
    )

    REM Delete the network connection and wait for a few seconds before the next iteration
    net use \\!ips[%%i]!\C$ /delete
    timeout /t 10 /nobreak > nul
)

echo All tasks completed.
