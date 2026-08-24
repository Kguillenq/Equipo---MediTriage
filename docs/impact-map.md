# Impact Map - MediTriage

## 1. Goal (Objetivo de Negocio)
Reducir el tiempo de priorización clínica de los pacientes en la sala de urgencias de 25 minutos a menos de 3 minutos, optimizando la categorización ESI (1-5) de forma segura.

## 2. Actores Clave
1. **Enfermera/o de Triage:** Profesional en la primera línea de atención que ingresa los signos vitales.
2. **Médico de Turno:** Profesional responsable de la atención definitiva y del manejo de casos críticos de riesgo vital.
3. **Paciente:** Persona que acude a urgencias y requiere conocer su tiempo de espera y orden de atención.
4. **Auditor clínico:** Encargado de revisar y verificar que las decisiones automatizadas de la IA cumplan con la normativa y queden registradas.

## 3. Construcción del Mapa (Goal → Actor → Impacto → Entregable)

### Flujo 1: Enfermera/o de Triage
* **Goal:** Reducir el tiempo de priorización a < 3 minutos.
* **Actor:** Enfermera/o de triage.
* **Impacto:** Obtiene una sugerencia clínica instantánea (ESI) que valida rápidamente, eliminando el cálculo manual de la gravedad.
* **Entregable:** Pantalla de registro de signos vitales conectada a un motor IA que devuelve la categoría ESI sugerida junto con su justificación en lenguaje natural.

### Flujo 2: Médico de Turno
* **Goal:** Reducir el tiempo de priorización a < 3 minutos.
* **Actor:** Médico de turno.
* **Impacto:** Se entera de forma proactiva e inmediata sobre los pacientes de alta gravedad (ESI 1) para intervenir sin depender de avisos verbales.
* **Entregable:** Sistema de alertas y notificaciones en tiempo real (push/WebSocket) que resalta los casos críticos en el tablero médico.

### Flujo 3: Paciente 
* **Goal:** Reducir el tiempo de priorización clínica a < 3 minutos y disminuir la incertidumbre en sala de espera.
* **Actor:** Paciente en sala de espera.
* **Impacto:** Comprende el criterio de categorización ESI (que se atiende por gravedad y no por orden de llegada), reduciendo la ansiedad y las agresiones/consultas repetitivas al personal de enfermería.
* **Entregable:** Pantalla/Dashboard público para la sala de espera con llamado de turnos anonimizados (ej. "Turno A-12: Categoría ESI 2 - En atención") y tiempos estimados de espera por categoría.

### Flujo 4: Auditor Clínico
* **Goal:** Reducir el tiempo de priorización a < 3 minutos de forma segura y auditable.
* **Actor:** Auditor clínico.
* **Impacto:** Revisa y audita las decisiones pasadas de la IA de forma transparente, sin interrumpir ni ralentizar el flujo de atención rápida en la urgencia.
* **Entregable:** Registro de auditoría (audit log) inmutable que almacena cada recomendación de la IA, su justificación y los datos de entrada durante 5 años.
