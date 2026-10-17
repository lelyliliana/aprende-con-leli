# Soluciones 20. Configuración, publicación y mantenimiento

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

GitHub Pages entrega archivos estáticos y no dispone de intérprete PHP para tus peticiones. src, var, bin y tests quedan fuera de la raíz pública. Solo public contiene los archivos que debe servir el sitio de la aplicación.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

function exigirRuta(string $ruta): string {
    if (trim($ruta) === "") { throw new InvalidArgumentException("Ruta vacía"); }
    return $ruta;
}
try { exigirRuta(" "); } catch (InvalidArgumentException $e) { echo $e->getMessage() . "\n"; }
```

Desde cursos/php:

```sh
php unidad20-despliegue/soluciones/reto.php
```

La salida es Ruta vacía. En el despliegue además debes comprobar que la ruta sea absoluta, esté fuera de public y tenga permisos adecuados.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.

## Solución razonada del taller de profundización

La copia debe ejecutarse con su propia APP_DB y no depender del archivo de estudio anterior. El respaldo restaurado debe conservar una fila conocida y permitir una consulta desde una conexión nueva. La prueba no sobrescribe el original; si la copia no funciona, todavía tienes la fuente intacta para investigar.

Las rutas privadas no deben servirse desde public. .gitignore solo evita incluir archivos en Git: no impone reglas HTTP. Para MySQL revisa DSN y credenciales, tipos y autoincremento, funciones de búsqueda, restricciones e índices, estrategia transaccional y transferencia de datos. Finalmente ejecuta las pruebas en el motor nuevo; pasar con SQLite no demuestra compatibilidad total.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
