# Unidad 04. Arreglos, registros y recorridos

[Anterior](../unidad03-ciclos/README.md) · [Índice](../README.md) · [Siguiente](../unidad05-funciones/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Modelar listas y registros usando claves coherentes.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

En PHP un array es un mapa ordenado: relaciona claves enteras o cadenas con valores. Una lista como `["PHP", "HTML"]` utiliza claves 0 y 1. Un registro como `["titulo" => "PHP", "cupo" => 12]` utiliza nombres. `count` cuenta elementos; `$lista[] = $nuevo` agrega uno. Una lista vacía es `[]`.

`foreach ($lista as $valor)` recorre valores; `foreach ($registro as $clave => $valor)` incluye las claves. Una lista de registros permite representar talleres. Comprueba la existencia antes de acceder: `??` entrega una alternativa cuando el valor no existe o es null. `array_key_exists` distingue una clave presente con null de una ausente. No supongas que borrar una posición reenumera el arreglo: `array_values` crea una lista con índices consecutivos.

Ordenar con `sort` modifica la lista y reasigna claves numéricas; `asort` conserva las asociaciones. Decide si la posición tiene significado. En el proyecto usaremos un identificador estable para editar talleres: la posición en pantalla cambia cuando ordenas y no debe convertirse en identidad.

## Elegir una estructura según la pregunta

Una lista sirve cuando el orden y la repetición tienen sentido: los temas de una clase, por ejemplo. Un registro sirve cuando cada valor tiene un papel con nombre: título, cupo y aula. Una lista de registros combina ambos niveles. No necesitas crear una variable diferente para cada taller; necesitas una estructura que permita procesar cualquier cantidad manteniendo el mismo esquema.

El array de PHP permite esos usos, pero no impone por sí mismo que todos los registros tengan las mismas claves. Si un registro usa capacidad y otro cupo, el recorrido no podrá tratarlos de forma uniforme. Escribir un ejemplo de registro válido antes de construir la colección ayuda a fijar el contrato. Los errores de estructura se investigan mirando la forma de los datos, no solamente el valor final de una suma.

### Claves y posiciones pueden dejar de coincidir

Crear `["PHP", "HTML", "SQL"]` asigna claves consecutivas desde cero. Después de `unset($temas[1])`, quedan las claves 0 y 2. count devuelve dos, pero eso no significa que exista una posición con clave 1. Un for que asuma claves consecutivas puede fallar; foreach recorre las asociaciones que realmente existen. Si necesitas una lista consecutiva nueva, utiliza array_values y reconoce que estás cambiando sus posiciones.

PHP convierte algunas claves de apariencia numérica: una cadena como "8" puede convertirse en clave entera, mientras "08" conserva otro comportamiento. Por eso un identificador de negocio no debe depender accidentalmente de las reglas de conversión de claves. En estos primeros programas usa claves nominales para registros y más adelante IDs de la base para identidad. Mantén los códigos como valores cuando conservar su representación sea importante.

### Consultar ausencia con una intención clara

isset devuelve falso si falta la clave o si su valor es null. array_key_exists comprueba la presencia de la clave incluso cuando almacena null. El operador ?? entrega una alternativa en los dos primeros casos de isset. Ninguna opción es universalmente correcta: depende de si null significa «dato pendiente conocido» o si para tu pantalla equivale a ausencia.

Imagina un registro con aula => null. Puede significar que ya existe el campo pero todavía no se asignó un salón. Un formulario de actualización parcial podría necesitar distinguirlo de un campo que la persona no envió. La interfaz del curso puede mostrar «Aula pendiente» en ambos casos; una operación de actualización podría requerir conservar la diferencia. La estructura debe responder a la necesidad de la operación.

### Transformar sin perder identidad

sort ordena valores y reasigna claves numéricas. asort ordena conservando asociaciones. Si relacionas IDs con títulos, perder claves puede hacer que un botón de edición apunte al taller equivocado. Para una lista de registros con criterios propios, usort permite una función de comparación; la estudiaremos cuando hayamos presentado funciones y callbacks. Hasta entonces, no copies comparadores sin poder explicar sus resultados.

Al asignar un arreglo a otra variable se obtiene semántica de valor: modificar una entrada escalar de la copia no cambia la original en estos ejemplos. No necesitas conocer cómo optimiza internamente la memoria para razonar así. Cuando más adelante guardemos objetos dentro, copiar el arreglo no clonará automáticamente esos objetos; ese caso tiene otra regla que se explicará con clases.

### Filtrar, transformar y agregar son operaciones diferentes

Filtrar conserva los elementos que cumplen una condición; transformar produce otro valor por cada elemento; agregar reduce varios elementos a un resumen. Obtener talleres con cupo es un filtro, obtener sus títulos es una transformación y sumar las plazas es una agregación. Primero implementa cada operación con foreach para ver el estado que mantiene. Después podrás reconocer las funciones de biblioteca equivalentes sin tratarlas como recetas que memorizas.

## Ejemplo 1. Lista de temas

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$temas = ["PHP", "HTML"];
$temas[] = "SQL";
foreach ($temas as $indice => $tema) {
    echo "$indice: $tema\n";
}
```

```sh
php unidad04-arreglos/ejemplos/01.php
```

Salida esperada:

```text
0: PHP
1: HTML
2: SQL
```

El nuevo elemento queda al final. foreach entrega la clave junto con su valor.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | Los dos temas iniciales ocupan claves 0 y 1. |
| 2 | El operador [] agrega SQL en la clave siguiente. |
| 3 | foreach entrega cada clave con su tema sin alterar la lista. |

## Ejemplo 2. Registros de talleres

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$talleres = [["titulo" => "PHP", "cupo" => 12], ["titulo" => "Web", "cupo" => 8]];
$total = 0;
foreach ($talleres as $taller) { $total += $taller["cupo"]; }
echo "Plazas: $total\n";
echo ($talleres[0]["aula"] ?? "Aula pendiente") . "\n";
```

```sh
php unidad04-arreglos/ejemplos/02.php
```

Salida esperada:

```text
Plazas: 20
Aula pendiente
```

Cada registro comparte claves. El operador ?? permite mostrar una ausencia prevista.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | Cada taller es un registro con titulo y cupo. |
| 2 | El recorrido suma 12 y 8 y conserva 20. |
| 3 | El aula del primer taller no existe y ?? entrega la alternativa. |

## Ejemplo 3. Claves ausentes y copias de arreglos

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

$temas = ["PHP", "HTML", "SQL"];
unset($temas[1]);
foreach ($temas as $clave => $tema) { echo "$clave: $tema\n"; }
$copia = array_values($temas);
$copia[0] = "Web";
echo "Original: " . $temas[0] . "\n";
echo "Copia: " . $copia[0] . "\n";
$taller = ["aula" => null];
echo array_key_exists("aula", $taller) ? "Clave presente\n" : "Clave ausente\n";
echo isset($taller["aula"]) ? "Valor asignado\n" : "Valor pendiente\n";
```

Ejecuta desde cursos/php:

```sh
php unidad04-arreglos/ejemplos/03.php
```

Resultado que debes obtener:

```text
0: PHP
2: SQL
Original: PHP
Copia: Web
Clave presente
Valor pendiente
```

### Lectura guiada y experimentos

Borrar HTML no cambia la clave de SQL. array_values produce después una lista consecutiva nueva y cambiar su primer valor no modifica el primer valor del original. Los últimos mensajes distinguen la presencia de aula de un valor todavía pendiente.

Antes de ejecutar, dibuja ambos arreglos después de cada instrucción. Luego cambia null por "Sala 2": la clave continúa presente y el último mensaje cambia a valor asignado. Borra la clave con unset y observa que ahora las dos comprobaciones son falsas. No cambies todas esas entradas al mismo tiempo si quieres identificar qué pregunta responde cada función.

## Comprueba tu comprensión

1. Agrega un taller con cupo 5 y calcula el total.
2. Recorre una lista vacía.
3. Reto: conserva solo los títulos de talleres con cupo mayor que cero.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad03-ciclos/README.md) · [Índice](../README.md) · [Siguiente](../unidad05-funciones/README.md)
