# Laboratorio 12. Informe relacional y operación atómica

[Lección](../../unidad12-pdo/README.md) · [Laboratorios](../README.md) · [Programa](informe.php) · [Salida esperada](informe.txt)

## Preparación

Necesitas PDO SQLite. El programa crea una base en memoria para que cada ejecución comience igual; no utiliza ni modifica proyecto/var. Antes de correr, dibuja dos tablas y coloca los datos ficticios: Web contiene PHP con 12 plazas y HTML con 8, Datos contiene SQL con 10, Robótica no tiene talleres.

```sh
php laboratorios/12-sql/informe.php
```

Debes ver tres líneas de informe, el mensaje de reversión y un conteo final de tres. Contrasta la [salida guardada](informe.txt) antes de cambiar el SQL.

## Comprender las tablas

categorias tiene ID y nombre; talleres tiene ID, categoria_id, título y cupo. La clave foránea impide apuntar a una categoría desconocida cuando foreign_keys está habilitado. El CHECK rechaza cupos fuera de rango. El nombre de la categoría no se repite en cada taller: JOIN lo recupera al elaborar el informe.

La sentencia preparada inserta cada registro desde parámetros. El ID de categoría se envía como valor; no se concatena en la estructura. La conexión usa excepciones para que una violación de restricción interrumpa la operación y pueda activar la reversión definida.

## Leer el informe por partes

FROM categorias establece qué entidades quieres conservar. LEFT JOIN agrega talleres cuando existen. GROUP BY reúne por categoría, COUNT(t.id) cuenta talleres reales y SUM acumula plazas. Una categoría sin coincidencia produce null para la suma; COALESCE lo transforma en cero para el informe. ORDER BY c.id hace determinista la presentación.

Predice las tres filas: Web tiene dos talleres y veinte plazas; Datos uno y diez; Robótica cero y cero. Sustituye LEFT JOIN por INNER JOIN en una copia: la categoría vacía desaparece. Restaura y cambia COUNT(t.id) por COUNT(*): observa por qué contar filas del enlace no siempre equivale a contar talleres.

## Seguir la transacción

Después del informe comienza una transacción. La primera inserción temporal es válida. La segunda intenta usar categoría 999 y falla. El catch revierte si la conexión sigue dentro de la transacción. El conteo final debe ser tres, no cuatro: eso demuestra que tampoco quedó guardada la primera inserción.

Si el programa mostrara el mensaje de error pero dejara cuatro filas, habría detectado el fallo sin conservar la atomicidad. La evidencia de transacción es el estado final, no solo la presencia de try/catch. No desconectes foreign_keys para hacer pasar el ejemplo: eliminarías la regla que intenta comprobar.

## Taller y transferencia

Agrega la categoría Diseño sin talleres y espera otra fila de ceros. Luego añade un taller de Diseño con cupo 15 y predice cómo cambia el informe. Conserva un caso con comilla en el título para demostrar que el parámetro sigue siendo un dato.

Como reto, cambia la causa del fallo a cupo cero, manteniendo válida la categoría. La reversión debe seguir dejando el mismo conteo inicial. Identifica qué restricción provocó cada fallo y explica por qué ambos se manejan como un conjunto que no pudo completarse. Más adelante el proyecto usa una sola tabla de talleres; este laboratorio enseña el camino para añadir relaciones con una decisión explícita.
