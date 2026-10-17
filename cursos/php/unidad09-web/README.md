# Unidad 09. HTML, HTTP y páginas dinámicas

[Anterior](../unidad08-errores/README.md) · [Índice](../README.md) · [Siguiente](../unidad10-formularios/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Explicar el viaje de una petición y generar HTML con salida escapada.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

HTML describe la estructura del documento: `h1` es un título, `p` un párrafo y `a` un enlace. Los atributos aportan información como href. El navegador solicita una URL; el servidor interpreta PHP y envía un estado HTTP, cabeceras y cuerpo. GET obtiene una representación; POST envía una operación. Una nueva petición no conserva por sí sola las variables de la anterior.

Para una aplicación local usa `php -S 127.0.0.1:8000 -t proyecto/public` desde cursos/php, cuando llegues al proyecto. Abre http://127.0.0.1:8000 en el navegador y detén el servidor con Ctrl+C. No abras el archivo .php con doble clic. El servidor integrado es solo para desarrollo local; no lo uses como servidor público.

Todo texto de una persona que se inserte en contenido HTML o un atributo entre comillas debe pasar por `htmlspecialchars($texto, ENT_QUOTES | ENT_SUBSTITUTE, "UTF-8")`. Sin escape, un título que contenga etiquetas podría ejecutarse como código en el navegador (XSS). El escape depende del contexto: esta función no hace seguro insertar texto dentro de JavaScript, CSS o URLs arbitrarias. En el proyecto solo insertamos textos en HTML y construimos enlaces con IDs validados.

Las cabeceras se envían antes del cuerpo: `header` y los códigos de respuesta deben ocurrir antes de echo. Un espacio previo a <?php puede causar «headers already sent». Estos ejemplos imprimen HTML en la terminal para inspeccionar el resultado; el proyecto mostrará ese mismo principio por HTTP.

## Ejemplo 1. Una página mínima

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$titulo = 'Mi primer taller';
echo '<!doctype html><html lang="es"><meta charset="UTF-8"><title>Taller</title><h1>' . $titulo . "</h1></html>\n";
```

```sh
php unidad09-web/ejemplos/01.php
```

Salida esperada:

```text
<!doctype html><html lang="es"><meta charset="UTF-8"><title>Taller</title><h1>Mi primer taller</h1></html>
```

El servidor genera texto HTML. Aquí titulo es una constante nuestra; para datos externos usa el siguiente ejemplo.

## Ejemplo 2. Mostrar texto como texto

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$titulo = "<script>alert(1)</script>";
$seguro = htmlspecialchars($titulo, ENT_QUOTES | ENT_SUBSTITUTE, "UTF-8");
echo "<h1>$seguro</h1>\n";
```

```sh
php unidad09-web/ejemplos/02.php
```

Salida esperada:

```text
<h1>&lt;script&gt;alert(1)&lt;/script&gt;</h1>
```

Las entidades se muestran como caracteres y no como una etiqueta ejecutable.

## Comprueba tu comprensión

1. Identifica título, párrafo y enlace en una página HTML.
2. Predice qué ocurre con el texto <b>PHP</b> al escaparlo.
3. Reto: genera un párrafo con el nombre Ana & Luis escapado.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad08-errores/README.md) · [Índice](../README.md) · [Siguiente](../unidad10-formularios/README.md)
