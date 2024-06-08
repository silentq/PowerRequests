@echo off
:: Check for administrative privileges
:: If not running as admin, relaunch with admin privileges

:: Check if the script is running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -command "Start-Process cmd -ArgumentList '/c %~fnx0' -Verb RunAs"
    exit /b
)

::initial run
echo Press any key to check current Power Requests
pause >nul

:run_command
:: Run the powercfg /requests command
powercfg /requests

:ask
:: Prompt to ask if the user wants to run the command again
set /p run_again=Do you want to check current Power Requests again? (Y/N):
if /i "%run_again%"=="Y" goto run_command
if /i "%run_again%"=="N" goto :eof
echo Invalid input. Please enter Y or N.
goto ask

:: Exit the script
exit /b