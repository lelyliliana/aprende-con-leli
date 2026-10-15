# Práctica aplicada de la Unidad 02

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Completa un paso antes de seguir con el siguiente. Consulta las soluciones después de intentarlo.

## Paso 1. Escribir un contrato mínimo

Define POST con sku, nombre y precio; respuesta con id; y errores 400/409. Especifica precio positivo con dos decimales como máximo y SKU único. Después inicia REST con el laboratorio.

## Paso 2. Seguir la identidad asignada

Crea A y B con códigos distintos. Conserva id y Location de cada respuesta. Consulta A por la ruta recibida. No reutilices un id de otra ejecución.

## Paso 3. Provocar una actualización rechazada

Envía a la ruta de A un PUT con el SKU de B y precio 99. Consulta A después. Compara todos sus campos con la copia anterior, no solo el precio.

## Paso 4. Diferenciar errores y ausencia

Envía un POST con precio 1.001. Consulta una página fuera del contenido con filtro que sí coincida. Elimina B y comprueba 204 sin cuerpo; después consulta B y comprueba 404.

## Paso 5. Comparar con el experimento

Desde Aprende con Leli, con los JAR construidos y la copia hermana indicada en la guía:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso rest
```

Entrega contrato y secuencia de A antes/después del rechazo. Finalmente reinicia REST y explica el total 0.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Contratos%20REST%2C%20validaci%C3%B3n%20y%20capas%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad02-rest%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
