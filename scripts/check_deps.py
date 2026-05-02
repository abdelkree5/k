import importlib
for pkg in ('fastapi','uvicorn','streamlit'):
    try:
        importlib.import_module(pkg)
        print(pkg, 'OK')
    except Exception:
        print(pkg, 'MISSING')
