Feature: Registro Inmutable de Auditoría Clínico-Algorítmica

Scenario: Registro completo de la atención (🟢)

Given que una atención de triage ha finalizado
And existe una recomendación ESI generada por la IA
And existe una decisión final registrada por el profesional
When el sistema genera el registro de auditoría
Then debe almacenar la recomendación inicial de la IA
And debe almacenar su justificación clínica
And debe almacenar los datos de entrada sanitizados
And debe almacenar la decisión final del profesional
And debe registrar la fecha y hora del evento.

Scenario: Decisión final diferente a la recomendación de IA (🟡)

Given que la IA ha recomendado una categoría ESI
And la enfermera/o ha decidido utilizar una categoría diferente
When se genera el registro de auditoría
Then el sistema debe conservar la recomendación original de la IA
And debe registrar la categoría seleccionada por el profesional
And debe almacenar la justificación de la modificación
And debe mantener ambas decisiones para permitir la trazabilidad.

Scenario: Intento de modificar un registro de auditoría (🔴)

Given que existe un registro de auditoría almacenado
When un usuario intenta modificar o eliminar dicho registro
Then el sistema debe rechazar la operación
And el registro original debe permanecer sin modificaciones
And debe mantenerse la integridad de la información registrada.
