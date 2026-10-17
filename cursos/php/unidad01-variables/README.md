# Unidad 01. Variables, tipos y operaciones

[Anterior](../unidad00-entorno/README.md) · [Índice](../README.md) · [Siguiente](../unidad02-decisiones/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Representar texto, cantidades y dinero sin confundir su significado.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una variable empieza por `$`, tiene un nombre sensible a mayúsculas y guarda un valor. La asignación `=` evalúa la derecha y conserva el resultado. Los tipos iniciales son int (entero), float (aproximación decimal), string (texto), bool (verdadero o falso) y null (ausencia). `var_dump` ayuda a inspeccionarlos. Un código como "007" debe mantenerse como texto para conservar los ceros.

PHP permite cambiar el tipo de una variable, pero conviene mantener un significado estable. En los ejemplos usamos `declare(strict_types=1)` para que los parámetros tipados de funciones no acepten ciertas conversiones implícitas; no valida por sí solo formularios ni cambia todas las reglas del lenguaje. La concatenación se escribe con punto: `"Hola " . $nombre`. Las comillas dobles admiten interpolación.

`+`, `-`, `*`, `/` y `%` operan sobre números. Usa paréntesis para comunicar el orden. `/` puede producir un decimal; `intdiv(7, 2)` entrega 3. Para precios del curso guardamos centavos enteros y cantidades pequeñas. Un float no representa exactamente todos los decimales. Una constante se declara con `const` y no se reasigna. Un cálculo guardado no se actualiza al cambiar su entrada: debes volver a ejecutarlo.

## Pensar en el estado del programa

Una variable no es una fórmula que sigue cambiando sola. Al ejecutar `$total = $precio * $cantidad`, PHP consulta los valores actuales, realiza la operación y asigna el resultado. Si cambias precio después, total conserva el cálculo anterior. Para analizar un programa dibuja una tabla con una fila por instrucción y columnas para cada variable. Deja un espacio sin valor antes de su primera asignación; no inventes un cero implícito.

El nombre también comunica una unidad. precio puede significar pesos, centavos o dólares; precioCentavos elimina una ambigüedad que el tipo int no puede detectar. Dos enteros pueden representar magnitudes incompatibles. Multiplicar cupos por minutos puede ser sintácticamente válido y carecer de sentido para el problema. Escribe en palabras qué representa cada resultado antes de darle una variable.

### Texto numérico y número utilizable

El texto "12" y el entero 12 son valores de tipos diferentes. PHP permite conversiones en algunos contextos, pero depender de ellas sin entenderlas vuelve frágil el programa. Un identificador "00012" debe seguir siendo texto aunque parezca un número. Una cantidad recibida por formulario también llega como texto; más adelante la validaremos antes de utilizarla. Convertir un dato no demuestra que pertenecía al dominio que necesitabas.

`get_debug_type($valor)` devuelve el nombre de su tipo y `var_dump` muestra tipo y contenido. Usa estas herramientas al investigar, no como presentación final para una persona usuaria. echo interpreta ciertos valores como texto: false produce una salida vacía, de modo que «no apareció nada» no demuestra que la variable no exista. Para representar una decisión en una interfaz, elige explícitamente las palabras que quieres mostrar.

### Operadores que conviene distinguir desde ahora

El punto concatena texto y el signo más suma números. Escribir un punto dentro de una cadena no ejecuta una concatenación: forma parte de ese texto. La interpolación de comillas dobles sustituye variables; las comillas simples normalmente conservan su escritura literal. Una forma legible de construir mensajes complejos es separar el cálculo y luego presentar el resultado, en vez de mezclar varias operaciones en una sola línea.

Los operadores abreviados, como `+=`, actualizan a partir del valor anterior. cantidad += 2 significa tomar cantidad, sumarle dos y guardar el resultado. No significa que dos sea un valor fijo asociado para siempre al nombre. Los paréntesis aclaran la prioridad; al combinar cálculo y texto, escribe el cálculo entre paréntesis o guárdalo primero. La legibilidad evita depender de recordar una tabla completa de precedencias.

### Dinero y decisiones sobre precisión

En este curso usamos centavos enteros para que sumas y productos pequeños sean exactos dentro del rango del entero. Esa elección no resuelve automáticamente descuentos, impuestos ni cantidades enormes. Un descuento porcentual puede producir una fracción de centavo; debes definir cuándo y cómo redondear. Presentar dos decimales en pantalla no cambia el valor que había guardado la variable ni repara un cálculo previo.

Para un presupuesto de práctica, define primero precio por unidad, cantidad y pago en centavos. Calcula subtotal y cambio en pasos separados. Si el pago es menor que el subtotal, el cambio sería negativo: todavía no tomaremos la decisión, pero reconocer ese resultado prepara la siguiente unidad. Un programa puede operar correctamente y necesitar una regla adicional para responder de manera útil.

### Hacer una traza sin ejecutar

Supón que disponibles empieza en 20, reservas en 3 y libres se calcula como 17. Si reservas cambia a 5, disponibles sigue 20 y libres sigue 17. Solo una segunda asignación a libres lo lleva a 15. La traza te obliga a seguir el tiempo del programa, en lugar de leer todas las líneas como si sus relaciones se mantuvieran activas simultáneamente.

## Ejemplo 1. Conservar un resultado

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$cantidad = 3;
$precioCentavos = 2500;
$total = $cantidad * $precioCentavos;
$cantidad = 4;
echo "$total centavos; cantidad actual: $cantidad\n";
```

```sh
php unidad01-variables/ejemplos/01.php
```

Salida esperada:

```text
7500 centavos; cantidad actual: 4
```

El total se calculó con tres unidades. Cambiar cantidad después no recalcula total.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | cantidad empieza en 3 y precioCentavos en 2500. |
| 2 | total recibe el resultado 7500 antes de cambiar cantidad. |
| 3 | cantidad termina en 4; total conserva 7500. |

## Ejemplo 2. Texto y división

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$codigo = "007";
echo "Código: " . $codigo . "\n";
echo (7 / 2) . " / " . intdiv(7, 2) . "\n";
```

```sh
php unidad01-variables/ejemplos/02.php
```

Salida esperada:

```text
Código: 007
3.5 / 3
```

Las comillas conservan el identificador. La división normal y la entera tienen contratos diferentes.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | codigo conserva la cadena 007, con sus ceros. |
| 2 | 7 / 2 produce 3.5. |
| 3 | intdiv realiza división entera y produce 3. |

## Ejemplo 3. Inspeccionar tipos y actualizaciones

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

$codigo = "007";
$cantidad = 2;
$totalCentavos = 4500 * $cantidad;
$cantidad += 1;
echo get_debug_type($codigo) . ": $codigo\n";
echo "Cantidad actual: $cantidad\n";
echo "Total guardado: $totalCentavos\n";
echo 'Literal: $cantidad' . "\n";
```

Ejecuta desde cursos/php:

```sh
php unidad01-variables/ejemplos/03.php
```

Resultado que debes obtener:

```text
string: 007
Cantidad actual: 3
Total guardado: 9000
Literal: $cantidad
```

### Lectura guiada y experimentos

La primera variable guarda texto para conservar los ceros. cantidad comienza en dos y participa en el cálculo de 9000; después se incrementa a tres. El mensaje del total sigue mostrando 9000 porque no se ejecutó otro cálculo. La cadena entre comillas simples conserva el signo de dólar y el nombre sin sustituirlo.

Cambia el código a un entero 7: el tipo y su presentación cambian, y los ceros iniciales ya no existen. Después agrega una nueva asignación al total tras incrementar cantidad: el nuevo resultado debe ser 13500. Justifica por qué eso requiere una instrucción nueva y no solamente cambiar el mensaje.

## Comprueba tu comprensión

1. Calcula el costo de dos cuadernos de 4500 centavos.
2. Cambia la cantidad a cero y predice el total.
3. Reto: calcula el cambio de un pago de 10000 centavos.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad00-entorno/README.md) · [Índice](../README.md) · [Siguiente](../unidad02-decisiones/README.md)
