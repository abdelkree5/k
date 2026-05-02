# 🚀 Complete Setup & Installation Guide

**Project**: AI-Powered Credit Risk Scoring Engine  
**Version**: 1.0.0  
**Developer**: Mostafa Ali Mohamed Elsharqawi  
**Last Updated**: May 2, 2026

---

## 📋 Table of Contents

1. [System Requirements](#system-requirements)
2. [Installation Steps](#installation-steps)
3. [Configuration](#configuration)
4. [Running the Project](#running-the-project)
5. [Verification](#verification)
6. [Troubleshooting](#troubleshooting)

---

## 💻 System Requirements

### Hardware

- **CPU**: 4+ cores recommended
- **RAM**: 8GB minimum (16GB recommended)
- **Storage**: 2GB for code + models + data
- **Network**: Internet connection for dependencies

### Operating System

- ✅ Windows 10/11
- ✅ macOS 10.14+
- ✅ Linux (Ubuntu 18.04+)

### Software

- **Python**: 3.10 or higher
- **Git**: Latest version
- **Docker** (optional): For containerization
- **Terminal/PowerShell**: For command execution

---

## ✅ Installation Steps

### Step 1: Clone Repository

```bash
# Clone the repository
git clone https://github.com/mstfyshrqawy520-alt/credit-risk-engine.git

# Navigate to project directory
cd credit-risk-engine

# Verify project structure
ls -la  # Unix/Linux/macOS
dir    # Windows
```

### Step 2: Create Virtual Environment

#### On Windows

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
venv\Scripts\activate

# Verify activation (should show (venv) prefix)
python --version
```

#### On macOS/Linux

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Verify activation (should show (venv) prefix)
python --version
```

### Step 3: Install Dependencies

```bash
# Upgrade pip
python -m pip install --upgrade pip

# Install requirements
pip install -r requirements.txt

# Verify installation
pip list | grep -E "scikit-learn|xgboost|streamlit|fastapi"
```

### Step 4: Verify Installation

```bash
# Check Python version
python --version  # Should be 3.10+

# Check key packages
python -c "import sklearn, xgboost, streamlit, fastapi; print('All packages installed!')"

# Check SHAP installation
python -c "import shap; print(f'SHAP version: {shap.__version__}')"
```

---

## ⚙️ Configuration

### Environment Variables (Optional)

Create `.env` file in project root:

```bash
# API Configuration
API_HOST=0.0.0.0
API_PORT=8000

# Streamlit Configuration
STREAMLIT_SERVER_PORT=8501

# Data Configuration
DATA_PATH=data/credit_data.csv
MODEL_OUTPUT_DIR=models

# Logging
LOG_LEVEL=INFO
LOG_FILE=logs/app.log
```

### Configuration Files

#### `configs/config.yaml`

```yaml
project:
  name: "AI-Powered Credit Risk Scoring Engine"
  version: "1.0.0"

developer:
  name: "Mostafa Ali Mohamed Elsharqawi"
  email: "mostafa.elsharqawi@gmail.com"

data:
  path: "data/credit_data.csv"
  test_size: 0.2
  random_state: 42

model:
  output_dir: "models"
  primary: "xgboost"
```

#### `configs/params.yaml`

Adjust model parameters as needed for your use case.

---

## 🏃 Running the Project

### Method 1: Individual Components (Development)

#### Terminal 1: Train Models

```bash
# Activate virtual environment
source venv/bin/activate  # Unix/Linux/macOS
# OR
venv\Scripts\activate     # Windows

# Generate data and train models
python scripts/train.py

# Expected output:
# ✅ Training complete!
# Best model: catboost
# Best AUC: 0.8230
```

#### Terminal 2: Start API

```bash
# Activate virtual environment
source venv/bin/activate

# Start FastAPI server
python -m uvicorn api.app:app --host 0.0.0.0 --port 8000 --reload

# Expected output:
# Uvicorn running on http://0.0.0.0:8000
# API Docs: http://localhost:8000/docs
```

#### Terminal 3: Start Dashboard

```bash
# Activate virtual environment
source venv/bin/activate

# Start Streamlit dashboard
streamlit run streamlit_app/dashboard.py

# Expected output:
# You can now view your Streamlit app in your browser.
# URL: http://localhost:8501
```

### Method 2: Docker (Production)

#### Build & Run with Docker Compose

```bash
# Build images
docker-compose build

# Start services
docker-compose up

# Access services:
# API: http://localhost:8000/docs
# Dashboard: http://localhost:8501

# Stop services
docker-compose down
```

#### Build Individual Services

```bash
# Build API image
docker build -f Dockerfile.api -t credit-risk-engine-api .

# Build Dashboard image
docker build -f Dockerfile.streamlit -t credit-risk-engine-dashboard .

# Run containers
docker run -p 8000:8000 credit-risk-engine-api
docker run -p 8501:8501 credit-risk-engine-dashboard
```

---

## ✨ Verification

### API Health Check

```bash
# Check API is running
curl http://localhost:8000/health

# Expected response:
# {"status": "healthy", "models": [...]}

# View API documentation
# Open browser: http://localhost:8000/docs
```

### Test Prediction

```bash
# Make a prediction request
curl -X POST http://localhost:8000/predict \
  -H "Content-Type: application/json" \
  -d '{
    "age": 35,
    "income": 75000,
    "credit_score": 720,
    "employment_years": 5,
    "debt_amount": 10000,
    "payment_history": 12
  }'

# Expected response:
# {"risk_score": 0.25, "risk_level": "LOW", ...}
```

### Dashboard Access

```bash
# Access Streamlit dashboard
# Open browser: http://localhost:8501

# Expected UI:
# ✅ Navigation menu (Dashboard, Application, Analytics, Fairness, About)
# ✅ Model metrics and comparison
# ✅ Risk distribution charts
# ✅ Fairness analysis dashboard
```

### Run Tests

```bash
# Run all tests
pytest tests/ -v

# Run with coverage
pytest tests/ --cov=src --cov-report=term-missing

# Expected output:
# test_pipeline.py::test_data_loading PASSED
# test_pipeline.py::test_model_training PASSED
# ... (all tests should pass)
```

---

## 🐛 Troubleshooting

### Issue: Python version mismatch

```bash
# Solution: Check and update Python
python --version
# If < 3.10, download from https://www.python.org/downloads/
```

### Issue: Module not found errors

```bash
# Solution: Reinstall dependencies
pip install --upgrade pip
pip install -r requirements.txt --force-reinstall
```

### Issue: Permission denied (macOS/Linux)

```bash
# Solution: Change file permissions
chmod +x scripts/train.py
chmod +x streamlit_app/dashboard.py
```

### Issue: Port already in use

```bash
# Solution: Use different ports
# For API:
python -m uvicorn api.app:app --port 8001

# For Dashboard:
streamlit run streamlit_app/dashboard.py --server.port 8502
```

### Issue: GPU not detected (optional)

```bash
# Solution: Install GPU support (optional)
pip install xgboost==2.0.0 --upgrade --force-reinstall
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

### Issue: Out of memory errors

```bash
# Solution: Reduce batch size in training
# Edit configs/params.yaml:
# batch_size: 32  # Reduce from 128
```

---

## 📊 Post-Installation Checks

### Run Verification Script

```bash
python -c "
import sys
print(f'Python: {sys.version}')
import sklearn; print(f'scikit-learn: {sklearn.__version__}')
import xgboost; print(f'XGBoost: {xgboost.__version__}')
import pandas; print(f'pandas: {pandas.__version__}')
import streamlit; print(f'Streamlit: {streamlit.__version__}')
import fastapi; print(f'FastAPI: {fastapi.__version__}')
print('✅ All dependencies installed successfully!')
"
```

### Check Model Files

```bash
# Verify trained models exist
ls -la models/  # Unix/Linux/macOS
dir models     # Windows

# Expected files:
# - best_model.joblib
# - feature_engineer.joblib
# - fairness_report.json
# - training_summary.json
```

---

## 🚀 Quick Start Commands

### Complete Setup (All-in-One)

```bash
# Clone, setup, and run everything
git clone https://github.com/mstfyshrqawy520-alt/credit-risk-engine.git
cd credit-risk-engine
python -m venv venv

# Activate venv
source venv/bin/activate  # Unix
# OR
venv\Scripts\activate     # Windows

# Install dependencies
pip install -r requirements.txt

# Train models
python scripts/train.py

# Start services (in separate terminals as shown above)
```

---

## 📞 Support

### Contact Developer

- **Email**: mostafa.elsharqawi@gmail.com
- **Phone**: +201276913999
- **LinkedIn**: [Mostafa Ali Mohamed Elsharqawi](https://www.linkedin.com/in/mostafa-ali-66b3a7352/)

### Report Issues

- 🐛 GitHub Issues: https://github.com/mstfyshrqawy520-alt/credit-risk-engine/issues
- 📧 Direct Email: mostafa.elsharqawi@gmail.com

---

## 📚 Additional Resources

- [README.md](README.md) - Project overview
- [PROJECT_INFO.md](PROJECT_INFO.md) - Technical details
- [AUTHOR.md](AUTHOR.md) - Developer information
- [API Documentation](http://localhost:8000/docs) - Interactive API docs
- [GitHub Repository](https://github.com/mstfyshrqawy520-alt/credit-risk-engine)

---

**© 2026 Mostafa Ali Mohamed Elsharqawi**  
_Made with ❤️ and ☕_
