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

## Organizar un programa para que otra persona lo ejecute

Cuando todo vive en un archivo, resulta fácil empezar y difícil ver las fronteras a medida que crece. Separar archivos debe permitir localizar una responsabilidad, no esconder instrucciones ejecutadas en un orden misterioso. Un archivo de funciones puede definir operaciones sin abrir conexiones ni emitir HTML al incluirse. El punto de entrada decide cuándo cargar código, leer configuración y atender una petición.

require detiene la operación si el archivo requerido no está disponible. require_once evita volver a cargarlo durante la misma ejecución. Una ruta anclada a __DIR__ se interpreta desde el archivo que la construye, lo que permite incluirlo desde pruebas y CLI sin depender de dónde se abrió la terminal. Una ruta escrita solo como src/archivo.php puede depender del contexto de ejecución y resultar más frágil.

### Namespaces como organización de nombres

Dos bibliotecas pueden tener una clase llamada Usuario. Un namespace distinto permite diferenciarlas sin renombrar cada clase con un prefijo largo manualmente. El nombre completo incluye su namespace; use permite escribir un alias legible dentro del archivo consumidor. Ninguna de esas operaciones produce por sí sola la definición de una clase que todavía no se ha cargado.

Dentro de un namespace, una referencia corta a una clase se resuelve según las reglas de nombres e imports. Las clases globales como PDO o RuntimeException pueden importarse con use o escribirse con barra inicial. Un «Class not found» puede indicar un problema de resolución o de carga, no que la clase se haya eliminado del lenguaje. Comprueba el nombre completo y después qué archivo debía definirlo.

### Autoload: cargar cuando una clase se necesita

spl_autoload_register permite registrar una función que recibe el nombre de una clase no cargada. Un cargador sencillo puede traducir un prefijo conocido a una carpeta. No debe aceptar una ruta arbitraria enviada por una persona ni incluir cualquier archivo del disco. En el tercer ejemplo limitamos las clases a dos definiciones conocidas para observar el momento de carga sin crear un framework.

PSR-4 formaliza una correspondencia entre prefijos de namespace, rutas y nombres de archivo. Si Aprende\\ se asocia con src/, Aprende\\TallerRepository corresponde a src/TallerRepository.php. Las mayúsculas deben coincidir. Un cambio de sistema de archivos puede descubrir un error que pasó inadvertido en otro equipo. La convención aporta reproducibilidad, no solo una preferencia de estilo.

### Composer gestiona más que un autoloader

composer.json describe requisitos del proyecto y cómo se organiza su código. composer.lock fija una resolución concreta de dependencias cuando las hay. composer install usa el lock existente para reproducirla; composer update vuelve a resolver dentro de las restricciones y puede cambiar versiones. Si una tarea consiste en ejecutar un proyecto, no uses update solo porque aparece un paquete desactualizado: primero entiende qué resultado necesitas reproducir.

vendor contiene código instalado y generado que normalmente no se versiona. Debes poder regenerarlo a partir de los archivos de configuración y una fuente disponible. Una dependencia es código que ejecutará tu aplicación: revisa para qué la necesitas y cómo se mantiene. Agregar un paquete para una transformación de dos líneas no es siempre una mejora; tampoco conviene reconstruir a ciegas componentes complejos bien mantenidos.

### Un experimento de carga que puedas seguir

En el [laboratorio de autoload](../laboratorios/15-autoload/README.md) usarás dos archivos reales de clases y un cargador PSR-4 limitado al namespace del ejercicio. Primero sigue la ruta manualmente; luego, si tienes Composer, genera su cargador y compara el resultado. La práctica principal funciona sin descargar paquetes ni servicios.

Registra cuándo se incluye cada archivo. Cargar una clase no crea automáticamente una instancia ni ejecuta sus métodos, aunque el código suelto del archivo incluido sí puede producir efectos. Por eso el laboratorio mantiene archivos de clase sin echo ni conexión. Esta decisión permitirá comprender después por qué la configuración de una aplicación y sus definiciones no deben mezclarse por accidente.

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | El namespace añade Aprende al nombre de la clase. |
| 2 | El método estático devuelve un texto sin crear una instancia. |
| 3 | ::class devuelve el nombre completo para inspeccionarlo. |

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La clase se representa como texto con su prefijo. |
| 2 | substr retira el prefijo y str_replace convierte separadores. |
| 3 | La ruta calculada termina en src/TallerRepository.php; todavía no se incluye ningún archivo. |

## Ejemplo 3. Observar cuándo actúa un cargador

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

$llamadas = 0;
spl_autoload_register(function (string $nombre) use (&$llamadas): void {
    if ($nombre === "EtiquetaCarga") {
        $llamadas++;
        // La clase se define al alcanzar este bloque; no se usa eval ni una ruta externa.
        class EtiquetaCarga {
            public function texto(): string { return "Clase disponible"; }
        }
    }
});
echo (new EtiquetaCarga())->texto() . "\n";
echo (new EtiquetaCarga())->texto() . "\n";
echo "Cargas: $llamadas\n";
```

Ejecuta desde cursos/php:

```sh
php unidad15-composer/ejemplos/03.php
```

Resultado que debes obtener:

```text
Clase disponible
Clase disponible
Cargas: 1
```

### Lectura guiada y experimentos

La primera referencia solicita una clase que aún no existe, por lo que PHP llama al cargador. Este reconoce exactamente ese nombre y define la clase al ejecutar el bloque. La segunda referencia ya encuentra la definición y no vuelve a cargarla. Dos instancias no implican dos inclusiones del mismo archivo.

La función anónima captura el contador por referencia mediante use (&$llamadas) para hacer visible la cantidad de invocaciones. Es un instrumento de observación, no una recomendación de estado global en la aplicación. El laboratorio siguiente reemplaza la definición dentro del cargador por require sobre una ruta construida desde un prefijo permitido.

## Comprueba tu comprensión

1. Lee proyecto/composer.json y localiza autoload y scripts.
2. Explica por qué use no sustituye require_once.
3. Reto: representa la ruta de Aprende\Servicio\Inscripcion bajo src.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad14-objetos/README.md) · [Índice](../README.md) · [Siguiente](../unidad16-autenticacion/README.md)
