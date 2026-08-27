# Historias de Usuario e INVEST — MediTriage

Este documento contiene el Product Backlog inicial de MediTriage derivado del Impact Map del proyecto, estructurado con la sintaxis oficial de historias de usuario y validado bajo el checklist de calidad **INVEST**.

---

## US-01: Formulario e Inferencia ESI Asistida por IA
* **Como** Enfermera/o de Triage,
* **Quiero** ingresar los signos vitales y síntomas del paciente en un formulario ágil para recibir una sugerencia de categorización ESI (1–5) acompañada de su justificación clínica en lenguaje natural,
* **Para** priorizar al paciente en la sala de espera en menos de 3 minutos sin depender de cálculos manuales.

### Checklist INVEST
* **I (Independent):** Se puede desarrollar y probar construyendo la interfaz de usuario y conectándola a un simulador (*mock*) de la API de IA, de forma independiente del tablero médico.
* **N (Negotiable):** Los campos opcionales del formulario y los parámetros de la justificación clínica son negociables con el equipo médico.
* **V (Valuable):** Aporta valor directo al reducir el tiempo de cálculo manual de gravedad de 25 minutos a menos de 3 minutos.
* **E (Estimable):** Estimado por el equipo de desarrollo en **5 Story Points**.
* **S (Small):** Es lo suficientemente pequeña para completarse dentro de un solo Sprint (2–3 días).
* **T (Testable):** Testeable objetivamente verificando la entrega del nivel ESI (1–5), la justificación en texto y el tiempo de respuesta (< 3 s).

---

## US-02: Sobreescritura Manual de ESI (Human-in-the-Loop)
* **Como** Enfermera/o de Triage,
* **Quiero** confirmar la recomendación de la IA o modificar manualmente el nivel ESI ingresando una breve justificación clínica,
* **Para** asegurar que el juicio del profesional de salud prevalezca siempre sobre el algoritmo.

### Checklist INVEST
* **I (Independent):** Se puede construir como un componente reactivo en la interfaz que modifica el estado antes de guardar los datos en la base de datos.
* **N (Negotiable):** Los motivos predefinidos de sobreescritura (ej. facies de dolor, palidez) pueden negociarse.
* **V (Valuable):** Cumple con el principio ético y legal de responsabilidad médica humana ante sistemas automatizados.
* **E (Estimable):** Estimado en **3 Story Points**.
* **S (Small):** Tarea acotada a la captura de eventos y cambio de estado en el backend.
* **T (Testable):** Testeable verificando en la base de datos que el nivel guardado refleje la decisión final tomada por la enfermera.

---

## US-03: Tablero Médico en Tiempo Real y Alertas Críticas (ESI 1 y 2)
* **Como** Médico de Turno,
* **Quiero** visualizar un tablero actualizado instantáneamente vía WebSockets que resalte visual y sonoramente los casos de riesgo vital (ESI 1 y ESI 2),
* **Para** intervenir de inmediato ante emergencias graves sin depender de avisos verbales.

### Checklist INVEST
* **I (Independent):** Se puede desarrollar conectando la vista del tablero a un canal Pub/Sub simulado en Redis.
* **N (Negotiable):** La intensidad de las alertas visuales y los patrones de sonido pueden ser negociados con el personal de urgencias.
* **V (Valuable):** Elimina el tiempo muerto de comunicación entre la sala de triage y los boxes de atención.
* **E (Estimable):** Estimado en **5 Story Points**.
* **S (Small):** Implementable dentro de un Sprint mediante Next.js y WebSockets.
* **T (Testable):** Testeable emitiendo un evento ESI 1 y midiendo el tiempo de despliegue en la pantalla del médico (< 1 s).

---

## US-04: Pantalla Pública de Sala de Espera y Turnos Anonimizados
* **Como** Paciente en sala de espera,
* **Quiero** consultar en un monitor público el estado de mi turno anonimizado (ej. "Turno A-12: Categoría ESI 2 - En atención") y el tiempo estimado de espera por categoría,
* **Para** comprender el orden de atención por gravedad clínica, reducir mi ansiedad y evitar consultas repetitivas al personal.

### Checklist INVEST
* **I (Independent):** Consume la lista de pacientes categorizados exponiendo únicamente identificadores públicos anonimizados.
* **N (Negotiable):** El diseño visual de la pantalla y el algoritmo de cálculo de tiempo estimado de espera son negociables.
* **V (Valuable):** Disminuye la ansiedad e incertidumbre del paciente y evita interrupciones constantes al personal de enfermería.
* **E (Estimable):** Estimado en **3 Story Points**.
* **S (Small):** Vista de lectura en frontend con refresco automático en tiempo real.
* **T (Testable):** Testeable confirmando que ningún dato de identificación personal (RUT o Nombre completo) sea visible en la pantalla pública.

---

## US-05: Registro Inmutable de Auditoría Clínico-Algorítmica
* **Como** Auditor Clínico,
* **Quiero** acceder a un registro inalterable que almacene la sugerencia inicial de la IA, su justificación, los datos de entrada sanitizados y la decisión final del profesional,
* **Para** auditar de forma transparente la calidad de las decisiones automatizadas y garantizar el cumplimiento normativo (Leyes 19.628 / 21.719) sin interrumpir la atención de urgencia.

### Checklist INVEST
* **I (Independent):** Registra eventos en segundo plano de forma asíncrona tras la confirmación de la atención en triage.
* **N (Negotiable):** Los filtros de búsqueda y los formatos de exportación de reportes son negociables.
* **V (Valuable):** Proporciona respaldo legal y trazabilidad inalterable ante fiscalizaciones durante un periodo de 5 años.
* **E (Estimable):** Estimado en **3 Story Points**.
* **S (Small):** Implementación mediante tabla *append-only* en PostgreSQL.
* **T (Testable):** Testeable intentando ejecutar operaciones de modificación (`UPDATE`) o borrado (`DELETE`), las cuales deben ser rechazadas por la base de datos.
```eof

---

**US-01:** Formulario e Inferencia ESI Asistida por IA (**Must have**):Es una funcionalidad clave del sistema, ya que permite reducir el tiempo de evaluación de 25 a menos de 3 minutos, que es uno de nuestro mayores propositos para este proyecto.
**US-02:** Manual de sobreescritura de ESI (Human-in-the-Loop) (**Must have**): Requisito ético y legal indispensable para asegurar que el criterio clínico de la enfermera/o prevalezca siempre sobre el programa antes de guardar los datos. 
**US-03:** Tablero Médico en Tiempo Real y Alertas Críticas (ESI 1 y 2) (**Must have**): Es importante para la comunicación inmediata con el médico ante pacientes con riesgo vital. El triage no es efectivo si no se notifica al instante. 
**US-05:** Registro Inmutable de Auditoría Clínico-Algorítmica (**Should have**): Esto Aporta alto valor de trazabilidad y cumplimiento normativo  de las Leyes 19.628 y 21.719, y se ejecuta en segundo plano, por lo que el triage puede operar si se pospone brevemente. 
**US-04:** Pantalla Pública de Sala de Espera y Turnos Anonimizados (**Could have**): Esto mejora la experiencia y reduce la ansiedad del paciente en sala de espera, pero su ausencia no interrumpe ni frena la operación clínica del personal de urgencias.
