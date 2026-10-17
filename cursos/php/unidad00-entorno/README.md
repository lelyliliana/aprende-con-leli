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

## De una necesidad a instrucciones que una máquina puede seguir

Antes de instalar herramientas, piensa en una tarea pequeña: preparar materiales para tres estudiantes. Una persona puede interpretar «repartir lo necesario» porque conoce el contexto; un programa necesita cantidades, reglas y un resultado observable. El algoritmo es esa descripción ordenada y suficientemente precisa. El código es una forma de expresarlo en un lenguaje concreto. Una aplicación añade entrada, presentación, almacenamiento y manejo de errores alrededor de uno o varios algoritmos.

No necesitas memorizar toda la sintaxis para comenzar. Sí necesitas distinguir una instrucción de un dato. En `echo "Preparar materiales";`, echo es la operación y el contenido entre comillas es un dato textual. Escribir el nombre de otra persona dentro del texto no cambia la operación. Las comillas no aparecen necesariamente en la salida: delimitan el texto dentro del archivo. Esta diferencia entre representación y resultado reaparecerá al trabajar con HTML y JSON.

### Cuatro herramientas con trabajos distintos

| Herramienta | Trabajo | Cómo reconocer un fallo |
|---|---|---|
| Editor | Guarda el archivo de texto que escribes | El cambio no aparece porque no guardaste |
| Terminal | Recibe el comando y muestra su salida | No estás en la carpeta esperada |
| Intérprete PHP | Analiza y ejecuta el archivo | Informa un error PHP con archivo y línea |
| Navegador | Solicita y presenta páginas | Muestra una URL o una respuesta HTTP |

Cuando ejecutas un ejemplo CLI, el navegador no participa. Cuando sirves una página, el servidor invoca PHP y el navegador recibe el resultado. Cambiar de escenario sin reconocerlo es una causa común de confusión: ver un archivo en el editor no prueba que se haya ejecutado, y ver un archivo estático en el navegador no prueba que exista un intérprete detrás.

### Preparar una carpeta que puedas volver a encontrar

Crea una carpeta para el curso y conserva los nombres de las unidades. Una ruta relativa se interpreta desde la carpeta de trabajo de la terminal; por eso el curso fija un punto de partida. Si abres la terminal en cursos/php, unidad00-entorno/ejemplos/01.php es una ruta válida. Si la abres dentro de ejemplos, esa misma ruta apunta a un lugar diferente. Antes de corregir código, comprueba la ubicación: `pwd` en Linux/macOS o `Get-Location` en PowerShell.

Guarda en UTF-8 y muestra las extensiones de los archivos. Un documento llamado saludo.php.txt puede parecer PHP en un explorador que oculte extensiones, pero es otro nombre. Evita usar un procesador de texto que introduzca comillas tipográficas o formato enriquecido. En una ruta con espacios, rodea el argumento completo con comillas al ejecutar el comando. PHP no necesita que renombres todas tus carpetas para funcionar.

### Primera lectura de un programa

La apertura `<?php` indica dónde comienza el código. `declare(strict_types=1)` establece una regla de tipos que estudiaremos antes de las funciones; no imprime nada. Una línea vacía mejora la lectura y no representa una operación. Un comentario `//` explica una decisión para quien lee y no se ejecuta. El punto y coma termina una instrucción, aunque una instrucción pueda ocupar varias líneas.

Primero verifica que el ejemplo funciona sin cambios. Después modifica un único dato, guarda y ejecuta otra vez. Si cambias texto, comandos y carpetas al mismo tiempo, no sabrás cuál produjo el resultado. Esta forma de experimentar es parte del trabajo de programar, no un paso reservado a quienes ya saben.

### Una bitácora útil desde el primer día

Registra qué querías observar, qué comando ejecutaste y qué apareció. «No funciona» no permite investigar; «php no se reconoce antes de abrir el archivo» identifica un problema de entorno. «Parse error después de quitar una comilla» identifica un problema de sintaxis. Cuando puedas reconstruir un experimento sin adivinar pasos, tendrás una base sólida para todas las unidades siguientes.

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La apertura y declare no imprimen. |
| 2 | echo recibe un dato textual. |
| 3 | El salto de línea separa el siguiente mensaje. |

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La primera llamada muestra el paso 1. |
| 2 | La segunda se ejecuta después, no al mismo tiempo. |
| 3 | El orden visible reproduce el orden de las instrucciones. |

## Ejemplo 3. Predecir una salida con comentarios

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

// La explicación ayuda a leer, pero no se imprime.
echo "Materiales preparados\n";
echo "Tres estudiantes pueden comenzar\n";
```

Ejecuta desde cursos/php:

```sh
php unidad00-entorno/ejemplos/03.php
```

Resultado que debes obtener:

```text
Materiales preparados
Tres estudiantes pueden comenzar
```

### Lectura guiada y experimentos

La apertura y declare preparan la interpretación. PHP ignora el comentario y ejecuta las dos llamadas echo en orden. El salto `\n` pertenece a cada cadena y produce el cambio de línea en la terminal. Agrega un tercer echo antes del primero y predice dónde aparecerá; después vuelve a dejar el archivo como estaba.

Prueba en una copia quitar el punto y coma de la primera instrucción. El error puede señalar la siguiente línea, porque allí el analizador descubre que la instrucción anterior no terminó. No corrijas automáticamente la línea señalada sin leer también la anterior. Reponer el punto y coma debe recuperar exactamente las dos líneas esperadas.

## Comprueba tu comprensión

1. Ejecuta los tres ejemplos y copia la salida.
2. Cambia el saludo por tu nombre.
3. Reto: muestra tres pasos para preparar una clase, cada uno en una línea.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Índice](../README.md) · [Siguiente](../unidad01-variables/README.md)
