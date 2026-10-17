# Unidad 06. Texto, fechas y validación

[Anterior](../unidad05-funciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad07-archivos/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Normalizar entradas sin confundir validación, conversión y escape.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

`trim` retira espacios de los extremos; no elimina los interiores. `strlen` cuenta bytes y `mb_strlen` cuenta caracteres según una codificación: para texto UTF-8 no siempre coinciden. El curso requiere mbstring para manejar títulos. `str_contains` busca una subcadena y distingue mayúsculas. Nunca uses una transformación como sustituto de definir qué datos aceptas.

Una entrada HTTP puede ser una cadena, un arreglo o estar ausente. Primero comprueba `is_string`. Valida un entero con `filter_var(..., FILTER_VALIDATE_INT)` y compara con `=== false`: cero es un entero válido. Convertir directamente `"abc"` con `(int)` puede ocultar el error. La validación decide si el dato sirve; el escape HTML protege el contexto donde lo muestras. Son operaciones distintas.

`DateTimeImmutable` permite operar con fechas sin cambiar el objeto original. Indica la zona horaria para que el resultado no dependa del equipo. Para una fecha con formato estricto comprueba también errores y que el formato de salida coincida, porque algunas entradas se normalizan. Los identificadores y claves deben validarse por su contrato, no por su apariencia numérica.

## Una entrada atraviesa varias fronteras

El dato que llega del exterior tiene una representación, un tipo y un significado todavía por comprobar. Un cupo puede llegar como "12", " 12 ", una cadena vacía o un arreglo. El objetivo no es aplicar varias funciones hasta obtener algún número: es decidir qué representaciones acepta el contrato y rechazar las demás con un mensaje comprensible. Escribe primero ejemplos admitidos y rechazados.

Normalizar hace equivalentes representaciones que elegiste tratar igual, por ejemplo quitar espacios exteriores a un título. Validar decide si el valor normalizado cumple las reglas. Convertir produce el tipo que usará el dominio. Escapar prepara ese dato para un contexto de presentación. Si mezclas las cuatro etapas en una expresión difícil de leer, será complicado explicar qué dato se guardó y por qué.

### UTF-8 y longitud no son un único concepto

Una cadena de PHP almacena bytes. strlen mide esos bytes; mb_strlen con UTF-8 mide caracteres según esa codificación. Una letra acentuada puede ocupar más de un byte, y algunas formas visuales combinan varios puntos de código. Para los títulos del curso definimos un límite con mb_strlen y aclaramos la codificación; no pretendemos contar perfectamente todos los símbolos visuales complejos de cualquier escritura.

Si recibes texto de una fuente externa, su codificación debe formar parte del contrato. No recortes bytes a la mitad de un carácter para cumplir un límite visual. La transformación de mayúsculas también depende de la herramienta: strtolower no equivale a mb_strtolower para todo Unicode. En el proyecto declaramos una limitación de búsqueda ASCII precisamente para no prometer una equivalencia que SQLite básico no ofrece.

### Enteros y formatos admitidos

FILTER_VALIDATE_INT devuelve un entero o false. La comprobación posterior decide rango: validar que algo sea entero no decide si representa un cupo de 1 a 100. Algunas representaciones pueden no pasar el filtro, aunque una persona las considere numéricas. Por ejemplo, un cero inicial requiere una decisión de formato; si quieres admitir códigos con ceros, probablemente estás trabajando con texto identificador y no con una cantidad.

No uses empty como única validación si cero tiene significado: considera vacía la cadena "0". Tampoco elimines todos los caracteres que no sean dígitos y aceptes el resto sin avisar; "12abc" se convertiría silenciosamente en otra entrada. Una corrección razonable de espacios es distinta de inventar un dato que la persona no envió. El mensaje debe ayudar a corregir, no ocultar el rechazo.

### Fechas: forma, calendario y zona horaria

Una fecha como 2026-02-30 tiene forma parecida a una fecha válida y un día inexistente. DateTimeImmutable puede normalizar ciertos valores, por lo que aceptar el objeto creado no basta para un contrato estricto. Usa createFromFormat con un formato definido, comprueba advertencias y errores, y compara la salida formateada con el texto original. El modificador ! ayuda a fijar campos no incluidos en el formato en vez de heredar la hora actual.

La zona horaria responde dónde se interpreta una hora civil. Un registro de «09:00» sin zona puede ser ambiguo cuando viaja a otro país. Para fechas de práctica sin hora, establece igualmente una zona explícita para reproducir resultados. DateTimeImmutable devuelve otro objeto al modificar; guardar el resultado es necesario si quieres conservar la nueva fecha. No atribuyas al objeto original un cambio que no recibió.

### Validación por campo y mensajes concretos

Una lista de errores con claves titulo y cupo permite mostrar la explicación junto al campo correspondiente. «Entrada incorrecta» es menos útil que «Escribe un entero entre 1 y 100». Conserva lo que la persona escribió cuando sea seguro presentarlo escapado, en vez de borrar todo el formulario. Esa experiencia depende de una estructura de resultados bien diseñada desde la función de validación, antes de escribir la pantalla.

## Ejemplo 1. Normalizar un título

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$titulo = trim("  Taller PHP  ");
echo "$titulo\n";
echo mb_strlen("Programación", "UTF-8") . " caracteres\n";
```

```sh
php unidad06-texto/ejemplos/01.php
```

Salida esperada:

```text
Taller PHP
12 caracteres
```

trim conserva los espacios interiores. mb_strlen cuenta la ó como un carácter.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | trim retira los espacios de los extremos. |
| 2 | El título conserva el espacio entre Taller y PHP. |
| 3 | mb_strlen interpreta UTF-8 y cuenta 12 caracteres en Programación. |

## Ejemplo 2. Cero y fecha explícita

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$cantidad = filter_var("0", FILTER_VALIDATE_INT);
echo ($cantidad === false ? "Inválido" : "Entero: $cantidad") . "\n";
$fecha = new DateTimeImmutable("2026-10-17", new DateTimeZone("America/Bogota"));
echo $fecha->modify("+7 days")->format("Y-m-d") . "\n";
```

```sh
php unidad06-texto/ejemplos/02.php
```

Salida esperada:

```text
Entero: 0
2026-10-24
```

La comparación estricta no confunde cero con false. modify crea otra fecha.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | filter_var devuelve el entero cero, no false. |
| 2 | La comparación estricta conserva cero como válido. |
| 3 | modify devuelve otra fecha y format presenta 2026-10-24. |

## Ejemplo 3. Validar una fecha de calendario estricta

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

function fechaValida(string $texto): bool {
    $fecha = DateTimeImmutable::createFromFormat("!Y-m-d", $texto, new DateTimeZone("America/Bogota"));
    $estado = DateTimeImmutable::getLastErrors();
    if ($fecha === false) { return false; }
    if ($estado !== false && ($estado["warning_count"] > 0 || $estado["error_count"] > 0)) { return false; }
    return $fecha->format("Y-m-d") === $texto;
}
foreach (["2026-02-28", "2026-02-30", "2026-2-3"] as $texto) {
    echo $texto . ": " . (fechaValida($texto) ? "válida" : "inválida") . "\n";
}
```

Ejecuta desde cursos/php:

```sh
php unidad06-texto/ejemplos/03.php
```

Resultado que debes obtener:

```text
2026-02-28: válida
2026-02-30: inválida
2026-2-3: inválida
```

### Lectura guiada y experimentos

La primera comprobación distingue un fallo de creación. getLastErrors puede devolver false cuando no hay errores; por eso no se accede siempre a sus claves. Una fecha normalizada con advertencias también se rechaza. Finalmente la comparación de ida y vuelta exige exactamente cuatro dígitos de año y dos por mes y día.

Prueba 2024-02-29 y 2025-02-29: solo la primera debe ser válida por el año bisiesto. Después conserva una fecha original y el resultado de modify en dos variables; muestra ambas para comprobar la inmutabilidad. Esta función valida calendario y formato, pero aún no decide si la fecha de un taller puede estar en el pasado: esa es otra regla del dominio.

## Comprueba tu comprensión

1. Prueba una cadena vacía y otra con espacios.
2. Contrasta filter_var con "0", "5" y "abc".
3. Reto: acepta una cantidad entre 0 y 20 y explica por qué no basta convertir a int.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad05-funciones/README.md) · [Índice](../README.md) · [Siguiente](../unidad07-archivos/README.md)
