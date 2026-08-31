from fastapi import FastAPI
from app.api.v1.endpoints import health

app = FastAPI(
    title="MediTriage API",
    version="0.1.0",
    description="Backend base para MediTriage"
)

app.include_router(health.router, prefix="/api/v1")

@app.get("/")
def root():
    return {"message": "Servidor MediTriage activo", "docs": "/docs"}
