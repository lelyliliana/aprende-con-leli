# Elegir una etapa y definir qué significa que funciona

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## 1. Parte de una necesidad pequeña

El caso de esta ruta es un catálogo de materiales para un equipo: registrar código, nombre y precio, consultar el catálogo y corregir información sin borrar el trabajo de otra persona. El código reutiliza el nombre técnico Producto. El caso no incluye existencias físicas, compras ni pagos; esas funciones necesitarían otras reglas.

Una API es una frontera entre programas. Un cliente envía método, ruta, headers y, cuando corresponde, cuerpo. El servidor interpreta la petición y devuelve status, headers y cuerpo. Compilar una clase solo demuestra parte de la construcción: todavía no demuestra que el proceso arranque ni que una petición cumpla el contrato.

## 2. Ubica la etapa antes de copiar JSON

| Etapa | Qué puedes practicar | Datos iniciales y duración |
|---|---|---|
| Fundamentos | Configuración, dependencias y saludo | Sin catálogo ni base |
| REST | CRUD, DTO, validación y errores | Mapa vacío; dura una JVM |
| JPA | Categoría, restricciones y versión | H2 dev con datos ficticios; por defecto memoria |
| Integrada | Proveedor, permisos, operación y pedidos | H2 dev; claves educativas externas |

Una petición con categoriaId tiene sentido en JPA, pero ese campo no forma parte de la entrada REST. Un fallo de permisos en la integrada tampoco explica por qué un POST a la etapa de mapa sería incorrecto. La primera decisión de diagnóstico es identificar qué proceso responde y con qué configuración.

## 3. Comprueba herramientas una por una

Desde una terminal ejecuta `java -version`. Después ejecuta `mvn -version` y compara el JDK efectivo. El segundo comando muestra qué Java utilizará Maven. La raíz de Curso-Spring-Boot contiene cuatro proyectos; no hay un pom general que los una. El argumento `-f` selecciona el que necesitas.

Sigue el [laboratorio](../laboratorio/README.md) para obtener la revisión fijada. Mantén identificadas dos raíces: Aprende con Leli contiene esta ruta y sus experimentos; Curso-Spring-Boot contiene los pom, JAR y fuentes Java. Un comando correcto desde la carpeta equivocada puede fallar antes de ejecutar tu programa.

## 4. Conserva una predicción que se pueda refutar

Una fila útil de bitácora dice: «Con REST recién iniciado, GET de productos devolverá total 0». Anota comando, revisión, respuesta y explicación. Si después de un POST esperas total 1, una consulta real puede refutarlo. «Todo bien» no permite repetir ni revisar la conclusión.

Ordena la evidencia: construcción, arranque, transporte y regla. Un JAR construido puede fallar al iniciar por configuración; un servidor que responde health puede rechazar una creación; una creación aceptada no demuestra duración entre reinicios. Esta distinción guiará el resto del curso.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Punto%20de%20entrada%20y%20entorno%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad00-ruta%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
