# Unidad 15. Namespaces, Composer y organización

[Anterior](../unidad14-objetos/README.md) · [Índice](../README.md) · [Siguiente](../unidad16-autenticacion/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Separar archivos y comprender la carga automática de clases.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

`require_once` carga un archivo una vez y detiene la ejecución si no está disponible. Usa rutas construidas desde __DIR__. Separar funciones en archivos no significa que cada archivo deba crear su propia conexión o emitir HTML. Un archivo reutilizable debe evitar efectos secundarios inesperados.

Un namespace organiza nombres: `namespace Aprende;` permite que dos bibliotecas tengan clases con el mismo nombre corto. `use` importa un nombre para referenciarlo más fácilmente; no carga por sí solo el archivo. Composer gestiona dependencias y puede generar un autoloader PSR-4 que relaciona prefijos de namespace con carpetas. Nuestro proyecto funciona sin paquetes externos para facilitar el inicio, y ofrece una configuración Composer opcional.

Instala Composer desde https://getcomposer.org/download/ y comprueba `composer --version`. Desde proyecto ejecuta `composer install` para generar vendor/autoload.php. Con PSR-4, Aprende\TallerRepository se ubica en src/TallerRepository.php. En una aplicación con dependencias, conserva composer.json y composer.lock en el repositorio; no subas vendor. `composer install` reproduce las versiones del lock; `composer update` las resuelve de nuevo. Revisa las dependencias antes de agregarlas y no pegues un instalador desconocido en tu terminal.

## Ejemplo 1. Un nombre completo

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

namespace Aprende;
final class Etiqueta {
    public static function texto(): string { return "Aprende con Leli"; }
}
echo Etiqueta::texto() . "\n";
echo Etiqueta::class . "\n";
```

```sh
php unidad15-composer/ejemplos/01.php
```

Salida esperada:

```text
Aprende con Leli
Aprende\Etiqueta
```

El namespace forma parte del nombre completo. ::class lo devuelve como texto.

## Ejemplo 2. Una función para resolver rutas

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$raiz = '/curso/proyecto';
$clase = 'Aprende\\TallerRepository';
$relativa = substr($clase, strlen('Aprende\\'));
echo $raiz . '/src/' . str_replace('\\', '/', $relativa) . ".php\n";
```

```sh
php unidad15-composer/ejemplos/02.php
```

Salida esperada:

```text
/curso/proyecto/src/TallerRepository.php
```

Es una demostración de la correspondencia; Composer genera un cargador más completo para resolverla.

## Comprueba tu comprensión

1. Lee proyecto/composer.json y localiza autoload y scripts.
2. Explica por qué use no sustituye require_once.
3. Reto: representa la ruta de Aprende\Servicio\Inscripcion bajo src.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad14-objetos/README.md) · [Índice](../README.md) · [Siguiente](../unidad16-autenticacion/README.md)
