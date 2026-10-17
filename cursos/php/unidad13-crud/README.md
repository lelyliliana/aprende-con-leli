# Unidad 13. CRUD, búsqueda y paginación

[Anterior](../unidad12-pdo/README.md) · [Índice](../README.md) · [Siguiente](../unidad14-objetos/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Aplicar altas, cambios y bajas usando identificadores estables.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

CRUD reúne crear, leer, actualizar y eliminar. En HTTP mostramos listas y formularios con GET, y procesamos cambios con POST. En SQL identificamos una fila por su clave primaria. Un ID proporcionado por la persona debe validarse como entero positivo; si no existe, responde 404 en vez de anunciar éxito. `rowCount` no siempre significa lo mismo para todos los motores y operaciones: para comprobar existencia usa una consulta explícita.

Las listas pueden crecer. Ordena de forma determinista antes de paginar, por ejemplo ORDER BY id DESC. LIMIT y OFFSET deben tener límites y tipos controlados: enlázalos con PDO::PARAM_INT o construye solo enteros ya validados. No aceptes una cantidad de resultados ilimitada desde la URL. En el proyecto mostraremos páginas de diez talleres y un filtro con sentencia preparada.

Eliminar debe requerir una intención explícita, permiso y token CSRF. Un botón separado comunica mejor el riesgo que reutilizar el de guardar. Piensa también en la concurrencia: dos personas pueden editar la misma fila. La versión básica del proyecto es para uso local de una persona; una ampliación incluirá columna de versión y detección de conflictos.

## Ejemplo 1. Actualizar una fila

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$db = new PDO('sqlite::memory:');
$db->exec('CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT)');
$db->exec("INSERT INTO talleres VALUES (1, 'PHP')");
$stmt = $db->prepare('UPDATE talleres SET titulo = :titulo WHERE id = :id');
$stmt->execute(['titulo' => 'PHP web', 'id' => 1]);
echo $db->query('SELECT titulo FROM talleres WHERE id = 1')->fetchColumn() . "\n";
```

```sh
php unidad13-crud/ejemplos/01.php
```

Salida esperada:

```text
PHP web
```

WHERE limita el cambio a la fila identificada; un título nuevo no modifica el ID.

## Ejemplo 2. Paginar una colección conocida

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$titulos = ["PHP", "HTML", "SQL", "CSS", "Git"];
$pagina = 2;
$porPagina = 2;
$inicio = ($pagina - 1) * $porPagina;
echo implode(", ", array_slice($titulos, $inicio, $porPagina)) . "\n";
```

```sh
php unidad13-crud/ejemplos/02.php
```

Salida esperada:

```text
SQL, CSS
```

La página dos empieza en posición dos porque las posiciones parten de cero. En SQL usaremos LIMIT y OFFSET.

## Comprueba tu comprensión

1. Explica qué cambia si omites WHERE en el ejemplo de actualización.
2. Calcula el inicio de páginas 1, 2 y 3 con tamaño 10.
3. Reto: elimina solo el taller con ID 1 y verifica el número de filas.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad12-pdo/README.md) · [Índice](../README.md) · [Siguiente](../unidad14-objetos/README.md)
