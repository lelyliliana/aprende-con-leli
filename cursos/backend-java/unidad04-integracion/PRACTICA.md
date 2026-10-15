# Práctica aplicada de la Unidad 04

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Completa un paso antes de seguir con el siguiente. Consulta las soluciones después de intentarlo.

## Paso 1. Predicción sin proveedor público

Completa la tabla del desarrollo sin ejecutarla. Para cada escenario escribe respuesta local, cantidad de llamadas y si debería cambiar el precio guardado.

## Paso 2. Leer la implementación

Abre ProveedorClient y ubica validación de SKU, construcción de la petición, validación del cuerpo y catches. Localiza el bucle y explica por qué 429 no utiliza el segundo intento.

## Paso 3. Ejecutar el experimento

Construye el JAR integrado. Desde Aprende con Leli ejecuta:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso proveedor
```

El programa crea su proveedor local, genera claves efímeras y utiliza dos intentos configurados. No necesitas iniciar otro servidor ni introducir contraseñas.

## Paso 4. Comparar precio y versión

Observa que la cotización válida es 75 y el catálogo conserva 10. Revisa la comprobación posterior a cada fallo. Si quisieras guardar una cotización, describe una operación explícita y qué autoridad exigiría.

## Paso 5. Resolver el reto

Contrasta «otro SKU con precio positivo» con «precio negativo». La primera condición ya basta para rechazar sin mezclar dos causas. Entrega las siete filas con respuesta, llamadas y dato conservado.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Servicios%20externos%20y%20fallos%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad04-integracion%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
