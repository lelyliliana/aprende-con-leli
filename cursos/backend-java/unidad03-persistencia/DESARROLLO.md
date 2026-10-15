# Comprobar duración y concurrencia como decisiones separadas

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## 1. Identifica qué cambia al introducir una base

JPA añade Producto, Categoria, repositorios, migraciones y transacciones. La entrada de creación incluye categoriaId; la actualización incluye version. La respuesta incorpora la categoría y la versión administrada. Estas diferencias pertenecen al contrato de esa etapa, no son campos que el cliente deba inventar en REST.

Antes de crear, consulta /api/categorias y utiliza un id recibido. Una referencia positiva pero ausente no satisface la relación. El servicio la rechaza y la FK protege el esquema. Los datos ficticios de dev facilitan comenzar, pero no convierten sus identificadores en valores universales para otra base.

## 2. Sigue un conflicto de versión completo

Crea BACK-DUR con precio 10 y versión inicial 0. Una actualización válida envía esa versión y precio 15. La respuesta entrega versión 1. Si otro cliente intenta precio 99 con versión 0, recibe 409. GET posterior debe conservar precio 15 y versión 1.

| Momento | Precio solicitado | Versión enviada | Estado que debe quedar |
|---|---|---|---|
| Crear | 10 | No se envía | Precio 10, versión 0 |
| Actualizar | 15 | 0 | Precio 15, versión 1 |
| Actualización vieja | 99 | 0 | Precio 15, versión 1 |

La comparación explícita de versión rechaza una intención vieja. @Version añade protección si hay una carrera después de leer. UNIQUE protege SKU entre transacciones. Son garantías relacionadas, pero no una sola clase de bloqueo que impida toda concurrencia.

## 3. Diferencia flush, commit y duración

El [servicio JPA](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/laboratorios/jpa-productos/src/main/java/com/lelyliliana/productos/ProductoService.java) usa transacciones y flush. Flush envía cambios al motor y permite observar restricciones; no es sinónimo de commit. El límite transaccional confirma o revierte la unidad.

H2 en memoria conserva entre peticiones de la misma JVM; no entre reinicios. H2 en archivo conserva si vuelves a abrir la misma ruta. Ninguno de esos dos resultados demuestra por sí solo compatibilidad con PostgreSQL. Tampoco un reinicio limpio equivale a probar recuperación después de corte eléctrico.

## 4. Cambia una sola variable en el experimento

El [experimento de persistencia](../docs/EXPERIMENTOS.md) reutiliza el JAR, crea un archivo temporal propio, actualiza, rechaza una versión vieja, detiene Java y abre el mismo archivo con una JVM nueva. Compara el recurso completo y comprueba que no apareció duplicado.

El archivo se elimina al terminar el experimento: sirve para comprobar el comportamiento, no para guardar tu proyecto. Para práctica manual duradera usa la [guía de archivo](../../fullstack/laboratorio/docs/PERSISTENCIA.md) y mantén la misma carpeta de ejecución. No abras simultáneamente el mismo archivo desde dos servidores.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Persistencia%20y%20concurrencia%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad03-persistencia%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
