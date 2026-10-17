# Unidad 05. Funciones, parámetros y contratos

[Anterior](../unidad04-arreglos/README.md) · [Índice](../README.md) · [Siguiente](../unidad06-texto/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Separar cálculos reutilizables de su presentación.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una función da un nombre a una operación. Los parámetros reciben datos; `return` entrega un resultado y termina la llamada. `echo` muestra información y no reemplaza el retorno. Una función que calcula plazas puede servir en una página, una API y una prueba si devuelve un número en lugar de imprimir HTML.

Declara tipos en parámetros y retorno: `function doble(int $n): int`. El contrato también incluye reglas del dominio que el tipo no expresa, por ejemplo capacidad no negativa. Una variable creada dentro de la función tiene alcance local. Pasa los datos explícitamente en vez de depender de globales. Los parámetros se pasan por valor por defecto; no necesitas referencias para devolver un cálculo.

Un parámetro opcional debe tener un valor razonable. Evita funciones que hagan varias tareas sin relación. Para comprobar una función prepara una entrada y un resultado esperado; incluye límites y entradas inválidas cuando incorporemos excepciones. Un nombre como plazasDisponibles explica más que procesar.

## Diseñar una función antes de escribir su cuerpo

Escribe cuatro decisiones: qué recibe, qué devuelve, qué entradas admite y qué efectos produce. Para subtotal, las entradas son precioCentavos y cantidad; la salida es otro entero; el dominio inicial usa valores pequeños no negativos; no hay impresión ni escritura. Esta descripción evita que una función aparentemente reutilizable dependa de un formulario, una conexión o una variable global que nadie esperaba.

Definir una función no calcula de inmediato todos sus posibles resultados. Una llamada concreta enlaza los argumentos con sus parámetros y ejecuta el cuerpo. Si llamas subtotal(2500, 3), precioCentavos vale 2500 dentro de esa llamada y cantidad vale 3. Otra llamada puede recibir 800 y 2 sin modificar la definición. La función describe la operación, mientras cada llamada aporta el caso.

### Volver con un resultado y salir de la llamada

return entrega un valor al punto de llamada y termina ese recorrido de la función. Las instrucciones posteriores a un return incondicional no se alcanzan. Una función con retorno declarado int debe devolver un entero en sus caminos normales. Una función void expresa que no entrega un valor utilizable como resultado, aunque pueda hacer algo visible como escribir una línea.

Una función que imprime 7500 y devuelve null no puede utilizarse después como un subtotal numérico. Por eso separamos cálculo y presentación. Puedes guardar el retorno, combinarlo con otro y elegir después si lo muestras en consola, HTML o JSON. Esta separación es una herramienta de comprensión y de prueba: un resultado se compara sin tener que capturar una pantalla.

### Alcance y paso por valor

Un parámetro y una variable creada dentro son locales a la llamada. Su nombre no queda disponible automáticamente fuera. Si modificas un entero recibido por valor, no cambias la variable usada como argumento. Devuelve el nuevo valor si quieres conservarlo. PHP también admite parámetros por referencia con &, pero deben comunicar una modificación intencional; no los uses por defecto como atajo para devolver varios resultados.

Con arreglos de valores escalares, el paso por valor permite construir otra lista sin alterar la entrada. Con objetos, modificar propiedades tiene otras consecuencias que estudiaremos en su unidad. Aprende cada caso por su contrato observable y no por suposiciones como «todo se copia» o «todo se comparte». Una función clara declara cuándo transforma datos y cuándo modifica estado ajeno.

### Qué garantiza el tipo y qué debes validar

Con strict_types en el archivo que hace la llamada, un parámetro int no acepta de forma ordinaria una cadena "3" como si fuera el entero 3. El tipo no impide recibir -3 ni un valor que exceda una capacidad del dominio. Además, int se admite para un parámetro float. El modo estricto no elimina todas las conversiones del lenguaje ni valida $_POST automáticamente.

Para expresar ausencia puedes devolver ?int, equivalente a int|null. Un retorno como cero debe conservarse si es un resultado legítimo; null puede indicar «no disponible» según el contrato. Al trabajar con entradas externas, valida primero y llama a la función con datos ya normalizados. Más adelante usaremos excepciones para distinguir un fallo que impide cumplir la operación.

### Funciones pequeñas y callbacks

PHP permite pasar funciones como datos a otra operación. Una función anónima se escribe `function (...) { ... }` sin nombre; una función flecha usa `fn (...) => expresión` y devuelve esa expresión. No las necesitas para hacer cualquier recorrido, pero serán útiles en transformaciones y ordenamientos. Empieza escribiendo una función normal que puedas probar; después decide si una forma breve conserva la claridad.

Un callback no debe ocultar efectos innecesarios. Si se usa para transformar un título, recibe un título y devuelve otro, sin guardar una base ni imprimir mensajes inesperados. La cantidad de líneas no mide por sí sola la calidad: una función un poco más larga con nombres y pasos claros puede ser más fácil de mantener que una expresión comprimida.

## Ejemplo 1. Retornar un cálculo

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

function plazasDisponibles(int $capacidad, int $inscritos): int {
    return max(0, $capacidad - $inscritos);
}
echo plazasDisponibles(12, 5) . "\n";
echo plazasDisponibles(5, 8) . "\n";
```

```sh
php unidad05-funciones/ejemplos/01.php
```

Salida esperada:

```text
7
0
```

max evita presentar plazas negativas. El contrato de este ejemplo admite sobrecupo y lo representa como cero disponible.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | Cada llamada recibe una capacidad y un número de inscritos. |
| 2 | 12 menos 5 produce 7; 5 menos 8 produce -3. |
| 3 | max transforma solo el resultado negativo en cero. |

## Ejemplo 2. Valor opcional y alcance

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

function saludar(string $nombre = "estudiante"): string {
    return "Hola, $nombre";
}
echo saludar() . "\n";
echo saludar("Leli") . "\n";
```

```sh
php unidad05-funciones/ejemplos/02.php
```

Salida esperada:

```text
Hola, estudiante
Hola, Leli
```

Cada llamada recibe su propio parámetro. La primera utiliza el valor por defecto.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La definición establece estudiante como argumento por defecto. |
| 2 | La primera llamada no aporta nombre y usa ese valor. |
| 3 | La segunda llamada recibe Leli y devuelve otro saludo. |

## Ejemplo 3. Componer cálculos sin imprimir dentro

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

function subtotalCentavos(int $precio, int $cantidad): int {
    return $precio * $cantidad;
}
function totalConEnvio(int $subtotal, int $envio = 0): int {
    return $subtotal + $envio;
}
$materiales = subtotalCentavos(1250, 3);
$total = totalConEnvio($materiales, 500);
echo "Materiales: $materiales\n";
echo "Total con envío: $total\n";
```

Ejecuta desde cursos/php:

```sh
php unidad05-funciones/ejemplos/03.php
```

Resultado que debes obtener:

```text
Materiales: 3750
Total con envío: 4250
```

### Lectura guiada y experimentos

La primera llamada calcula 3750 y devuelve ese valor a materiales. La segunda recibe ese resultado como dato y agrega 500. Ninguna función conoce la terminal: solo las dos instrucciones finales presentan los valores. El parámetro opcional envío se usa como cero cuando se omite.

Prueba totalConEnvio($materiales) y espera 3750. Después cambia la cantidad a cero: materiales debe ser cero, pero un envío explícito de 500 mantiene el total en 500. Ese resultado plantea una regla de negocio: ¿se cobra envío sin materiales? El código cumple el contrato que escribimos; si el negocio quiere otra cosa, debe cambiar la regla y su prueba, no solamente el mensaje.

## Comprueba tu comprensión

1. Prueba capacidad igual a inscritos.
2. Escribe una función que devuelva el doble de un entero.
3. Reto: calcula el subtotal de un precio en centavos y una cantidad, sin imprimir dentro de la función.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad04-arreglos/README.md) · [Índice](../README.md) · [Siguiente](../unidad06-texto/README.md)
