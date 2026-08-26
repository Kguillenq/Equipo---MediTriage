Feature: Sobreescritura Manual de ESI (Human‑in‑the‑Loop)

Scenario: Confirmación manual del nivel ESI sugerido (🟢)

Given que la enfermera visualiza la recomendación de la IA
When confirma el nivel ESI y agrega una breve justificación clínica
Then el sistema guarda la decisión final en la base de datos
And registra que la decisión fue validada por un humano


Scenario: Modificación parcial del nivel ESI (🟡)

Given que la enfermera decide ajustar el nivel ESI sugerido
And selecciona un motivo predefinido (ej. palidez o dolor intenso)
When guarda la modificación
Then el sistema actualiza el nivel ESI y conserva la justificación anterior
And marca el registro como “modificado manualmente”


Scenario: Error al guardar la sobreescritura manual (🔴)

Given que la enfermera modifica el nivel ESI
When intenta guardar la decisión y ocurre un error de conexión
Then el sistema muestra un mensaje de error “No se pudo guardar la decisión”
And mantiene los datos en memoria local para reintento
And registra el fallo en el log de auditoría
