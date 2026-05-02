# Convenience script to run the Credit Risk Engine
param (
    [string]$Action = "all"
)

$PYTHON = "py"

function Run-Training {
    Write-Host "🚀 Starting Model Training..." -ForegroundColor Cyan
    & $PYTHON scripts/train.py
}

function Run-Tests {
    Write-Host "🧪 Running Tests..." -ForegroundColor Cyan
    & $PYTHON -m pytest tests/ -v
}

function Start-Services {
    Write-Host "🌐 Starting FastAPI & Streamlit..." -ForegroundColor Cyan
    Start-Process $PYTHON -ArgumentList "-m uvicorn api.app:app --host 0.0.0.0 --port 8000 --reload" -NoNewWindow
    & $PYTHON -m streamlit run streamlit_app/dashboard.py --server.port 8501
}

if ($Action -eq "train") {
    Run-Training
} elseif ($Action -eq "test") {
    Run-Tests
} elseif ($Action -eq "serve") {
    Start-Services
} else {
    Run-Training
    Run-Tests
    Start-Services
}
