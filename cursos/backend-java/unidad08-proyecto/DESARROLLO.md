# Transformar el catálogo en una entrega que otra persona pueda reconstruir

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## 1. Convierte la necesidad en aceptación observable

El proyecto propio puede mantener el caso de materiales y añadir una regla concreta, por ejemplo precio máximo 500. La referencia no incluye ese máximo. Documenta primero quién necesita la regla, en qué operaciones aplica y cómo distinguirás dato válido de rechazo. Cambiar nombres de clases sin variar requisitos no añade un caso de uso.

| Requisito propuesto | Aceptación | Rechazo o límite |
|---|---|---|
| Registrar material | SKU único, nombre válido y precio positivo | Duplicado 409 |
| Editar sin perder otro cambio | Versión vigente actualiza y devuelve nueva versión | Versión antigua 409 sin sobrescribir |
| Conservar datos | Reiniciar sobre el mismo almacenamiento mantiene el recurso | Documentar pérdida si se usa memoria |
| Limitar precio (ampliación propia) | 500 aceptado | 500.01 rechazado, tras implementar la regla |

## 2. Entrega por tramos con una salida comprobable

Primero contrato y recurso. Después casos válidos y rechazos. Añade persistencia/versiones y prueba su estado posterior. Continúa con permisos y proveedor solo cuando el flujo anterior sea repetible. Termina con artefacto, configuración y diagnóstico.

Para un comando que modifica datos, la política de acceso debe estar definida y el error no debe dejar cambios parciales. Para una lectura externa, define qué datos aceptas y si guarda o no el resultado. La ausencia de esos acuerdos genera decisiones incompatibles entre Controller, Service y cliente.

## 3. Prepara una instalación desde una copia nueva

La [plantilla de entrega](../docs/PLANTILLA_PROYECTO.md) pide raíz, versiones, revisión, comandos, datos y resultado esperado. El JAR puede ejecutarse con configuración externa sin recompilar por una contraseña. El perfil y la URL seleccionan un entorno; no trasladan automáticamente los registros de H2 a PostgreSQL.

Otra persona debe poder reconstruir el mínimo sin rutas de tu equipo ni credenciales en archivos públicos. Usa variables externas y datos ficticios. Explica cómo detener el proceso y cuál almacenamiento conserva la práctica. La prueba del archivo temporal no guarda información para el proyecto del estudiante.

## 4. Evalúa evidencia, no cantidad de tecnología

| Criterio | Puntos | Evidencia mínima |
|---|---|---|
| Problema y contrato | 15 | Usuario, alcance y ejemplos HTTP |
| Flujo y capas | 20 | Recorrido completo y responsabilidades |
| Reglas y errores | 20 | Válido, límite, rechazo y estado posterior |
| Persistencia y concurrencia | 15 | Reinicio y versión antigua; motor declarado |
| Pruebas y evidencia | 15 | Comandos repetibles y resultados |
| Seguridad, configuración y entrega | 15 | Permitido/denegado y arranque reproducible |

Total: 100. Un criterio sin evidencia señala trabajo pendiente. La rúbrica orienta autoevaluación; no acredita por sí sola disponibilidad, seguridad ni rendimiento productivo.

## 5. Presenta límites concretos

El catálogo no administra stock físico, pagos ni identidad externa. Un diseño de despliegue no es un despliegue ejecutado. Para ampliar pedidos, estudia captura del precio al confirmar, cancelación, historial y transacciones antes de añadir otra entidad. Preservar una historia correcta vale más que acumular pantallas sin un flujo terminado.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Entrega%20y%20proyecto%20propio%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad08-proyecto%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
