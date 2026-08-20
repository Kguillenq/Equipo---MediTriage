# CHARTER

## Misión del equipo:

Desarrollar, desplegar y operar una plataforma de triage clínico asistida por Inteligencia Artificial que optimice los tiempos de espera y la priorización de pacientes en la red   de atención primaria de urgencias, garantizando la máxima seguridad clínica, explicabilidad en cada decisión médica y el estricto cumplimiento del marco legal chileno sobre       protección de datos sensibles.

## Valores:

Nos comprometemos con la humanización de la atención médica mediante el desarrollo de tecnología rápida, confiable e invisible que empodere al personal de salud, estableciendo un nuevo estándar de seguridad, transparencia y apoyo a la decisión clínica en las salas de urgencia de Chile.

## Reglas de trabajo:

1- Protección de Rama Principal: Nadie sube cambios directos a main. Todo cambio entra mediante Pull Request (PR) asociado a un Issue.

2- Cultura de Consulta Temprana: Si un bloqueo técnico o de lógica clínica toma más de 45 minutos sin avance, se debe escalar abiertamente al equipo para resolverlo en conjunto.

3- Priorización sin Interrupciones: Respetar los bloques de trabajo profundo (deep work), usando canales de comunicación asíncronos para temas que no requieran atención inmediata.


## Canal de comunicación:

El equipo se comunicará por via Discord para llamadas y via WhatsApps para coordinar reuniones.

## Cadencia de reuniones:

El equipo acordó reunirse cada lunes a las 17:00 horas.

## Propositos:

Disminuir los tiempos críticos de espera y optimizar la categorización clínica en salas de urgencia de atención primaria chilena, mediante una plataforma asistida por IA que clasifica pacientes bajo el estándar ESI (1–5) de forma explicable, segura y en estricto apego a las leyes de protección de datos sensibles (Ley 19.628 y Ley 21.719).

## Integrantes y roles:

- Lucas Benítez (Tech lead)
  
- Marcela Contreras (QA)
  
- Kimberlly Guillén (PO)
  
- Antonia Moya (AI/Data)
  
- Isidora Ramos (DevSecOps)

- Josefa Rodríguez (QA)

## DoD:

1- Criterios de Aceptación Cumplidos: La historia de usuario o funcionalidad cuenta con escenarios BDD (Given / When / Then) probados y aprobados por QA.

2- Cobertura de Pruebas: Mínimo 80% de cobertura en pruebas unitarias e integración para componentes clave (backend, frontend y llamadas al modelo).

3- Zero PII Leakage y Privacidad: Garantizar el filtrado de RUT y datos personales antes de enviar información a la IA, operando solo con datos sintéticos en pruebas (Ley 19.628 / Ley 21.719).

4- Rendimiento y Explicabilidad: La clasificación ESI responde en menos de 3 segundos e incluye obligatoriamente una justificación clínica en lenguaje natural.

5- Aprobación de Pull Request: Código revisado y aprobado por al menos 1 integrante mediante Pull Request asociado a un Issue en GitHub.

## Política de IA:

### 1. Principio de Asistencia y No Sustitución (Human-in-the-Loop)
* El motor de IA actúa estrictamente como una **herramienta de soporte a la decisión clínica** y no como un diagnosticador autónomo.
* La categorización ESI sugerida y su justificación son recomendaciones; **la decisión final de priorización y atención médica recae exclusivamente en el personal de salud (enfermera/o de triage o médico de turno)**.
* En casos de discrepancia entre el criterio clínico humano y la sugerencia algorítmica, siempre prevalecerá el juicio del profesional de salud, quedando registrado el motivo del cambio en el sistema.

### 2. Privacidad y Regla de Cero Fuga de Datos (Zero PII Leakage)
* **Cumplimiento Legal:** En estricto apego a las Leyes 19.628 y 21.719, queda terminantemente prohibido el envío de Datos de Identificación Personal (PII) —como RUT, nombres, apellidos, domicilios, teléfonos o emails— a modelos de lenguaje o servicios de IA externos.
* **Pipeline de Anonimización:** Antes de procesar cualquier inferencia, el sistema debe ejecutar una capa obligatoria de disociación y sanitización en el backend. La IA únicamente recibirá variables clínicas esenciales: edad, sexo biológico, signos vitales numéricos y descripción estandarizada de síntomas.
* **Prohibición de Datos Reales en Pruebas:** Los entornos de desarrollo, tests automatizados y validaciones del modelo deben operar exclusivamente con datos sintéticos generados.

### 3. Explicabilidad, Transparencia y Trazabilidad
* **Caja Blanca:** Todo resultado entregado por el modelo debe incluir de forma obligatoria una justificación clínica en lenguaje natural que explique de forma comprensible el porqué del nivel ESI sugerido (basándose en estabilidad fisiológica, recursos estimados y riesgo vital).
* **Inmutabilidad:** Cada prompt enviado, la respuesta íntegra del modelo, la versión del algoritmo utilizado y la decisión final del profesional quedarán registrados en un *Audit Log* inmutable, conservado por un mínimo de 5 años.

### 4. Mitigación de Sesgos y Seguridad Clínica
* El modelo no debe utilizar variables socioeconómicas, de procedencia geográfica o previsionales (Fonasa/Isapre) para ponderar la gravedad del paciente.
* Todo cambio o ajuste de prompts (*prompt engineering*) o cambio de modelo de IA debe ser previamente validado con una batería de pruebas de casos clínicos límite (ej. paro inminente, shock anafiláctico) antes de pasar a producción.

## Canal Slack:

### Canales de Comunicación

* **Canal de Slack del Proyecto:** https://discord.gg/kY8pJNr2zg
* 
* **Comunidad de WhatsApp:** https://chat.whatsapp.com/L8Gsl4UswJVGJHbh5qdRZV
