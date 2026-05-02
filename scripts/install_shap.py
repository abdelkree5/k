#!/usr/bin/env python
"""Install SHAP in the AI environment."""
import subprocess
import sys

result = subprocess.run(
    [sys.executable, "-m", "pip", "install", "shap", "--quiet"],
    capture_output=True,
    text=True
)

if result.returncode == 0:
    print("✓ SHAP installed successfully")
    # Verify installation
    import shap
    print(f"✓ SHAP version: {shap.__version__}")
else:
    print("✗ Installation failed:")
    print(result.stderr)
    sys.exit(1)
