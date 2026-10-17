# Laboratorio 15. Cargar clases desde archivos reales

[Lección](../../unidad15-composer/README.md) · [Laboratorios](../README.md)

## Objetivo

Sigue la relación entre namespace, clase y ruta sin depender de un paquete externo. Hay dos clases: Saludo construye un mensaje e Informe recibe Saludo para producir su línea. Ningún archivo de clase imprime al incluirse. ejecutar.php crea los objetos y presenta el resultado.

```sh
php laboratorios/15-autoload/ejecutar.php
```

Resultado esperado: Hola, Leli; clases cargadas por demanda.

## Lee los archivos en un orden útil

1. [Saludo.php](src/Saludo.php) declara AprendeLab\\Saludo y su método mensaje.
2. [Informe.php](src/Informe.php) recibe Saludo por constructor y usa su contrato.
3. [autoload.php](autoload.php) registra el prefijo permitido y traduce dos nombres conocidos a src.
4. [ejecutar.php](ejecutar.php) incluye el cargador y utiliza las clases con use.

La ruta se construye desde __DIR__, de modo que no cambia al abrir la terminal en otro lugar. La lista permitida evita tratar una entrada externa como una ruta a incluir. El cargador es pequeño para que puedas seguirlo entero; Composer ofrece una implementación más general para proyectos reales.

## Experimenta con el momento de carga

Agrega temporalmente a una copia del cargador un mensaje antes de require_once. Crea dos instancias de Saludo: el archivo debe cargarse una vez, aunque haya dos objetos. Después elimina esos mensajes para recuperar la salida esperada. Mezclar diagnóstico con la salida final de una aplicación puede alterar cabeceras o un cuerpo JSON; por eso el experimento se mantiene separado.

Cambia una letra mayúscula del nombre del archivo en una copia y prueba la resolución. En un sistema sensible a mayúsculas, el archivo no se encuentra. Comprueba también que use por sí solo no carga nada: si quitas el cargador, referenciar la clase falla aunque el import permanezca escrito.

## Variante opcional con Composer

Si ya instalaste Composer, entra en laboratorios/15-autoload y ejecuta `composer install`. El [composer.json](composer.json) no pide bibliotecas externas: define PHP mínimo y el prefijo PSR-4. Composer genera vendor/autoload.php. En una copia de ejecutar.php sustituye el require del cargador manual por el de vendor/autoload.php y espera la misma línea.

No conserves dos cargadores por costumbre si ya elegiste uno para el experimento. Explica cuál está activo y qué archivo genera. La variante es opcional; las comprobaciones del curso utilizan el cargador manual para no exigir descarga o Composer en el primer recorrido.

## Entrega

Añade una clase propia Resumen al namespace del ejercicio. Si utilizas el cargador manual, agrega explícitamente el nombre a la lista permitida; con PSR-4, respeta la correspondencia de carpetas. Haz que reciba una lista por constructor y devuelva su cantidad, sin imprimir en el archivo de clase.

Entrega un mapa de tres nombres completos a tres rutas y una ejecución que invoque sus métodos. Debes poder distinguir cargar una definición, crear una instancia e invocar una operación. Son tres eventos diferentes, aunque una expresión breve pueda provocarlos en la misma línea.
