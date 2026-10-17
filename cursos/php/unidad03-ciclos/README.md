# Unidad 03. Ciclos, acumuladores y trazas

[Anterior](../unidad02-decisiones/README.md) · [Índice](../README.md) · [Siguiente](../unidad04-arreglos/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Repetir acciones con una condición de terminación comprensible.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Un ciclo evita copiar instrucciones. `for` reúne inicio, condición y actualización. El cuerpo se ejecuta mientras la condición sea verdadera; después ocurre la actualización. En `while` debes garantizar que algún estado cambie hasta terminar. Un contador cuenta elementos; un acumulador reúne valores. Inicialízalos antes del ciclo, no dentro.

Para recorrer una colección usa `foreach`: expresa la intención sin administrar posiciones manualmente. Lo estudiaremos con arreglos en la siguiente unidad. `break` sale del ciclo y `continue` pasa a la siguiente iteración. Úsalos cuando simplifiquen la explicación; una salida escondida puede dificultar el seguimiento.

Una traza es una tabla de valores después de cada vuelta. Para sumar 1, 2 y 3, el acumulador pasa por 1, 3 y 6. Prueba cero vueltas, una y varias. Si usas `<=` donde necesitabas `<`, puedes procesar un elemento de más. Evita ciclos infinitos al leer datos que no cambian.

## Repetir con un propósito y una salida

Elige el ciclo después de explicar qué se repite. Si conoces el número de sesiones, for expresa bien ese recorrido. Si necesitas seguir hasta que ya no queden tareas, while comunica una condición de estado. Ninguno es automáticamente mejor; la elección debe ayudarte a demostrar qué cambia y por qué el proceso termina. Copiar tres veces el mismo bloque sirve como punto de partida, pero no escala cuando el número se decide al ejecutar.

Un for tiene cuatro momentos: inicialización, comprobación, cuerpo y actualización. La comprobación ocurre antes de cada vuelta, incluida la primera. Por eso puede ejecutar cero veces. En una traza, no escribas solo lo que ocurre dentro: señala también qué valor hace falsa la condición final. Ese valor permite justificar que el ciclo terminó en lugar de suponer que «ya dio suficientes vueltas».

### Contar elementos no es sumar sus valores

Para notas 2, 4 y 5, un contador de notas termina en tres y un acumulador termina en once. Si deseas un promedio, necesitas ambos significados: suma dividida por cantidad. Confundirlos puede producir un resultado plausible que no responde la pregunta. Un nombre como total es insuficiente cuando hay varios totales distintos; cantidadNotas y sumaNotas son más precisos.

La inicialización depende de la operación: una suma suele comenzar en cero y un producto en uno. Colocar el acumulador dentro del cuerpo lo reinicia en cada vuelta. En ese caso puedes ver tres impresiones y creer que procesaste todo, pero el estado final solo incluye la última actualización. Comprueba la secuencia de estados, no únicamente el número de líneas que aparecieron.

### Límites inclusivos y exclusivos

Para procesar cinco posiciones desde cero, los índices son 0, 1, 2, 3 y 4: la condición es índice < 5. Para mostrar sesiones de 1 a 5, usas sesión <= 5. Ambos recorridos tienen cinco vueltas con condiciones diferentes porque comenzaron en puntos diferentes. Antes de elegir el operador, escribe los primeros dos valores y el último permitido.

También existen recorridos descendentes. Si empiezas en tres y quieres mostrar hasta uno, la condición es pendientes > 0 y la actualización resta uno. Restar dos cambia qué valores visitas; no convierte automáticamente el recorrido en incorrecto, pero sí cambia su contrato. Un while sin actualización puede ejecutar para siempre si su condición inicial es verdadera. Detén un experimento accidental con Ctrl+C y revisa qué estado debía progresar.

### Cortar y saltar son decisiones distintas

break termina el ciclo actual. continue omite el resto de esa vuelta y pasa al siguiente paso de iteración. Si filtras valores inválidos con continue en un while, asegúrate de no saltar también la actualización que lo hace avanzar. En for, la expresión de actualización se realiza al continuar, lo que hace más visible ese progreso. Evita usar estas instrucciones solo para ahorrar una condición si vuelven difícil seguir la traza.

En ciclos anidados, cada iteración exterior puede ejecutar un recorrido interior completo. Tres grupos de cuatro mesas implican doce combinaciones, no siete. Dibuja primero una cuadrícula y compara las filas con las vueltas exteriores y las columnas con las interiores. Esta representación ayuda a detectar si reiniciaste un contador en el lugar equivocado.

### Un resultado vacío también necesita una regla

Un programa que calcula un promedio no debe dividir por cero cuando no recibió notas. El ciclo puede ser correcto y aun así dejar una operación posterior sin dominio válido. Tras recorrer, comprueba el contador y decide un mensaje como «sin datos». En el proyecto, una lista vacía debe mostrar una indicación útil sin inventar un taller. Los casos de cero, una y varias vueltas son parte del contrato desde el comienzo.

## Ejemplo 1. Acumular sesiones

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$total = 0;
for ($sesion = 1; $sesion <= 3; $sesion++) {
    $total += $sesion;
    echo "Sesión $sesion: $total\n";
}
```

```sh
php unidad03-ciclos/ejemplos/01.php
```

Salida esperada:

```text
Sesión 1: 1
Sesión 2: 3
Sesión 3: 6
```

El acumulador conserva el total anterior y agrega el número de sesión.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | total empieza en cero fuera del for. |
| 2 | Las vueltas agregan 1, 2 y 3; los estados son 1, 3 y 6. |
| 3 | La condición falla cuando sesion alcanza 4. |

## Ejemplo 2. Reducir pendientes

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$pendientes = 3;
while ($pendientes > 0) {
    echo "$pendientes pendientes\n";
    $pendientes--;
}
```

```sh
php unidad03-ciclos/ejemplos/02.php
```

Salida esperada:

```text
3 pendientes
2 pendientes
1 pendientes
```

La resta garantiza la terminación. Cero ya no satisface la condición.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | pendientes comienza en 3. |
| 2 | Cada vuelta imprime el estado antes de restarle uno. |
| 3 | Cuando llega a cero ya no entra al cuerpo. |

## Ejemplo 3. Reservar materiales con una traza

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

$materiales = 12;
$entregados = 0;
for ($grupo = 1; $grupo <= 3; $grupo++) {
    $entregados += 2;
    $materiales -= 2;
    echo "Grupo $grupo: entregados=$entregados; quedan=$materiales\n";
}
echo "Grupos procesados: " . ($grupo - 1) . "\n";
```

Ejecuta desde cursos/php:

```sh
php unidad03-ciclos/ejemplos/03.php
```

Resultado que debes obtener:

```text
Grupo 1: entregados=2; quedan=10
Grupo 2: entregados=4; quedan=8
Grupo 3: entregados=6; quedan=6
Grupos procesados: 3
```

### Lectura guiada y experimentos

Los dos acumuladores cambian en sentidos opuestos: entregados aumenta y materiales disminuye. Después de la tercera vuelta, grupo se incrementa a cuatro, la condición deja de cumplirse y no se entrega nada más. La variable de control no coincide al final con el número de la última vuelta ejecutada; por eso el mensaje resta uno.

La suma de materiales y entregados permanece en doce después de cada vuelta. Esa propiedad sirve como comprobación adicional, llamada invariante. Si cambias la entrega a tres materiales por grupo, actualiza ambas operaciones y espera nueve entregados y tres restantes. Si solo modificas una, la suma revelará la inconsistencia.

## Comprueba tu comprensión

1. Suma los números del 1 al 5 y construye la traza.
2. Cambia el límite a cero y explica la salida.
3. Reto: suma solo los pares del 1 al 6.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad02-decisiones/README.md) · [Índice](../README.md) · [Siguiente](../unidad04-arreglos/README.md)
