# Soluciones 00. Tu primer programa y cómo estudiar

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

El primer programa muestra Hola, aprende con Leli. El segundo imprime primero Leer y luego Ejecutar: cambiar el orden de las instrucciones cambia ese orden. Al poner tu nombre, el intérprete sigue ejecutando echo; solo cambia el dato entre comillas.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

echo "1. Elegir un objetivo\n2. Preparar materiales\n3. Probar la actividad\n";
```

Desde cursos/php:

```sh
php unidad00-entorno/soluciones/reto.php
```

Los tres saltos de línea separan las acciones. Si falta un punto y coma, revisa la línea anterior a la que señala el error de sintaxis.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.

## Solución razonada del taller de profundización

El archivo se guarda en disco desde el editor; la terminal entrega la ruta al intérprete, y este emite texto que la terminal presenta. En el programa de cuatro pasos deben observarse cuatro líneas, no el comentario. Una ruta incorrecta impide abrir el archivo antes de ejecutar sus instrucciones: cambiar echo no resolvería ese fallo.

Para servir una página hace falta un servidor HTTP que invoque PHP y un navegador que lo solicite. El navegador recibe el resultado; no necesitas mover las instrucciones al navegador. La evidencia mínima son el código guardado, el comando exacto y las cuatro líneas obtenidas. Si un compañero no puede repetirlo, aclara desde qué carpeta debe ejecutar.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
