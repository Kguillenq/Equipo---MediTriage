# 🏥 API Base - MediTriage

Este documento define los endpoints principales RESTful para el MVP de MediTriage. 
Sirve como contrato base para que los equipos de Frontend y Backend puedan trabajar en paralelo.

## 👥 1. Dominio: Pacientes (Admisión / Sala de Espera)

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| **POST** | `/patients` | Registra un nuevo paciente (RUT, nombre, demografía, consentimiento). |
| **GET** | `/patients` | Obtiene la lista de pacientes registrados (útil para búsqueda y sala de espera). |

## 🩺 2. Dominio: Triages (Enfermería y Médico)

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| **POST** | `/triages` | Crea una nueva evaluación de triage. Recibe síntomas y signos vitales; retorna la sugerencia ESI de la IA. |
| **GET** | `/triages` | Obtiene la lista de triages activos. Soporta filtros (ej. `?status=waiting&sort=esi_level`) para el Tablero Médico. |
| **PATCH**| `/triages/{triage_id}`| Actualiza un triage específico (ej. sobrescritura manual del ESI por enfermería o cambio de estado a "En Atención"). |

## 📋 3. Dominio: Auditoría y Trazabilidad

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| **GET** | `/audit-logs` | Obtiene el historial inmutable de decisiones y discrepancias (IA vs. Humano) para el Panel de Auditoría. |

---
*Nota para el equipo: Estos endpoints están en desarrollo. Las estructuras exactas de los JSON (requests/responses) se definirán en la especificación OpenAPI (Swagger) generada por FastAPI.*
