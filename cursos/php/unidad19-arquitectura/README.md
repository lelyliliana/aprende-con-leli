# Unidad 19. Arquitectura sencilla y proyecto por etapas

[Anterior](../unidad18-pruebas/README.md) · [Índice](../README.md) · [Siguiente](../unidad20-despliegue/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Separar validación, persistencia y presentación sin agregar complejidad innecesaria.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una aplicación crece mejor cuando puedes señalar dónde vive cada responsabilidad. En el proyecto, src/validacion.php contiene reglas de entrada, src/TallerRepository.php contiene SQL, public/index.php recibe HTTP y genera la vista, y bin/ inicializa la base o crea una cuenta. public es la única carpeta expuesta al servidor. La base queda fuera, en var/.

El repositorio recibe una conexión PDO por constructor. Las pruebas le entregan sqlite::memory: y la aplicación una ruta local. Un controlador debe validar el método y los permisos antes de solicitar un cambio. No dejes que un formulario decida la ruta del archivo de base ni el nombre de una tabla. La configuración se lee de variables de entorno controladas por quien ejecuta la aplicación.

La separación no exige un framework ni un patrón para cada función. Empieza con un flujo que puedas describir: petición → método y ruta → sesión y permisos → validación → repositorio → respuesta. Si una regla se usa en CLI y HTTP, comparte una función y prueba su contrato. Construye el proyecto por entregas pequeñas: especificación, datos y consola, formularios, acceso y verificación.

## Separar responsabilidades siguiendo una petición real

Una división útil empieza por los motivos de cambio. La validación cambia cuando el dominio modifica sus reglas; el SQL cambia cuando se modifica el almacenamiento; la presentación cambia cuando la persona necesita otra interfaz. Si mezclas esas tres decisiones en un bloque que lee $_POST, concatena SQL y genera HTML, cada revisión obliga a comprender todo el recorrido. Separarlas no elimina la complejidad, pero permite examinarla por partes.

El controlador conoce HTTP: método, ruta, sesión, códigos y redirecciones. Una función de dominio recibe datos con un contrato explícito. El repositorio conoce cómo consultar y guardar. Una vista presenta datos y errores. El proyecto pequeño conserva controlador y plantilla en un archivo, con procesamiento primero y HTML después; no afirma implementar un framework MVC completo. Esa simplificación es deliberada y visible.

### Una frontera decide qué datos puede recibir

El controlador recibe valores externos de tipos inciertos. La validación devuelve datos normalizados o errores. El repositorio puede recibir esos datos de dominio ya preparados, pero la base conserva restricciones por si otra vía intenta romperlas. No lleves $_POST al interior del repositorio: acoplarías la persistencia a una fuente de entrada específica y harías más difícil usarla desde CLI o pruebas.

De manera similar, el repositorio no debe decidir que una ausencia es una página roja con un enlace. Puede devolver null; quien atiende la petición decide si eso corresponde a 404 HTML, un objeto de error JSON o un mensaje de consola. Este diseño permite reutilizar una operación sin copiar su SQL para cada interfaz. La reutilización es una consecuencia de contratos claros, no de ocultar todos los detalles detrás de clases genéricas.

### Servicio de aplicación cuando hay una operación compuesta

Para un alta sencilla, validar y llamar al repositorio puede bastar. Si una operación coordina varias tablas, notificaciones o reglas entre entidades, un servicio puede nombrar esa intención y mantener sus pasos juntos. No agregues una capa vacía que solo repita cada método del repositorio si no expresa una decisión o una frontera útil. La arquitectura debe ayudarte a explicar el problema actual.

Una transacción pertenece al conjunto que necesita atomicidad. Si un servicio realiza dos escrituras que deben confirmarse juntas, colocar una transacción independiente dentro de cada método del repositorio no garantiza que las dos formen una operación única. Diseña quién controla inicio, confirmación y reversión, y prueba el fallo del segundo paso. Más archivos no corrigen una frontera transaccional equivocada.

### Configuración y arranque sin sorpresas

El punto de entrada carga código y obtiene configuración una vez para preparar los colaboradores. Los archivos de clase y las funciones no deberían crear una cuenta al incluirse ni borrar datos para «asegurar un entorno limpio». Esas acciones pertenecen a comandos explícitos de administración o a preparación aislada de pruebas. Bootstrap no es un lugar para esconder cambios irreversibles.

En el proyecto, conectar lee APP_DB y prepara PDO. El inicializador crea tablas mediante un comando separado; la creación de cuenta se ejecuta por CLI. Esa diferencia permite abrir una página sin que se reinstale el esquema o se cree un usuario cada vez. Al investigar una aplicación ajena, localiza primero qué archivos se ejecutan al entrar y cuáles solo definen operaciones disponibles.

### Cambiar una característica con un mapa de impacto

Para añadir categoría a un taller, el mapa incluye esquema, normalización, formulario, repositorio, respuesta API y pruebas. No todos cambian del mismo modo. El contrato de una fila debe incorporar categoria_id o un objeto de categoría según la representación elegida, y los datos existentes necesitan una migración o un valor definido. Modificar solo el HTML dejaría el resto de la aplicación con una promesa incompleta.

En la práctica construirás ese mapa antes de escribir la ampliación. Señala también qué partes no necesitan cambios: la generación aleatoria del token CSRF, por ejemplo, no depende del nombre de la categoría. Si una característica de contenido te obliga a rehacer toda la sesión, revisa dónde acoplaste responsabilidades que deberían ser independientes.

## Ejemplo 1. Una regla independiente de HTTP

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

function erroresTitulo(mixed $titulo): array {
    if (!is_string($titulo) || mb_strlen(trim($titulo), "UTF-8") < 3) {
        return ["titulo" => "Usa al menos 3 caracteres"];
    }
    return [];
}
echo count(erroresTitulo("PHP")) . " errores\n";
echo count(erroresTitulo([])) . " error\n";
```

```sh
php unidad19-arquitectura/ejemplos/01.php
```

Salida esperada:

```text
0 errores
1 error
```

La función recibe datos y devuelve errores. No conoce $_POST, sesiones ni una página concreta.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La regla recibe un valor sin depender de una petición. |
| 2 | PHP es una cadena con longitud mínima y no genera error. |
| 3 | Un arreglo incumple el tipo y devuelve un error con clave titulo. |

## Ejemplo 2. Inyectar una dependencia

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

final class Resumen {
    public function __construct(private PDO $db) {}
    public function talleres(): int { return (int) $this->db->query("SELECT COUNT(*) FROM talleres")->fetchColumn(); }
}
$db = new PDO("sqlite::memory:");
$db->exec("CREATE TABLE talleres (id INTEGER PRIMARY KEY)");
echo (new Resumen($db))->talleres() . " talleres\n";
```

```sh
php unidad19-arquitectura/ejemplos/02.php
```

Salida esperada:

```text
0 talleres
```

La conexión se crea fuera. La prueba puede elegir memoria y la aplicación un archivo persistente.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La base vacía se prepara fuera de Resumen. |
| 2 | El constructor recibe la conexión como dependencia. |
| 3 | La consulta cuenta cero talleres y la presentación ocurre fuera del método. |

## Ejemplo 3. Coordinar una regla sin depender de HTTP

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

function prepararAlta(array $entrada, callable $guardar): array {
    $titulo = is_string($entrada["titulo"] ?? null) ? trim($entrada["titulo"]) : "";
    if (mb_strlen($titulo, "UTF-8") < 3) {
        return ["ok" => false, "error" => "Título demasiado corto"];
    }
    $id = $guardar($titulo);
    return ["ok" => true, "id" => $id];
}
$guardados = [];
$guardar = function (string $titulo) use (&$guardados): int {
    $guardados[] = $titulo;
    return count($guardados);
};
$fallo = prepararAlta(["titulo" => "ab"], $guardar);
$exito = prepararAlta(["titulo" => " PHP "], $guardar);
echo "Primer resultado: " . ($fallo["ok"] ? "éxito" : "rechazo") . "\n";
echo "Nuevo ID: " . $exito["id"] . "; guardados: " . count($guardados) . "\n";
```

Ejecuta desde cursos/php:

```sh
php unidad19-arquitectura/ejemplos/03.php
```

Resultado que debes obtener:

```text
Primer resultado: rechazo
Nuevo ID: 1; guardados: 1
```

### Lectura guiada y experimentos

El callback representa la dependencia de guardar y permite observar cuántas veces se usa. La entrada inválida retorna errores antes de invocarlo. La válida normaliza el título y llama una vez. prepararAlta no decide un estado HTTP ni imprime; un controlador distinto podría interpretar su resultado.

El ejemplo simplifica la regla al título para aislar la coordinación: no sustituye validarTaller del proyecto ni implementa su dominio completo. Como experimento haz que el callback lance RuntimeException y comprueba que no aparece un éxito inventado. Si decides capturar ese fallo en una frontera, distingue un error interno de un error de campo que la persona pueda corregir.

## Comprueba tu comprensión

1. Localiza las cuatro responsabilidades en el proyecto.
2. Explica por qué var no está dentro de public.
3. Reto: escribe una regla de título que rechace más de 100 caracteres y no dependa de HTTP.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad18-pruebas/README.md) · [Índice](../README.md) · [Siguiente](../unidad20-despliegue/README.md)
