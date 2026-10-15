# Práctica aplicada de la Unidad 05

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Completa un paso antes de seguir con el siguiente. Consulta las soluciones después de intentarlo.

## Paso 1. Predecir una matriz

Parte del POST válido con editor y token. Cambia por separado identidad, autoridad, token y cuerpo. Escribe 201, 401, 403, 403 y 400 como hipótesis, con la causa de cada respuesta.

## Paso 2. Leer las rutas protegidas

En SecurityConfig localiza catálogo, métricas y pedidos. Distingue PRODUCT_WRITE de OPS_READ. Explica por qué un GET de pedido no hereda automáticamente lectura pública.

## Paso 3. Ejecutar sin mostrar claves

Desde Aprende con Leli, con el JAR integrado construido:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso seguridad
```

El programa administra cookies/tokens y claves locales efímeras. No copies credenciales reales en tu bitácora.

## Paso 4. Demostrar validación

Compara el cuerpo con precio 0 enviado por lector y editor, ambos con token válido. Solo el segundo debe llegar a 400/VALIDATION_ERROR con precio en campos. Después consulta el catálogo para comprobar que los rechazos no añadieron recursos.

## Paso 5. Proponer una política nueva

Para tu recurso registra actor, operación, alcance, autoridad, respuesta permitida y denegada. Si requiere propiedad por persona, explica qué regla adicional necesitarías.

Entrega matriz, evidencia de validación y política propia.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Identidad%2C%20permisos%20y%20CSRF%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad05-seguridad%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
