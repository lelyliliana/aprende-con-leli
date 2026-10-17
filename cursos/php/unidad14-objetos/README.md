# Unidad 14. Objetos, interfaces y composición

[Anterior](../unidad13-crud/README.md) · [Índice](../README.md) · [Siguiente](../unidad15-composer/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Encapsular reglas y sustituir dependencias con contratos pequeños.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una clase describe datos y operaciones; un objeto es una instancia. El constructor establece el estado inicial. `private` oculta detalles y `public` expone operaciones. Una propiedad readonly puede inicializarse una vez; no significa que cualquier objeto que contenga sea profundamente inmutable. Validar en el constructor impide crear ciertos estados imposibles.

Usa objetos cuando ayuden a mantener una regla o separar una responsabilidad. Una clase Taller puede conservar título y cupo, y un repositorio puede guardar y recuperar talleres. Son tareas distintas. La composición pasa colaboradores al constructor: una clase recibe un PDO en vez de crear una conexión oculta. Así las pruebas pueden aportar una base en memoria.

Una interface define operaciones que una implementación debe ofrecer. No promete cómo se realizan. Podemos reemplazar un repositorio SQL por uno en memoria para una prueba sin cambiar el consumidor. No necesitas una jerarquía de herencia para cada entidad: empieza por funciones simples y extrae una clase cuando su contrato lo justifique.

## Un objeto debe proteger un significado

Una clase es útil cuando reúne estado y operaciones que deben respetar reglas compartidas. No mejora un programa solo por envolver cada arreglo. Un Taller puede representar un título y una capacidad válidos; un repositorio se encarga de conservarlo; una vista decide cómo mostrarlo. Si una clase hace las tres cosas, las pruebas y los cambios de interfaz terminarán dependiendo unos de otros sin necesidad.

El constructor crea una frontera: o produce una instancia válida o comunica que no pudo hacerlo. Si cupo debe ser positivo, permitir una instancia con cero para «arreglarla después» exige que todos recuerden esa tarea pendiente. Una propiedad privada y métodos con intención permiten impedir cambios que rompan la regla. La encapsulación busca reducir estados imposibles, no simplemente escribir private en todas partes.

### Visibilidad y acceso por métodos

public forma parte del contrato accesible desde otros componentes; private reserva detalles a la propia clase; protected participa en relaciones de herencia que no necesitas usar de inmediato. Un método que devuelva plazas disponibles puede ocultar cómo se guardan capacidad e inscritos. Eso permite cambiar la representación sin obligar a todas las pantallas a repetir la resta y sus límites.

La promoción de propiedades en el constructor abrevia su declaración y asignación, pero no explica por sí sola las invariantes. Escribe la validación aunque la sintaxis sea compacta. readonly restringe reasignaciones de una propiedad después de su inicialización permitida; no congela recursivamente todo objeto que contenga. Elige si necesitas una entidad mutable con operaciones o un valor que se reemplace por otro.

### Variables que apuntan al mismo objeto

Asignar un objeto a otra variable no crea automáticamente una instancia independiente. Dos variables pueden referirse al mismo objeto y observar una modificación de sus propiedades. Esto difiere de los ejemplos de arreglos escalares de la unidad 4. Un clone produce una copia superficial; objetos anidados todavía pueden requerir una estrategia explícita si necesitas independencia completa.

No confundas esa asociación con el operador de referencias & del lenguaje. Para razonar sobre el ejemplo basta dibujar una caja de objeto y dos nombres que llegan a ella. Si necesitas un nuevo Taller con otro cupo, puedes crear otra instancia con ese valor y conservar la original, en lugar de modificar una propiedad compartida sin avisar.

### Interfaces pequeñas y dependencias visibles

Una interface declara operaciones que un colaborador ofrece. El consumidor depende de ese contrato, no de una conexión concreta o de cómo se leen los datos. Evita interfaces enormes con métodos que cada implementación no necesita. Un contrato como listarTalleres puede tener una versión en memoria para una prueba y otra SQL para la aplicación si ambas respetan la misma forma de resultado.

La composición pasa esas dependencias al constructor. Es más fácil comprobar un Resumen con un repositorio pequeño que con una clase que abre una conexión secreta y lee una configuración global. No necesitas una herramienta de inyección sofisticada para aprender esa idea: crear el colaborador fuera y pasarlo explícitamente ya permite elegirlo en una prueba.

### Herencia y composición responden a relaciones diferentes

Herencia expresa una relación de sustitución que debe respetar el contrato del tipo base. No la uses solo para reutilizar cinco líneas si los conceptos no son intercambiables. Composición expresa «necesita un» o «usa un», como un servicio que usa un repositorio. Un taller no es una base de datos: recibir un repositorio tiene más sentido que heredar de PDO.

Al revisar tu diseño, pregunta qué cambio debería afectar una sola clase. Cambiar la tabla no debería obligar a reescribir la presentación del error del formulario; cambiar el mensaje no debería alterar una consulta SQL. Si todo cambio atraviesa todas las clases, probablemente la separación todavía sigue archivos en vez de responsabilidades.

## Ejemplo 1. Un objeto válido

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

final class Taller {
    public function __construct(public readonly string $titulo, public readonly int $cupo) {
        if ($cupo < 1) { throw new InvalidArgumentException("Cupo inválido"); }
    }
}
$taller = new Taller("PHP", 12);
echo "$taller->titulo: $taller->cupo plazas\n";
```

```sh
php unidad14-objetos/ejemplos/01.php
```

Salida esperada:

```text
PHP: 12 plazas
```

La promoción de propiedades declara y asigna los parámetros. La regla impide cupos menores a uno.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | El constructor recibe título y cupo y comprueba su regla. |
| 2 | La promoción inicializa las propiedades de la nueva instancia. |
| 3 | La lectura pública muestra PHP y sus 12 plazas. |

## Ejemplo 2. Programar contra una interfaz

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

interface Contador { public function total(): int; }
final class ContadorFijo implements Contador {
    public function total(): int { return 3; }
}
function resumen(Contador $contador): string { return "Talleres: " . $contador->total(); }
echo resumen(new ContadorFijo()) . "\n";
```

```sh
php unidad14-objetos/ejemplos/02.php
```

Salida esperada:

```text
Talleres: 3
```

resumen requiere el contrato Contador y puede recibir cualquier implementación que lo cumpla.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La interfaz promete total con retorno entero. |
| 2 | ContadorFijo implementa esa promesa devolviendo tres. |
| 3 | resumen utiliza el contrato, sin conocer cómo se obtuvo el número. |

## Ejemplo 3. Observar alias y copia superficial de un objeto

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

final class ContadorPlazas {
    public function __construct(public int $plazas) {}
}
$original = new ContadorPlazas(12);
$otroNombre = $original;
$otroNombre->plazas = 10;
$copia = clone $original;
$copia->plazas = 8;
echo "Original: $original->plazas\n";
echo "Otro nombre: $otroNombre->plazas\n";
echo "Copia: $copia->plazas\n";
```

Ejecuta desde cursos/php:

```sh
php unidad14-objetos/ejemplos/03.php
```

Resultado que debes obtener:

```text
Original: 10
Otro nombre: 10
Copia: 8
```

### Lectura guiada y experimentos

La asignación a otroNombre conserva la asociación al mismo objeto. Modificar plazas mediante ese nombre también se observa mediante original. clone crea después otra instancia con su propio entero; cambiarlo a ocho deja el primero en diez. La clase deliberadamente permite edición directa para aislar el mecanismo; un modelo de dominio real necesitaría proteger sus reglas.

Dibuja primero los nombres y las dos instancias. Después sustituye la propiedad pública por una privada y un método que rechace cantidades negativas. Esa ampliación cambia el contrato de modificación, no la regla de que dos nombres pueden compartir un objeto. Si añadieras un objeto anidado, clone no lo clonaría recursivamente por defecto.

## Comprueba tu comprensión

1. Intenta construir un Taller con cupo cero y captura la excepción.
2. Explica qué dependencia recibiría un repositorio SQL.
3. Reto: implementa Contador con una lista recibida por constructor.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad13-crud/README.md) · [Índice](../README.md) · [Siguiente](../unidad15-composer/README.md)
