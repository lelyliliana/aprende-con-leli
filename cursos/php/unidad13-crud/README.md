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

## Diseñar cada operación como un pequeño contrato

Crear recibe título y cupo; leer devuelve una fila o una lista; editar necesita identidad y nuevos datos; eliminar necesita identidad e intención explícita. Esta descripción ayuda a no mezclar «mostrar un formulario» con «realizar una escritura». Una petición GET puede preparar una edición y un POST aplicar el cambio. Usar la misma palabra editar para ambos momentos sin distinguirlos dificulta seguir el flujo.

Antes de cada escritura establece condiciones: método permitido, token, identidad cuando corresponda, datos del dominio y existencia del recurso. El orden importa. No ejecutes UPDATE y después compruebes si había permiso. Un rechazo debe dejar la información igual que antes. Las pruebas comparan el estado previo y posterior, además del código HTTP, para demostrarlo.

### IDs y recursos inexistentes

Valida el ID como un entero positivo y consulta la fila. Un ID mal formado es distinto de uno válido que no existe: puedes responder 400 al primero y 404 al segundo. No conviertas una cadena no numérica a cero y después informes únicamente «no encontrado», porque escondes un problema de representación. Tampoco asumas que todos los IDs entre uno y el mayor existen: puede haber borrados.

Si recibes un ID correcto pero otra persona ya eliminó la fila, el formulario antiguo no prueba que siga existiendo. Comprueba en el momento de procesar. En una aplicación concurrente también puede ocurrir un cambio entre comprobación y escritura; el proyecto local reconoce ese límite. Una versión más exigente usaría una operación atómica con control de versión o una transacción adecuada para su motor.

### Páginas que conservan su consulta

La búsqueda y la página forman una sola vista de lista. Al ir a Siguiente, conserva q y modifica page. Al iniciar otra búsqueda vuelve normalmente a la primera página, para no mostrar una página alta vacía del filtro anterior. http_build_query codifica esos parámetros; al insertarlos en un atributo HTML, escapa también el resultado para ese contexto.

Define el orden antes de paginar. Si dos filas comparten el valor de orden, agrega un segundo criterio estable, por ejemplo ID. La paginación con OFFSET es sencilla para aprender; si las filas cambian entre peticiones, las páginas pueden desplazarse. Una alternativa posterior es paginar desde el último ID visto, pero tiene otro contrato y no debe introducirse como si fuera el mismo algoritmo con un nombre distinto.

### Búsqueda literal y expectativas de la persona

Una búsqueda puede tratar % y _ como caracteres o como comodines según el SQL elegido. No uses LIKE sin explicar esa decisión. El repositorio del curso emplea instr para una subcadena literal, de modo que buscar % busca ese signo. lower de SQLite básico facilita comparación ASCII, pero no garantiza equivalencia de todas las letras acentuadas. Los límites de la búsqueda deben verse también en la guía del proyecto.

Limita longitud del filtro y cantidad de resultados. Las sentencias preparadas protegen la separación de valores y SQL, pero no eliminan todo costo de una consulta. Un filtro enorme o una página sin límites puede seguir siendo una mala entrada. Diseño del contrato, parámetros y límites trabajan juntos para sostener un comportamiento previsible.

### Eliminar con contexto y revisar la persistencia

Una confirmación útil dice qué taller desaparecerá y permite cancelar antes del POST. La aplicación debe volver a comprobar token e ID cuando se confirma; una pantalla de confirmación no autoriza por sí sola una petición manipulada. Tras eliminar, una lista vacía merece un mensaje, no una tabla rota ni un total negativo.

El [laboratorio CRUD](../laboratorios/13-crud/README.md) trabaja con una colección aislada de sesión para ensayar esas transiciones sin introducir todavía el login del proyecto. Es local y no maneja cuentas ni datos personales. Después compararás su controlador pequeño con el proyecto completo y podrás señalar qué añade la autenticación, en vez de confundirla con la persistencia o el token.

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La tabla empieza con ID 1 y título PHP. |
| 2 | UPDATE recibe título nuevo e ID como valores. |
| 3 | La consulta posterior demuestra PHP web en la misma fila. |

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La página dos con tamaño dos comienza en índice dos. |
| 2 | array_slice conserva dos elementos desde esa posición. |
| 3 | SQL y CSS corresponden a las posiciones 2 y 3 del conjunto. |

## Ejemplo 3. Comprobar existencia antes de una edición

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

$db = new PDO("sqlite::memory:", null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$db->exec("CREATE TABLE talleres (id INTEGER PRIMARY KEY, titulo TEXT NOT NULL)");
$db->exec("INSERT INTO talleres VALUES (1, 'PHP')");
function editarTitulo(PDO $db, int $id, string $titulo): bool {
    $buscar = $db->prepare("SELECT id FROM talleres WHERE id = :id");
    $buscar->execute(["id" => $id]);
    if ($buscar->fetchColumn() === false) { return false; }
    $actualizar = $db->prepare("UPDATE talleres SET titulo = :titulo WHERE id = :id");
    $actualizar->execute(["titulo" => $titulo, "id" => $id]);
    return true;
}
echo editarTitulo($db, 1, "PHP web") ? "Editado\n" : "No encontrado\n";
echo editarTitulo($db, 99, "Otro") ? "Editado\n" : "No encontrado\n";
echo $db->query("SELECT titulo FROM talleres WHERE id = 1")->fetchColumn() . "\n";
```

Ejecuta desde cursos/php:

```sh
php unidad13-crud/ejemplos/03.php
```

Resultado que debes obtener:

```text
Editado
No encontrado
PHP web
```

### Lectura guiada y experimentos

La consulta de existencia devuelve false si no encuentra ID; un ID existente permite preparar el cambio. El retorno booleano comunica al llamador qué ocurrió. El controlador HTTP podría traducir false a 404, pero la función SQL no necesita saber de HTML.

La segunda llamada no crea un taller de manera implícita ni modifica la fila 1. Comprueba además el conteo final: debe seguir en uno. Este ejemplo muestra el flujo en una conexión aislada; no promete resolver una carrera concurrente entre la consulta y la actualización. Al discutir esa ampliación, debes definir qué comportamiento quieres si otra edición llega en medio.

## Comprueba tu comprensión

1. Explica qué cambia si omites WHERE en el ejemplo de actualización.
2. Calcula el inicio de páginas 1, 2 y 3 con tamaño 10.
3. Reto: elimina solo el taller con ID 1 y verifica el número de filas.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad12-pdo/README.md) · [Índice](../README.md) · [Siguiente](../unidad14-objetos/README.md)
