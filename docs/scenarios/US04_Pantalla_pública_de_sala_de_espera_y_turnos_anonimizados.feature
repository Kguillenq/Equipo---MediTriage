Feature: Pantalla Pública de Sala de Espera

Scenario: Visualización de un turno anonimizado (🟢)

Given que un paciente tiene un turno registrado en el sistema
And su categorización ESI ha sido registrada
When la pantalla pública consulta los turnos disponibles
Then debe mostrar el identificador anonimizado del turno
And debe mostrar su estado actual de atención
And debe mostrar el tiempo estimado de espera correspondiente
And no debe mostrar el nombre completo ni el RUT del paciente.

Scenario: Actualización simultánea de varios turnos (🟡)

Given que existen varios pacientes esperando atención
And sus turnos pertenecen a diferentes categorías ESI
When se actualiza el estado de uno o más pacientes
Then la pantalla pública debe actualizar los turnos automáticamente
And debe mantener el orden de atención correspondiente a la prioridad definida
And debe continuar mostrando únicamente identificadores anonimizados.

Scenario: Intento de mostrar datos personales (🔴)

Given que existe información personal del paciente almacenada en el sistema
When la pantalla pública solicita los datos necesarios para mostrar los turnos
Then el sistema debe excluir el RUT, nombre completo y otros datos personales
And debe mostrar únicamente el identificador público del turno
And no debe exponer información clínica del paciente.
