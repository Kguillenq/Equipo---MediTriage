import os
import uvicorn
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

if __name__ == "__main__":
    port = int(os.getenv("PORT", 8000))
    uvicorn.run("main:app", host="0.0.0.0", port=port, reload=True)
