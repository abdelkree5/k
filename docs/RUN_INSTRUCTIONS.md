Quick Run Instructions — Credit Risk Engine

Local (API only)

1. Activate your conda env (or use the project's Python):

   conda activate ai_env

2. Run the API (uses models/ produced by `scripts/train.py`):

   python -m uvicorn api.app:app --host 127.0.0.1 --port 8000

3. Health check:

   curl http://127.0.0.1:8000/health

Train models (creates `models/`):

python scripts/train.py

Run tests:

python -m pytest -q

Run both API + Streamlit (recommended: Docker)

1. Build and start with Docker Compose (recommended — isolates dependencies):

   docker-compose up --build -d

- API: http://127.0.0.1:8000
- Streamlit dashboard: http://127.0.0.1:8501

Docker files:

- `Dockerfile.api` builds the FastAPI service only.
- `Dockerfile.streamlit` builds the dashboard only.
- `docker-compose.yml` wires them together and points the dashboard at `http://api:8000`.

Notes and troubleshooting

- Streamlit had dependency issues in the current conda env (Starlette version conflicts). If `streamlit` fails to import, prefer running via Docker Compose which isolates the environment.
- If you prefer to run Streamlit locally, create a fresh venv and install `streamlit` there:

  python -m venv .venv
  .venv\Scripts\activate
  pip install -r requirements.txt
  pip install streamlit
  streamlit run streamlit_app/dashboard.py --server.port 8501

- Models are saved to `models/` by `scripts/train.py`. The API looks for `models/best_model.joblib` and `models/feature_engineer.joblib`.

Files changed during setup:

- `src/model_training.py` — added fallbacks and mlflow guards
- `src/explainability.py` — lazy-import shap with friendly error

If you want, I can now:

- Attempt to run Docker Compose here to bring up both services, or
- Continue resolving Streamlit import issues inside the conda env (longer).
