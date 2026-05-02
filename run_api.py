#!/usr/bin/env python
"""Run the FastAPI server."""
from pathlib import Path
import sys
import subprocess

# Change to project directory
proj_dir = Path(__file__).parent
sys.path.insert(0, str(proj_dir))

# Run uvicorn
subprocess.run(
    [sys.executable, "-m", "uvicorn", "api.app:app", 
     "--host", "127.0.0.1", "--port", "8000", "--reload"],
    cwd=proj_dir
)
