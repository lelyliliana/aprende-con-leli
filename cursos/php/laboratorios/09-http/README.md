# Laboratorio 09. Una petición, una respuesta

[Lección](../../unidad09-web/README.md) · [Laboratorios](../README.md) · [Código](public/index.php)

## Objetivo y preparación

Observa cómo una consulta de URL se convierte en texto HTML. Requiere la unidad 9, PHP con mbstring y un navegador. Aquí no hay formulario, sesión ni base: una petición se puede explicar sin estudiar todavía esas herramientas.

Desde cursos/php:

```sh
php -S 127.0.0.1:8009 -t laboratorios/09-http/public
```

Abre http://127.0.0.1:8009/. Debes leer Hola, estudiante. La URL http://127.0.0.1:8009/?nombre=Leli cambia solo el dato enviado; no cambia el archivo PHP. Detén el servidor con Ctrl+C al terminar.

## Recorrido del código

1. Comprueba el método antes de generar el documento. Si no es GET, devuelve Allow y 405 y termina.
2. Lee nombre o utiliza estudiante. Rechaza un arreglo y textos demasiado largos antes de llamar a htmlspecialchars.
3. Declara el tipo HTML y prepara el texto escapado.
4. Inserta ese texto dentro del h1 fijo. El código PHP no se envía al navegador.

## Experimento guiado

Abre Red en las herramientas de desarrollo. Recarga la página y selecciona la petición principal. Anota método, URL, estado y Content-Type. Después compara el código fuente recibido con el archivo PHP de la carpeta: uno contiene el saludo generado y el otro las instrucciones para producirlo.

Visita http://127.0.0.1:8009/?nombre=%3Cb%3EPHP%3C%2Fb%3E. Debes ver las marcas <b> como texto. En el cuerpo HTML aparecen &lt;b&gt;. Este resultado demuestra la diferencia entre documento recibido y representación visible. No se prueba quitando el escape en una aplicación pública; el laboratorio permite estudiar el contrato de salida con datos ficticios.

Si tienes curl, prueba el rechazo de método desde otra terminal:

```sh
curl -i -X POST http://127.0.0.1:8009/
```

En Windows usa curl.exe si curl es un alias de otro comando. Debe aparecer 405 y Allow: GET. La alternativa sin curl es ejecutar el verificador de laboratorios y leer su caso de método. Python 3 solo se usa para automatizar; no es un requisito para escribir PHP.

## Taller y evidencia

Envía nombre[] como parámetro y espera 400; una lista no puede usarse como texto del saludo. Agrega una consulta aula con su propia validación y presenta un segundo párrafo. Define primero qué ocurrirá si falta el aula y cómo se rechaza un arreglo.

Entrega una tabla de cuatro peticiones: sin nombre, con nombre, con etiquetas y con tipo inválido. Incluye estado, fragmento del cuerpo y explicación. La prueba está completa cuando puedes ubicar en el código qué parte decide el 400 y qué parte transforma un valor válido para HTML. No atribuyas al navegador la validación que ejecutó PHP.
