# Laboratorio 11. Nota, sesión y redirección

[Lección](../../unidad11-sesiones/README.md) · [Laboratorios](../README.md) · [Código](public/index.php)

## Qué observarás

Una nota de hasta 120 caracteres se conserva entre peticiones del mismo navegador. El programa usa una sesión real, un token aleatorio y una redirección 303. No hay base de datos ni login. Una sesión separada mantiene su propia nota; no escribas información personal.

```sh
php -S 127.0.0.1:8011 -t laboratorios/11-sesiones/public
```

Abre http://127.0.0.1:8011/. Guarda Preparar sensores. Al llegar a la pantalla siguiente debe aparecer la nota conservada y un mensaje de una sola lectura. Al recargar, la nota continúa y el mensaje desaparece. Cerrar una pestaña no garantiza borrar la sesión: el navegador y el servidor conservan sus propios estados.

## Lee el flujo en cinco momentos

1. Configura nombre y atributos de cookie antes de session_start.
2. Obtiene o genera el token y prepara el valor inicial a partir de la sesión.
3. En POST compara el token antes de asignar la nota. Si falla responde 403 y termina.
4. Valida tipo y longitud; si falla devuelve 422 sin modificar la nota conservada.
5. Guarda nota y flash, responde 303 y termina. El GET siguiente consume el flash y presenta la nota escapada.

El flash y la nota tienen duraciones distintas aunque se guarden en el mismo arreglo de sesión. Esa diferencia la establece el código que borra uno al leerlo y conserva el otro.

## Experimentos con el navegador

En Red activa conservar registro, envía y observa POST → 303 → GET → 200. Inspecciona la presencia de Cookie y Set-Cookie sin copiar los valores a una evidencia pública. El ID no contiene la nota; permite recuperar los datos del lado servidor.

Abre otra pestaña normal: puede compartir la nota. Abre un perfil distinto o incógnito: debe comenzar sin ella. La separación demuestra que la aplicación conserva estado por sesión, no una única variable para todas las personas. Después modifica la nota desde la primera pestaña y recarga la segunda del mismo perfil para observar su continuidad compartida.

## Rechazos y estado previo

Primero guarda Nota original. Luego envía un token incorrecto desde una petición de prueba y verifica 403. Regresa mediante GET y comprueba que la nota original sigue guardada. Un error de estado sin esta segunda lectura no prueba que el programa haya respetado el orden.

Para una longitud inválida, el formulario muestra el texto enviado para corregirlo, pero la sección Nota conservada continúa con el valor anterior. El programa diferencia así la entrada fallida del estado confirmado. La prueba automatizada recorre también una nota con etiquetas y comprueba que se presenta escapada.

## Taller

Añade un contador que aumente solo al guardar una nota válida. Un GET no debe incrementarlo; un token incorrecto tampoco; una nota vacía tampoco. Define los resultados esperados antes de tocar el código. Esta ampliación obliga a situar la modificación dentro del mismo camino de éxito.

Entrega la secuencia de cuatro peticiones, la tabla de contador esperado y la explicación del flash. El siguiente laboratorio CRUD utiliza las mismas reglas de sesión para guardar una colección con IDs estables; después el proyecto moverá la persistencia a SQLite e incorporará identidad administrativa.
