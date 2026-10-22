@echo off
setlocal
cd /d "%~dp0"
py -3.14 -c "import sys; print(sys.version)"
if errorlevel 1 exit /b 1
if not exist .venv\Scripts\python.exe py -3.14 -m venv .venv
if errorlevel 1 exit /b 1
.venv\Scripts\python.exe -m pip install --cache-dir .cache\pip -r requirements.txt
if errorlevel 1 exit /b 1
.venv\Scripts\python.exe -m pytest tests\test_environment.py -v
exit /b %errorlevel%
