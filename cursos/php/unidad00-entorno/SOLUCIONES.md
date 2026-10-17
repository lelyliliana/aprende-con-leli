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
