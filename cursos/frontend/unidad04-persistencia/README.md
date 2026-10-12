# Unidad 04. Datos locales y reglas del proyecto

[Volver al índice](../README.md)

## Objetivos

Separar reglas y persistencia, y reconocer los límites de datos locales.

## Explicación y práctica guiada

Lee dominio.js y almacenamiento.js. El primero contiene reglas que no conocen React ni DOM: validar títulos, agregar, alternar, eliminar y filtrar. El segundo serializa un documento con version y tareas bajo una clave propia.

El título se recorta y admite de 1 a 80 unidades de longitud de cadena JavaScript. El plan admite hasta 100 tareas. Los IDs son UUID y deben ser distintos. Agregar devuelve una colección nueva; no modifica el arreglo recibido. Estas decisiones permiten probar reglas fuera de la interfaz.

La inicialización lee antes de aceptar datos. Si el JSON o su esquema son inválidos, se informa el problema y se bloquean modificaciones. La lectura no sustituye automáticamente el valor corrupto por una lista vacía. Copia el contenido si necesitas analizarlo y corrige únicamente la clave del laboratorio antes de recargar.

Si una escritura falla, el cambio permanece en la sesión pero se muestra que no quedó guardado. Recargar en ese estado puede perder la modificación. Una confirmación visual y una confirmación de persistencia no son equivalentes.

localStorage guarda cadenas asociadas al origen. No es una base remota, una copia de seguridad ni una cuenta. Para aprender la herramienta, consulta [Storage](https://github.com/lelyliliana/Curso-JavaScript/blob/main/unidad16-storage/README.md).

JavaScript y React usan el mismo documento. Cambiar de página mantiene los datos; cambiar navegador, host o puerto puede mostrar otro almacenamiento. Esta práctica no coordina ediciones simultáneas entre pestañas.

## Ejercicios

1. Crea una tarea en JavaScript, recarga y confirma que continúa guardada.
2. Abre React después de cerrar la versión JavaScript y comprueba que conserva la tarea.
3. Explica qué sucede al abrir el plan desde otro puerto y por qué no es necesariamente pérdida de datos.

## Reto

Demuestra una lectura inválida con datos ficticios en una copia de práctica. Conserva el valor original y registra cómo recuperaste la clave.

## Errores frecuentes

Guardar automáticamente una lista vacía al iniciar; confundir almacenamiento local con respaldo; borrar todas las claves del sitio para resolver una sola.

## Comprobación para avanzar

Puedes explicar el documento versionado y distinguir estado en memoria, guardado correcto y fallo de almacenamiento.

## Continuar

- [Unidad anterior](../unidad03-javascript/README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Volver al índice](../README.md)
- [Siguiente unidad](../unidad05-react/README.md)
