# Unidad 00. Tu primer programa y cómo estudiar

[Índice](../README.md) · [Siguiente](../unidad01-variables/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Distinguir editor, intérprete, terminal y navegador; ejecutar y modificar un programa.

Empieza aquí, sin conocimientos previos. Todos los comandos parten de `cursos/php`.

## Explicación

Un programa es una secuencia de instrucciones. PHP interpreta el archivo en el servidor o en la terminal. El navegador recibe el resultado, normalmente HTML, y no ejecuta las instrucciones PHP. GitHub Pages publica archivos estáticos: aquí lees el curso y descargas el código; los programas se ejecutan en tu equipo.

Instala una rama estable con soporte (recomendamos PHP 8.4 o 8.5) desde https://www.php.net/downloads.php. En Windows descarga el ZIP de PHP para tu arquitectura, extráelo, agrega su carpeta al PATH y abre una terminal nueva. Copia php.ini-development como php.ini; configura extension_dir y activa pdo_sqlite. En Ubuntu/Debian usa el gestor de paquetes para instalar php-cli y php-sqlite3; en macOS puedes usar `brew install php`. Los paquetes y nombres pueden variar por versión. Comprueba `php -v`, `php --ini` y `php -m`. No instales varias distribuciones a la vez: `where.exe php` (Windows) o `which php` (Linux/macOS) permite identificar la que se ejecuta.

Un editor como VS Code ayuda a escribir, pero no sustituye al intérprete. Descarga el ZIP del repositorio desde Code → Download ZIP y extráelo. Abre la carpeta `cursos/php` en el editor y en la terminal. Todos los comandos de las unidades parten de esa carpeta. Escribe `php unidad00-entorno/ejemplos/01.php`. Debe aparecer el saludo. PHP usa `<?php` para iniciar código; `echo` muestra texto y `;` termina la instrucción. En archivos que contienen solo PHP omitimos el cierre para evitar salida accidental.

Lee cada unidad en orden: predice, ejecuta, cambia una cosa y explica el efecto. Guarda una bitácora con comando, resultado y explicación. Reserva de dos a cuatro horas por unidad, y más para el proyecto; no hay fechas obligatorias. No necesitas experiencia previa. El HTML mínimo se explica antes de usar formularios.

## Ejemplo 1. Saludar desde la terminal

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

echo "Hola, aprende con Leli\n";
```

```sh
php unidad00-entorno/ejemplos/01.php
```

Salida esperada:

```text
Hola, aprende con Leli
```

echo emite el texto entre comillas. \n representa el salto de línea.

## Ejemplo 2. Seguir el orden

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

echo "1. Leer\n";
echo "2. Ejecutar\n";
```

```sh
php unidad00-entorno/ejemplos/02.php
```

Salida esperada:

```text
1. Leer
2. Ejecutar
```

Las instrucciones se ejecutan de arriba hacia abajo; cada llamada agrega salida.

## Comprueba tu comprensión

1. Ejecuta los dos ejemplos y copia la salida.
2. Cambia el saludo por tu nombre.
3. Reto: muestra tres pasos para preparar una clase, cada uno en una línea.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Índice](../README.md) · [Siguiente](../unidad01-variables/README.md)
