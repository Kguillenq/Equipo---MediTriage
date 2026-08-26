Feature: Tablero Médico en Tiempo Real y Alertas Críticas 

Scenario: Alerta para paciente ESI 1 (🟢)

Given que un paciente ha sido categorizado con ESI 1
When el sistema registra la categorización final
Then debe enviar inmediatamente la actualización al tablero médico mediante WebSockets
And el paciente debe aparecer destacado como caso crítico
And debe activarse la alerta visual y sonora correspondiente
And la actualización debe reflejarse en menos de 1 segundo.

Scenario: Paciente categorizado como ESI 2 (🟡)

Given que un paciente ha sido categorizado con ESI 2
When el sistema registra su categorización final
Then debe actualizar el tablero médico en tiempo real
And debe destacar al paciente como caso de alta prioridad
And debe activar la alerta correspondiente a ESI 2.

Scenario: Pérdida de conexión con el tablero (🔴)

Given que el tablero médico se encuentra conectado al sistema mediante WebSockets
When se pierde la conexión mientras se registra un paciente ESI 1 o ESI 2
Then el sistema debe detectar la pérdida de conexión
And debe intentar restablecer la comunicación
And debe conservar el evento de categorización para evitar su pérdida
And debe actualizar el tablero una vez restablecida la conexión.
