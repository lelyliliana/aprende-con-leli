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

## Comprueba tu comprensión

1. Intenta construir un Taller con cupo cero y captura la excepción.
2. Explica qué dependencia recibiría un repositorio SQL.
3. Reto: implementa Contador con una lista recibida por constructor.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad13-crud/README.md) · [Índice](../README.md) · [Siguiente](../unidad15-composer/README.md)
