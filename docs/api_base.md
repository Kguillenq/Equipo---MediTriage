# 🏥 API Base - MediTriage (Contrato V1)

Este documento define los endpoints principales RESTful, filtros, paginación y códigos de estado esperados para el MVP. Sirve como contrato para el desarrollo en paralelo de Frontend y Backend.

---

## ⚙️ Estándares Generales de la API

*   **Paginación por defecto:** Se usará el formato `?skip=0&limit=20` (o `page=1&size=20`) en los endpoints que devuelvan listas (`GET`).
*   **Códigos de Estado (HTTP Status Codes) Estándar:**
    *   `200 OK`: Petición exitosa (GET, PATCH).
    *   `201 Created`: Recurso creado exitosamente (POST).
    *   `400 Bad Request`: Error en los datos enviados por el cliente.
    *   `401 Unauthorized`: Falta token de autenticación.
    *   `403 Forbidden`: El usuario no tiene permisos (ej. un enfermero intentando ver auditorías).
    *   `404 Not Found`: El recurso solicitado (ID) no existe.
    *   `422 Unprocessable Entity`: Error de validación de datos (típico de FastAPI).
    *   `500 Internal Server Error`: Error inesperado en el servidor/IA.

---

## 👥 1. Dominio: Pacientes (Admisión / Sala de Espera)

### `POST /patients`
*   **Descripción:** Registra un nuevo paciente.
*   **Códigos esperados:** `201 Created`, `400 Bad Request`, `409 Conflict` (Si el RUT ya está ingresado y activo).

### `GET /patients`
*   **Descripción:** Obtiene la lista de pacientes registrados.
*   **Paginación:** Sí (`?skip=0&limit=50`).
*   **Filtros soportados:** 
    *   `?rut=11.111.111-1` (Búsqueda exacta).
    *   `?name=juan` (Búsqueda parcial).
*   **Códigos esperados:** `200 OK`.

---

## 🩺 2. Dominio: Triages (Enfermería y Médico)

### `POST /triages`
*   **Descripción:** Crea una nueva evaluación de triage y solicita predicción a la IA.
*   **Códigos esperados:** `201 Created`, `422 Unprocessable Entity` (Faltan signos vitales requeridos).

### `GET /triages`
*   **Descripción:** Lista de triages para alimentar tableros.
*   **Paginación:** Sí (`?skip=0&limit=50`).
*   **Filtros soportados:**
    *   `?status=waiting|attending|discharged` (Para separar a los que esperan de los atendidos).
    *   `?esi_level=1|2|3|4|5` (Para filtrar por gravedad).
    *   `?sort=-esi_level` (Ordenamiento por gravedad y hora de llegada).
*   **Códigos esperados:** `200 OK`.

### `PATCH /triages/{triage_id}`
*   **Descripción:** Actualiza el estado del flujo del paciente (Ej: Pasa a "En Atención").
*   **Códigos esperados:** `200 OK`, `404 Not Found`, `422 Unprocessable Entity`.

### `POST /triages/{triage_id}/overrides`
*   **Descripción:** Sobrescribe el nivel ESI de la IA. Exige el nuevo nivel y `justification` en el body.
*   **Códigos esperados:** `201 Created`, `400 Bad Request` (Si falta la justificación), `404 Not Found`.

---

## 📋 3. Dominio: Auditoría y Trazabilidad

### `GET /audit-logs`
*   **Descripción:** Historial inmutable para el Panel de Auditoría (Discrepancias IA vs Humano).
*   **Paginación:** Sí (`?page=1&size=100`).
*   **Filtros soportados:**
    *   `?start_date=2026-09-01&end_date=2026-09-30` (Rango de fechas).
    *   `?has_discrepancy=true` (Para ver solo donde el médico cambió la decisión de la IA).
    *   `?user_id=123` (Para auditar a un profesional específico).
*   **Códigos esperados:** `200 OK`, `403 Forbidden` (Si no se tiene rol de Auditor).
