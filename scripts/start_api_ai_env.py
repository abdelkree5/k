#!/usr/bin/env python
"""Start the API server in the ai_env."""
import subprocess
import sys

# Path to ai_env Python
ai_env_python = r"C:\Users\MostafaAliMohamedElS\miniconda3\envs\ai_env\python.exe"

# Run uvicorn
result = subprocess.run(
    [ai_env_python, "-m", "uvicorn", "api.app:app", 
     "--host", "127.0.0.1", "--port", "8000", "--reload"],
    cwd=r"E:\project\credit-risk-engine-main(ML)"
)

sys.exit(result.returncode)
