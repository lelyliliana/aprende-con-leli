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

## Comprueba tu comprensión

1. Localiza las cuatro responsabilidades en el proyecto.
2. Explica por qué var no está dentro de public.
3. Reto: escribe una regla de título que rechace más de 100 caracteres y no dependa de HTTP.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad18-pruebas/README.md) · [Índice](../README.md) · [Siguiente](../unidad20-despliegue/README.md)
