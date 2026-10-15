# Seguir una petición y controlar el tiempo sin cambiar HTTP

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## 1. Dibuja el recorrido que realmente existe

En fundamentos, SaludoController recibe nombre y delega en SaludoService. El servicio recibe SaludoProperties y Clock, valida el nombre y crea un Saludo con mensaje y fecha. Spring ensambla las dependencias al arrancar; el record de respuesta se crea por operación.

El [servicio de referencia](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/laboratorios/fundamentos/src/main/java/com/lelyliliana/fundamentos/SaludoService.java) permite leer toda la regla. No requiere repositorios ni usuarios. Un singleton no debe guardar temporalmente el nombre del cliente en un campo mutable: solicitudes distintas compartirían ese objeto.

## 2. Recorre un dato antes de mirar anotaciones

Con prefijo Hola y nombre Leli, la salida contiene mensaje «Hola, Leli». Con el mismo prefijo y nombre Ana cambia el mensaje, pero no se cambia el reloj por haber enviado otro nombre. LocalDate se obtiene del Clock; el bean de la aplicación usa UTC. Alrededor de medianoche, la fecha UTC puede diferir del calendario de tu zona local sin ser un error.

El nombre se recorta con strip antes de construir el resultado y al medir su longitud. Con máximo 40, blanco y 41 unidades UTF-16 se rechazan. Esa medida no equivale necesariamente a cuarenta símbolos visibles. Explica la condición que ejecuta el código, sin inventar una regla gráfica distinta.

## 3. Separa datos de la operación y dependencias

Controller recibe Service; Service recibe Clock y propiedades. Saludo no necesita @Component: representa el resultado, no una dependencia de arranque. Un constructor permite entregar un Clock.fixed en una prueba y comprobar una fecha exacta sin levantar un puerto.

La prueba de contenedor responde si las piezas se conectan. La prueba unitaria del servicio responde si sus entradas controladas producen el resultado esperado. La comprobación del JAR añade configuración, arranque y HTTP real. Las tres pueden fallar por razones distintas.

## 4. Cambia configuración conservando el artefacto

Construye el JAR desde el laboratorio y arráncalo con `"--saludo.prefijo=Buen día"`. Las comillas conservan un argumento con espacios. El mensaje cambia sin modificar el Controller ni recompilar. Un máximo configurado en 0 debe impedir el arranque por validación de propiedades.

Distingue 400 por entrada inválida, 405 por método no permitido y ausencia de HTTP si no hay servidor. En esta etapa puedes enviar POST sin CSRF para observar 405; ese razonamiento no se traslada literalmente a la integrada, donde un filtro puede rechazar antes.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Primera%20API%20y%20responsabilidades%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad01-fundamentos%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
