# Aislar identidad, permiso, CSRF y validación del cuerpo

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## 1. Sigue el control que puede detener la petición

En la integrada, Security se ejecuta antes de muchos caminos MVC. Un POST puede rechazarse sin deserializar el cuerpo ni entrar al servicio. Identidad, permiso y token CSRF responden preguntas diferentes: quién llama, qué operación puede ejecutar y si satisface la protección frente a peticiones inducidas desde otro sitio.

Basic y usuarios en memoria son decisiones educativas de la referencia. El cliente obtiene /api/csrf, conserva la cookie de sesión y envía el header indicado con el token. Tener una contraseña correcta no sustituye ese token; tener un token no concede PRODUCT_WRITE.

## 2. Usa una matriz que cambie una condición

Toma como caso base editor con token y cuerpo válido. Compara cada variante con esa base:

| Variante | Resultado | Qué cambia frente al caso base |
|---|---|---|
| Editor, token válido, entrada válida | 201 | Caso permitido |
| Sin identidad, token válido | 401 | Falta identidad |
| Lector, token válido | 403 | Falta autoridad de escritura |
| Editor, sin token | 403 | Falta CSRF |
| Editor, token válido, precio 0 | 400 | Entrada inválida |

No mezcles cuerpo inválido, identidad ausente y token ausente para concluir que probaste tres controles: solo observaste el primero que rechazó. El [experimento de seguridad](../docs/EXPERIMENTOS.md) compara además el mismo cuerpo inválido con lector (403) y editor (400 con campo precio).

## 3. Lee la política por recurso y operación

La lectura del catálogo es pública. Métricas requieren OPS_READ. Pedidos requieren PRODUCT_WRITE incluso en GET. Por eso un lector puede consultar productos y recibir 403 al consultar un pedido; el resultado no implica que GET sea una escritura, sino que esa ruta tiene una política diferente.

Un editor autorizado que consulta un pedido inexistente llega al caso de uso y obtiene 404. Un lector puede obtener 403 antes de conocer si existe. La expectativa correcta depende del recorrido de controles, no solo del id solicitado.

## 4. Diseña la política de tu recurso propio

Para materiales puedes definir lectura pública y escritura de editor como punto de partida educativo. Si el recurso expone información de personas, tendrás que definir propietarios y alcance de lectura. Añadir una autoridad global no implementa automáticamente propiedad por usuario.

No resuelvas un rechazo desactivando CSRF ni abriendo CORS indiscriminadamente. Primero identifica cuál de los controles de la tabla falló. En una entrega real, transporte, identidad y permisos se diseñan para el entorno y actores concretos; publicar el JAR no cambia las cuentas educativas por sí mismo.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Identidad%2C%20permisos%20y%20CSRF%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad05-seguridad%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
