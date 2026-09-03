# Atributos de Calidad Prioritarios (Top 3 NFRs) - MediTriage

| Atributo | Prioridad | Métrica Objetivo (SLO) | Justificación Clínica / Técnica | Impacto Arquitectural |
| :--- | :--- | :--- | :--- | :--- |
| **Disponibilidad** | P1 (Crítica) | 99.9% uptime | El triage en urgencias no puede detenerse por fallos del sistema. | Health checks (`/health`), reinicios automáticos en Docker y endpoints desacoplados. |
| **Performance** | P2 (Alta) | Latencia p95 < 200 ms | Respuesta inmediata al categorizar prioridad de pacientes críticos. | Backend asíncrono con FastAPI/Uvicorn y validaciones en memoria con Pydantic. |
| **Seguridad** | P3 (Alta) | 0 CVEs críticos / OWASP Top 10 | Protección de datos clínicos y fichas de pacientes. | Validación estricta de payloads, variables de entorno aisladas y red interna de BD. |
