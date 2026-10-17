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

## Del campo visible al dato recibido

El navegador envía los controles con nombre que participan en el formulario. El atributo id asocia un label y permite identificar el elemento en la página; name define la clave que PHP recibe. Un input con id pero sin name puede verse y editarse sin enviar el dato esperado. Un control disabled normalmente no se envía; un control readonly puede enviarse. No uses su estado visual como garantía de una regla del servidor.

Si una persona escribe 12 en un input type=number, el servidor sigue recibiendo una representación textual. Si manipula la petición, puede enviar cualquier otro texto o una estructura de arreglo. El primer contrato del controlador es aceptar solo los tipos previstos. Las ayudas del navegador reducen errores de uso, pero no delimitan qué peticiones puede recibir el servidor.

### GET para consultar, POST para procesar

Un formulario GET es adecuado para búsqueda porque su consulta aparece en la URL y puede guardarse o compartirse. No pongas contraseñas ni secretos en una consulta. POST coloca los datos en el cuerpo, pero no los cifra: HTTPS es lo que protege el transporte. La elección de método y la protección de la conexión responden a problemas distintos.

Antes de procesar, permite los métodos previstos y devuelve 405 para los demás. Un controlador que toma toda petición como un alta podría ejecutar cambios al abrir un enlace. Para el primer laboratorio solo validaremos y mostraremos un resumen sin persistir; las operaciones que guardan estado incorporarán token CSRF en la unidad siguiente. No reutilices una demostración sin persistencia como si fuera un formulario administrativo completo.

### Una función de validación permite ensayar sin navegador

Extrae la regla de título y cupo a una función que reciba un arreglo y devuelva datos normalizados junto con errores. Esa forma hace posible probar directamente un título ausente o un cupo como arreglo. Si la validación está mezclada con echo y redirecciones, cada ensayo exigiría reconstruir el flujo HTTP y sería más difícil aislar el fallo.

Decide una política coherente: el título se recorta en sus extremos, debe tener de 3 a 100 caracteres y el cupo debe ser un entero de 1 a 100. No recortes automáticamente un título demasiado largo si el contrato es rechazarlo; la persona debe saber que no se guardó lo que escribió. Devuelve un error por campo y deja que la vista decida dónde presentarlo.

### Conservar entrada y asociar errores

Al fallar, muestra el formulario con los valores que sí puedes representar como texto. Escapa siempre esos valores dentro del atributo value entre comillas. Si llegó un arreglo en lugar de un título, no lo conviertas mediante una impresión automática: conserva una cadena vacía y explica el tipo inválido. El resumen de errores ayuda a descubrir que algo falló; el mensaje junto al campo ayuda a corregirlo.

Usa aria-invalid y aria-describedby cuando exista un error, junto con un label real. No expreses el rechazo solo cambiando el color del borde. El foco, el teclado y el texto deben permitir entender y completar la tarea. La estructura de errores que diseñaste para la función se traduce así en una experiencia más clara, sin agregar reglas ocultas solo para la interfaz.

### Redirección y repeticiones accidentales

Después de una escritura exitosa, una respuesta 303 dirige al navegador a un GET. Al recargar ese GET no se repite el cuerpo del POST anterior. Debes terminar el procesamiento con exit para no generar además la pantalla antigua. El patrón no impide dos envíos distintos antes de la redirección ni reemplaza una restricción de unicidad para datos que no deban duplicarse.

El [laboratorio de formularios](../laboratorios/10-formularios/README.md) mantiene deliberadamente una sola responsabilidad: recibir, validar y volver a mostrar. Contrasta una petición normal con otra que eluda las restricciones del navegador. Ver un 422 y comprobar que los campos se conservan aporta más evidencia que una captura del botón Guardar sin haberlo procesado.

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | is_string permite normalizar el título con trim. |
| 2 | filter_var produce un entero y la condición comprueba su rango. |
| 3 | La impresión ocurre solo si las dos reglas admiten la entrada. |

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | El arreglo de titulo incumple el tipo esperado. |
| 2 | El cupo cero es entero pero incumple la regla mínima. |
| 3 | Se acumulan los dos mensajes en lugar de detenerse en el primero. |

## Ejemplo 3. Validación reutilizable con errores por campo

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

function revisar(array $entrada): array {
    $titulo = is_string($entrada["titulo"] ?? null) ? trim($entrada["titulo"]) : "";
    $cupoTexto = $entrada["cupo"] ?? null;
    $cupo = is_string($cupoTexto) ? filter_var($cupoTexto, FILTER_VALIDATE_INT) : false;
    $errores = [];
    if (mb_strlen($titulo, "UTF-8") < 3 || mb_strlen($titulo, "UTF-8") > 100) { $errores["titulo"] = "Longitud inválida"; }
    if ($cupo === false || $cupo < 1 || $cupo > 100) { $errores["cupo"] = "Cupo fuera de rango"; }
    return ["datos" => ["titulo" => $titulo, "cupo" => $cupo], "errores" => $errores];
}
foreach ([["titulo" => " PHP ", "cupo" => "1"], ["titulo" => "ab", "cupo" => []]] as $entrada) {
    $resultado = revisar($entrada);
    echo "Título: " . $resultado["datos"]["titulo"] . "; errores: " . count($resultado["errores"]) . "\n";
}
```

Ejecuta desde cursos/php:

```sh
php unidad10-formularios/ejemplos/03.php
```

Resultado que debes obtener:

```text
Título: PHP; errores: 0
Título: ab; errores: 2
```

### Lectura guiada y experimentos

La primera entrada normaliza los espacios y acepta el límite inferior del cupo. La segunda incumple longitud y tipo; ambos errores se conservan en vez de detenerse en el primero. Como revisar no imprime, se puede usar desde consola, un controlador o una prueba.

Prueba un título de 101 caracteres y cupo "100": debe fallar solo titulo. Después prueba un título correcto sin clave cupo: debe fallar solo cupo. Este contraste comprueba que los mensajes siguen al campo correspondiente y que no se informa un éxito parcial cuando la operación exige ambos datos válidos.

## Comprueba tu comprensión

1. Prueba títulos de 2, 3, 100 y 101 caracteres.
2. Prueba cupos ausente, cero, 1, 100, 101 y un arreglo.
3. Reto: valida un correo enviado como cadena sin llamar a filter_var sobre un arreglo.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad09-web/README.md) · [Índice](../README.md) · [Siguiente](../unidad11-sesiones/README.md)
