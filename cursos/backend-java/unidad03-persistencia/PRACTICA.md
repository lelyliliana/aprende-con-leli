# Práctica aplicada de la Unidad 03

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Completa un paso antes de seguir con el siguiente. Consulta las soluciones después de intentarlo.

## Paso 1. Relación real

Inicia JPA con el laboratorio. Consulta categorías y crea un producto usando un id recibido. Registra id, categoriaId y version de la respuesta.

## Paso 2. Dos intenciones de edición

Conserva la versión inicial. Envía una actualización a precio 15 con esa versión y guarda la nueva respuesta. Después intenta precio 99 usando la versión antigua. Consulta el recurso otra vez.

## Paso 3. Revisar el dato posterior

Compara id, SKU, categoría, precio y versión con la actualización válida. El rechazo debe conservarlos. Explica qué protege la comparación de versión y qué añade @Version.

## Paso 4. Repetir con reinicio real

Después de construir JPA, desde Aprende con Leli:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso persistencia
```

El programa usa una carpeta temporal y dos procesos sucesivos. Predice si seguirá el recurso antes de leer la salida. Después contrasta con el experimento REST, donde el mapa desaparece.

## Paso 5. Diseñar la carrera de unicidad

Describe dos POST concurrentes con el mismo SKU y qué consulta harías después. Señala la diferencia entre diseñar ese caso y haberlo ejecutado en PostgreSQL.

Entrega la secuencia de versiones y la comparación antes/después del reinicio, indicando motor y modo de almacenamiento.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Persistencia%20y%20concurrencia%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad03-persistencia%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
