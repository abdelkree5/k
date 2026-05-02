@echo off
setlocal

cd /d "%~dp0"
echo ======================================
echo   Credit Risk Engine Launcher
echo ======================================
echo.

set "APP_MODE=%APP_MODE%"
if "%APP_MODE%"=="" set "APP_MODE=auto"

set "API_PYTHON=%API_PYTHON%"
if "%API_PYTHON%"=="" set "API_PYTHON=C:\Users\MostafaAliMohamedElS\miniconda3\envs\ai_env\python.exe"

set "DASHBOARD_PYTHON=%DASHBOARD_PYTHON%"
if "%DASHBOARD_PYTHON%"=="" set "DASHBOARD_PYTHON=.venv_dashboard\Scripts\python.exe"

set "NO_PAUSE=%NO_PAUSE%"
set "DRY_RUN=%DRY_RUN%"

echo Mode: %APP_MODE%
echo.

if /I "%APP_MODE%"=="docker" goto :run_docker
if /I "%APP_MODE%"=="local" goto :run_local

where docker >nul 2>nul
if %errorlevel%==0 goto :run_docker
where docker-compose >nul 2>nul
if %errorlevel%==0 goto :run_docker

echo Docker not found - using local Python launch.
goto :run_local

:run_docker
echo Starting via Docker Compose...
if /I "%DRY_RUN%"=="1" goto :docker_dry_run
docker compose up --build -d
if errorlevel 1 (
    echo docker compose failed. Trying docker-compose...
    docker-compose up --build -d
    if errorlevel 1 (
        echo Docker launch failed. Falling back to local mode.
        goto :run_local
    )
)
echo.
echo Project is starting in Docker.
echo API:       http://127.0.0.1:8000
echo Dashboard: http://127.0.0.1:8501
goto :finish

:docker_dry_run
echo docker compose up --build -d
echo docker-compose up --build -d
goto :finish

:run_local
if not exist "%API_PYTHON%" (
    echo API Python interpreter not found:
    echo   %API_PYTHON%
    exit /b 1
)

if not exist "%DASHBOARD_PYTHON%" (
    echo Dashboard Python interpreter not found:
    echo   %DASHBOARD_PYTHON%
    exit /b 1
)

echo Starting API on http://127.0.0.1:8000 ...
if /I "%DRY_RUN%"=="1" goto :local_dry_run
start "Credit Risk API" "%API_PYTHON%" -m uvicorn api.app:app --host 127.0.0.1 --port 8000 --reload

echo Starting dashboard on http://127.0.0.1:8501 ...
start "Credit Risk Dashboard" "%DASHBOARD_PYTHON%" -m streamlit run streamlit_app/dashboard.py --server.port 8501 --server.address 127.0.0.1

echo.
echo Project is starting in separate windows.
echo API:       http://127.0.0.1:8000
echo Dashboard: http://127.0.0.1:8501
goto :finish

:local_dry_run
echo start "Credit Risk API" "%API_PYTHON%" -m uvicorn api.app:app --host 127.0.0.1 --port 8000 --reload
echo start "Credit Risk Dashboard" "%DASHBOARD_PYTHON%" -m streamlit run streamlit_app/dashboard.py --server.port 8501 --server.address 127.0.0.1
goto :finish

:finish
if not defined NO_PAUSE pause
