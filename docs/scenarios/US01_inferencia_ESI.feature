Feature: Formulario e Inferencia ESI Asistida por IA

Scenario: Ingreso correcto de signos vitales y síntomas (🟢)

Given que la enfermera está en el formulario de triage
And ha ingresado todos los signos vitales y síntomas requeridos
When presiona el botón "Calcular ESI"
Then el sistema muestra el nivel ESI sugerido (1–5)
And presenta una justificación clínica en lenguaje natural
And el tiempo de respuesta es menor a 3 segundos


Scenario: Ingreso parcial de datos clínicos mínimos (🟡)

Given que la enfermera ingresa solo temperatura y frecuencia cardíaca
When solicita la inferencia ESI
Then el sistema calcula un nivel ESI con menor precisión
And muestra una advertencia indicando que faltan datos complementarios
But mantiene el tiempo de respuesta bajo 3 segundos


Scenario: Error por datos inválidos en el formulario (🔴)

Given que la enfermera ingresa valores fuera de rango (ej. temperatura = -5°C)
When intenta calcular el ESI
Then el sistema muestra un mensaje de error indicando datos inválidos
And no genera una justificación clínica
And registra el evento en el log de errores
