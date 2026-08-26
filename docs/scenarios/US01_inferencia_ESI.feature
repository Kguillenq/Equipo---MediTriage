Feature: Formulario e Inferencia ESI Asistida por IA

Scenario: Ingreso correcto de signos vitales y síntomas
 Given que la enfermera está en el formulario de triage
  And ha ingresado todos los signos vitales y síntomas requeridos
  When presiona el botón "Calcular ESI"
  Then el sistema muestra el nivel ESI sugerido (1–5)
  And presenta una justificación clínica en lenguaje natural
  And el tiempo de respuesta es menor a 3 segundos
