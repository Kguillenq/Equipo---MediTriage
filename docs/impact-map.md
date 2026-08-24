# Impact Map - MediTriage

## 1. Goal (Objetivo de Negocio)
Reducir el tiempo de priorización clínica de los pacientes en la sala de urgencias de 25 minutos a menos de 3 minutos, optimizando la categorización ESI (1-5) de forma segura.

## 2. Actores Clave
1. **Enfermera/o de Triage:** Profesional en la primera línea de atención que ingresa los signos vitales.
2. **Médico de Turno:** Profesional responsable de la atención definitiva y del manejo de casos críticos de riesgo vital.

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
