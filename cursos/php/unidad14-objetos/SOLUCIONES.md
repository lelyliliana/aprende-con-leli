# Soluciones 14. Objetos, interfaces y composición

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

new Taller("PHP", 0) lanza InvalidArgumentException antes de devolver un objeto válido. El repositorio SQL recibe PDO en su constructor: así no crea una conexión oculta ni obliga a la prueba a usar una base en disco.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

interface Contador { public function total(): int; }
final class ContadorLista implements Contador {
    public function __construct(private array $elementos) {}
    public function total(): int { return count($this->elementos); }
}
echo (new ContadorLista(["PHP", "Web"]))->total() . "\n";
```

Desde cursos/php:

```sh
php unidad14-objetos/soluciones/reto.php
```

El resultado es 2 y con una lista vacía es 0. El constructor recibe los datos en lugar de depender de una variable global.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.

## Solución razonada del taller de profundización

El constructor debe comprobar tipo y dominio en la frontera apropiada: con parámetros tipados ya normalizados, revisa trim y longitud del título y rango del cupo. Un objeto inválido debe lanzar una excepción antes de quedar disponible. readonly puede ayudar a conservar un valor válido, pero no reemplaza esa validación.

Las dos variables del ejemplo comparten una instancia hasta que se clona. La interfaz de conteo declara total(): int; la implementación fija devuelve una cantidad conocida y la de memoria count de su colección. El servicio utiliza una base, no es una base: composición hace visible esa relación y permite cambiar la dependencia sin atribuirle todas las capacidades de PDO.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
