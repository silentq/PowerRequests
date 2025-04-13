@echo off
:: Check for administrative privileges
:: If not running as admin, relaunch with admin privileges

:: Check if the script is running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -command "Start-Process -FilePath '%~f0' -WorkingDirectory '%~dp0' -Verb RunAs"
    exit /b
)

:: Initial run 
echo PowerRequests v1.4
echo.
echo For the latest updates https://github.com/silentq/PowerRequests/releases
echo.
echo Press any key to check current Power Requests
pause >nul

:run_command
:: Run the powercfg /requests command
powercfg /requests
goto ask

:ask
:: Prompt to ask if the user wants to run the command again
set /p run_again=Press any key to run again or E to exit:
if /i "%run_again%" neq "e" goto run_command
if /i "%run_again%" == "e" goto :eof