# Política de versionado de la API de MediTriage

## 1. Esquema de versionado

MediTriage utiliza versionado mayor en la ruta de la API. La versión actual corresponde a `/api/v1`.

Los cambios compatibles se incorporan manteniendo la versión actual. Los cambios incompatibles requieren una nueva versión mayor, por ejemplo `/api/v2`.

## 2. Cambios incompatibles (Breaking Changes)

Se consideran cambios incompatibles:

* Eliminar un endpoint o cambiar su ruta.
* Eliminar o renombrar campos existentes de una solicitud o respuesta.
* Cambiar el tipo de dato de un campo.
* Incorporar campos obligatorios que los clientes actuales no envían.
* Modificar el significado de un campo o el comportamiento de una operación de forma incompatible.

Los cambios compatibles, como agregar campos opcionales o nuevos endpoints, pueden incorporarse en la versión actual siempre que no afecten a los clientes existentes.

## 3. Deprecación de versiones

Cuando una versión de la API vaya a ser retirada:

1. Se comunicará la deprecación en la documentación y a los consumidores conocidos.
2. Se indicará qué versión la reemplazará y la fecha prevista de retiro.
3. Se mantendrá la versión anterior durante un mínimo de 6 meses desde el anuncio de deprecación, salvo que exista una razón crítica de seguridad o legal.
4. Antes del retiro, se actualizarán los ejemplos y la documentación para orientar a los consumidores hacia la nueva versión.

## 4. Compatibilidad y documentación

Cada versión publicada debe mantener su propia documentación OpenAPI y ejemplos de solicitudes y respuestas. Los cambios deben revisarse para comprobar que los ejemplos cumplen los esquemas definidos.
