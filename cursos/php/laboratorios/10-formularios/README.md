# Laboratorio 10. Validar un formulario real sin guardar

[Lección](../../unidad10-formularios/README.md) · [Laboratorios](../README.md) · [Código](public/index.php)

## Qué construyes

Un formulario de título y cupo. Procesa un POST, llama a una función de dominio ya explicada, conserva los campos y devuelve errores asociados. No escribe archivos ni base; el resumen válido no representa un taller guardado. Esta separación permite investigar recepción y presentación antes de agregar persistencia.

Desde cursos/php:

```sh
php -S 127.0.0.1:8010 -t laboratorios/10-formularios/public
```

Abre http://127.0.0.1:8010/. Ingresa PHP inicial y 12. El resumen debe indicar datos válidos y que no se guardó información. Una nueva visita sin POST no conserva el resultado anterior: todavía no hay sesión para eso.

## Sigue la validación

El programa acepta GET y POST. Para GET prepara campos iniciales; para POST llama a validarTaller, definida en proyecto/src/validacion.php. El include se ancla a la carpeta del archivo y no depende de dónde abriste la terminal. Esa función no conoce HTML ni sesiones: solo recibe un arreglo y devuelve datos y errores.

Con título ab y cupo 0, espera dos errores y estado 422. La vista muestra los mensajes junto a los campos mediante sus claves, mantiene los textos y añade aria-invalid cuando corresponde. Observa que escribir un texto en value exige escape incluso si la operación no guardó nada.

## Eludir la ayuda del navegador

El navegador puede impedir enviar cero por el atributo min. Para comprobar el servidor tienes que enviar una petición que no dependa de esa ayuda. Desde otra terminal, con curl:

```sh
curl -i -d "titulo=PHP&cupo=0" http://127.0.0.1:8010/
curl -i -d "titulo[]=PHP&cupo[]=12" http://127.0.0.1:8010/
```

Ambas deben devolver 422. La segunda no debe causar TypeError ni imprimir Array como si fuera el título. La alternativa automatizada está en scripts/verificar_laboratorios.py. Comparar esas peticiones demuestra por qué required y min no sustituyen is_string y las reglas del dominio.

## Casos que debes recorrer

| Título | Cupo | Resultado |
|---|---|---|
| PHP | 1 | 200, datos válidos |
| 100 caracteres | 100 | 200, límites admitidos |
| 2 caracteres | 12 | 422 en título |
| PHP | 101 | 422 en cupo |
| arreglo | arreglo | 422 sin error de tipos |

Después de un error de cupo, comprueba que el título siga presente. Si utilizas un título con comillas, el atributo debe conservar un HTML válido y mostrar el texto como dato. Inspecciona la respuesta, no solo el aspecto del control.

## Entrega y siguiente paso

Agrega en una copia un campo aula opcional de hasta 40 caracteres. Define su normalización y su error, mantén las reglas independientes y demuestra una entrada válida y una inválida. La solución no debe convertir arreglos a texto ni limpiar silenciosamente un título demasiado largo.

Este laboratorio no cambia estado y por eso no guarda un token CSRF ni una cuenta. En la unidad 11, la nota de sesión sí modifica estado y exige un token antes de hacerlo. Esa distinción es parte del diseño: no reutilices el controlador de validación como si ya implementara un alta administrativa protegida.
