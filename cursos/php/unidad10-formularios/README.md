# Unidad 10. Formularios y validación en el servidor

[Anterior](../unidad09-web/README.md) · [Índice](../README.md) · [Siguiente](../unidad11-sesiones/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Recibir datos, mostrar errores y preservar entradas válidas.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Un formulario HTML necesita `method`, campos con `name` y un botón submit. El atributo name determina la clave que llega a PHP. GET sitúa los datos en la URL; POST envía el cuerpo. `$_GET` y `$_POST` son arreglos proporcionados por PHP, pero sus valores no son confiables: pueden faltar o llegar como arreglos si alguien envía titulo[].

Primero comprueba el método con `$_SERVER["REQUEST_METHOD"]`. Después extrae, comprueba el tipo y normaliza. Valida el dominio en el servidor: un título entre 3 y 100 caracteres y un cupo entero entre 1 y 100. `required`, `min` y `max` mejoran la experiencia en el navegador, pero se pueden eludir. Acumula errores por campo y conserva los textos escapados al volver a mostrar el formulario.

Cuando una escritura se completa, responde con una redirección 303 a una página GET y llama a exit. El patrón POST/Redirect/GET reduce reenvíos accidentales al recargar. No lo confundas con una garantía contra duplicados concurrentes. En la próxima unidad agregaremos un token CSRF antes de modificar datos. Aquí practicamos la extracción con arreglos simulados, para reproducir los casos sin navegador; el formulario real está en proyecto/public/index.php.

## Ejemplo 1. Validar una entrada simulada

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$post = ["titulo" => "  PHP  ", "cupo" => "12"];
$titulo = is_string($post["titulo"] ?? null) ? trim($post["titulo"]) : "";
$cupo = is_string($post["cupo"] ?? null) ? filter_var($post["cupo"], FILTER_VALIDATE_INT) : false;
if (mb_strlen($titulo, "UTF-8") >= 3 && $cupo !== false && $cupo >= 1 && $cupo <= 100) {
    echo "$titulo: $cupo plazas\n";
}
```

```sh
php unidad10-formularios/ejemplos/01.php
```

Salida esperada:

```text
PHP: 12 plazas
```

El tipo se comprueba antes de trim o filter_var. Los límites se verifican después de convertir.

## Ejemplo 2. Una petición manipulada

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$post = ["titulo" => ["PHP"], "cupo" => "0"];
$errores = [];
if (!is_string($post["titulo"] ?? null)) { $errores[] = "Título inválido"; }
$cupo = filter_var($post["cupo"], FILTER_VALIDATE_INT);
if ($cupo === false || $cupo < 1) { $errores[] = "Cupo inválido"; }
echo implode("; ", $errores) . "\n";
```

```sh
php unidad10-formularios/ejemplos/02.php
```

Salida esperada:

```text
Título inválido; Cupo inválido
```

Una colección no sustituye a un título. Cero es un entero, pero está fuera del dominio de cupos.

## Comprueba tu comprensión

1. Prueba títulos de 2, 3, 100 y 101 caracteres.
2. Prueba cupos ausente, cero, 1, 100, 101 y un arreglo.
3. Reto: valida un correo enviado como cadena sin llamar a filter_var sobre un arreglo.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad09-web/README.md) · [Índice](../README.md) · [Siguiente](../unidad11-sesiones/README.md)
