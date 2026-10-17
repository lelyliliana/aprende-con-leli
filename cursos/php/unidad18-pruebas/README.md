# Unidad 18. Pruebas automatizadas y casos límite

[Anterior](../unidad17-api/README.md) · [Índice](../README.md) · [Siguiente](../unidad19-arquitectura/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Comprobar resultados, fallos y persistencia con evidencias reproducibles.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una prueba prepara una situación, ejecuta una operación y compara el resultado con un contrato esperado. Una prueba unitaria se concentra en una regla pequeña; una de integración comprueba colaboradores reales, como PDO y SQLite; una prueba HTTP sigue peticiones y respuestas de la aplicación. Todas aportan evidencia distinta.

No uses únicamente assert de PHP para una comprobación obligatoria: puede estar deshabilitado según la configuración. Nuestro verificador lanza RuntimeException si algo no coincide y termina con código distinto de cero. Las salidas esperadas de los ejemplos están guardadas junto al código para que puedas contrastarlas. Cambiar el resultado esperado para que pase una prueba no corrige automáticamente el programa.

Comprueba caminos negativos: título vacío, cupo cero, entrada como arreglo, ID inexistente, token incorrecto y acceso sin sesión. Usa una base temporal por prueba y nunca borres la base de estudio para reiniciar el conjunto. Evita llamadas a servicios externos para que las pruebas no dependan de Internet. Más adelante puedes aprender PHPUnit con estos mismos principios; no hace falta instalarlo para completar esta ruta.

## Ejemplo 1. Comprobar un resultado

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

function comprobar(bool $condicion, string $mensaje): void {
    if (!$condicion) { throw new RuntimeException($mensaje); }
}
function total(int $precio, int $cantidad): int { return $precio * $cantidad; }
comprobar(total(2500, 3) === 7500, "Subtotal incorrecto");
comprobar(total(2500, 0) === 0, "Caso cero incorrecto");
echo "2 comprobaciones correctas\n";
```

```sh
php unidad18-pruebas/ejemplos/01.php
```

Salida esperada:

```text
2 comprobaciones correctas
```

Los resultados esperados se escriben explícitamente e incluyen cantidad cero.

## Ejemplo 2. Probar el rechazo

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

function validar(int $cupo): void {
    if ($cupo < 1) { throw new InvalidArgumentException("Cupo inválido"); }
}
$rechazado = false;
try { validar(0); } catch (InvalidArgumentException $e) { $rechazado = true; }
if (!$rechazado) { throw new RuntimeException("Se aceptó un cupo cero"); }
echo "Rechazo comprobado\n";
```

```sh
php unidad18-pruebas/ejemplos/02.php
```

Salida esperada:

```text
Rechazo comprobado
```

La prueba falla si la función deja de rechazar el caso, incluso si no aparece ninguna excepción.

## Comprueba tu comprensión

1. Modifica una copia de total para que sume y observa el fallo.
2. Agrega una comprobación para un solo producto.
3. Reto: comprueba resultados para cantidades 0, 1 y 3 en una tabla de casos.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad17-api/README.md) · [Índice](../README.md) · [Siguiente](../unidad19-arquitectura/README.md)
