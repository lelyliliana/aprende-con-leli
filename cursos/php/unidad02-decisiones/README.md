# Unidad 02. Condiciones y decisiones

[Anterior](../unidad01-variables/README.md) · [Índice](../README.md) · [Siguiente](../unidad03-ciclos/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Construir decisiones con límites explícitos y comparación estricta.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

`if` ejecuta un bloque cuando su condición es verdadera; `else` cubre el caso alternativo. `elseif` permite varias decisiones excluyentes. `===` compara valor y tipo; `==` admite conversiones que pueden sorprender. La asignación `=` no es una comparación. Las llaves delimitan el bloque y hacen visible qué instrucciones pertenecen a cada camino.

`&&` exige que ambas condiciones sean verdaderas; `||` acepta al menos una; `!` invierte el resultado. Para validar un rango compara cada extremo: `$edad >= 12 && $edad <= 17`; no encadenes comparaciones como en una fórmula matemática. Prueba siempre debajo, en el límite y encima.

`match` selecciona un resultado por comparación estricta y necesita cubrir los casos o tener `default`. Es útil para traducir estados conocidos, mientras que if expresa mejor rangos. No ocultes varias decisiones complejas en operadores ternarios anidados. Antes de programar escribe las reglas con palabras y verifica que no se contradigan.

## Convertir reglas en caminos comprobables

Antes de escribir if, redacta una regla con su límite: «se admite una inscripción si los inscritos son menores que la capacidad». Menor no incluye igualdad. «Se admite si la capacidad es distinta de los inscritos» fallaría cuando hay sobrecupo, porque distinto también incluye valores mayores. Dos frases parecidas pueden representar reglas diferentes; la sintaxis no decide cuál querías.

Una decisión produce caminos. Para comprobarla necesitas recorrer al menos una entrada de cada camino y las fronteras que los separan. Si capacidad es diez, utiliza nueve, diez y once. Si además exiges doce años, agrega once y doce años sin cambiar el número de inscritos. Cambiar una condición por vez permite saber qué regla rechazó la entrada.

### Valores verdaderos y falsos no equivalen a datos válidos

Una condición puede recibir un booleano o interpretar otro valor como booleano. En PHP, una cadena vacía y la cadena "0" se consideran falsas en ese contexto. Eso no significa que "0" sea una entrada ausente ni que cualquier cadena no vacía sea aceptable. Para validar un cupo necesitarás comprobar tipo, formato y rango, y no simplemente preguntar `if ($cupo)`.

La comparación estricta hace explícita una parte de ese contrato: `0 === false` es falso porque los tipos son diferentes. Esta distinción será esencial cuando una función devuelva cero como resultado válido y false como señal de fallo. No uses una comparación menos precisa para ahorrar unos caracteres si con eso desaparece la diferencia que necesitas conservar.

### Combinar condiciones sin cambiar su significado

Con A && B se exigen ambas reglas; con A || B basta una. Para inscripción, A puede significar edad suficiente y B cupo disponible. Escribe una tabla de cuatro filas para los valores verdadero y falso de ambas. Solo verdadero/verdadero debe admitir la inscripción. Esa tabla te permitirá detectar un || colocado por error, que admitiría tanto menores con cupo como personas sin cupo con edad suficiente.

PHP evalúa estas operaciones con cortocircuito: en A && B no necesita evaluar B si A ya es falsa. Esto permite comprobar primero que existe un dato antes de acceder a una operación que lo requiere. No utilices esta característica para esconder acciones importantes, como guardar un archivo dentro de una condición difícil de leer. Una regla se comprende mejor cuando sus efectos son visibles.

### Ordenar alternativas y evitar huecos

Una cadena if/elseif/else toma el primer camino que cumple la condición. Si preguntas primero si una nota es mayor o igual que tres y después si es mayor o igual que cuatro, las notas altas ya entraron al primer camino. Ordena rangos desde el más específico o diseña intervalos que no se superpongan. El else final debe tener un significado que puedas explicar, no ser el recipiente de todos los casos que olvidaste.

match devuelve un valor asociado a coincidencias estrictas. No es la mejor opción para representar un intervalo amplio mediante decenas de valores. Para estados conocidos es legible: abierto, cerrado y desconocido. Una rama default evita un fallo por un valor inesperado, pero no convierte ese estado en uno permitido; el mensaje debe comunicar que no se reconoce.

### Decisiones pequeñas con nombres que expliquen

Guardar una condición como `$hayCupo = $inscritos < $capacidad` permite leer después `$edadPermitida && $hayCupo`. Esa separación ayuda si cada regla se usa en varios lugares o merece un mensaje propio. Tampoco hace falta nombrar cada comparación trivial. El criterio es si una persona puede reconstruir la regla sin adivinar qué representa cada número.

Cuando algo sale mal, escribe la entrada completa y el camino esperado antes de tocar los operadores. Un caso que debería rechazarse puede revelar una regla ausente en vez de una sintaxis equivocada. Las pruebas de frontera hacen visible esa diferencia.

## Ejemplo 1. Cupo disponible

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$inscritos = 10;
$capacidad = 10;
if ($inscritos < $capacidad) {
    echo "Hay cupo\n";
} else {
    echo "Taller completo\n";
}
```

```sh
php unidad02-decisiones/ejemplos/01.php
```

Salida esperada:

```text
Taller completo
```

Diez no es menor que diez. El límite pertenece al caso completo.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | inscritos y capacidad valen 10. |
| 2 | La condición 10 < 10 resulta falsa. |
| 3 | Solo el bloque else imprime Taller completo. |

## Ejemplo 2. Comparar estados

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$estado = "abierto";
$mensaje = match ($estado) {
    "abierto" => "Puedes inscribirte",
    "cerrado" => "Inscripción cerrada",
    default => "Estado desconocido",
};
echo $mensaje . "\n";
echo (5 === "5" ? "Iguales" : "Tipos distintos") . "\n";
```

```sh
php unidad02-decisiones/ejemplos/02.php
```

Salida esperada:

```text
Puedes inscribirte
Tipos distintos
```

match elige el texto por estado. El entero y la cadena no son estrictamente iguales.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | estado coincide estrictamente con abierto. |
| 2 | match devuelve el mensaje de esa rama. |
| 3 | 5 === "5" es falso y el ternario elige Tipos distintos. |

## Ejemplo 3. Construir una tabla de decisión

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

$edad = 11; $inscritos = 9; $capacidad = 10;
echo "11 años, 9 inscritos: " . ($edad >= 12 && $inscritos < $capacidad ? "admitir" : "rechazar") . "\n";
$edad = 12;
echo "12 años, 9 inscritos: " . ($edad >= 12 && $inscritos < $capacidad ? "admitir" : "rechazar") . "\n";
$inscritos = 10;
echo "12 años, 10 inscritos: " . ($edad >= 12 && $inscritos < $capacidad ? "admitir" : "rechazar") . "\n";
$inscritos = 11;
echo "12 años, 11 inscritos: " . ($edad >= 12 && $inscritos < $capacidad ? "admitir" : "rechazar") . "\n";
```

Ejecuta desde cursos/php:

```sh
php unidad02-decisiones/ejemplos/03.php
```

Resultado que debes obtener:

```text
11 años, 9 inscritos: rechazar
12 años, 9 inscritos: admitir
12 años, 10 inscritos: rechazar
12 años, 11 inscritos: rechazar
```

### Lectura guiada y experimentos

Cada bloque usa los datos actuales y calcula las dos reglas. El resultado solo admite la segunda combinación: alcanza la edad mínima y conserva una plaza disponible. Las últimas dos filas muestran por qué «distinto de capacidad» no sirve para definir disponibilidad.

Todavía repetimos el cálculo de la decisión para que puedas seguir cada cambio sin necesitar arreglos, ciclos ni funciones. Las unidades siguientes permitirán eliminar esa repetición. Como experimento cambia && por || y anota exactamente qué casos dejan de respetar el contrato antes de restaurarlo.

## Comprueba tu comprensión

1. Prueba 9, 10 y 11 inscritos para capacidad 10.
2. Explica por qué el último caso también debe rechazarse.
3. Reto: permite inscripción solo si quedan plazas y la edad es al menos 12.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad01-variables/README.md) · [Índice](../README.md) · [Siguiente](../unidad03-ciclos/README.md)
