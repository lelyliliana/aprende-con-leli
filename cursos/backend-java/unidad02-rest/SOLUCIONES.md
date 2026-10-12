# Soluciones de la Unidad 02

[Volver a la unidad](README.md)

Intenta los ejercicios antes de consultar.

1. POST crea con 201 y Location; GET consulta con 200; PUT devuelve el estado actualizado; DELETE termina con 204. Una consulta posterior del recurso eliminado devuelve 404.

2. Duplicado es conflicto con el estado actual (409); un precio que viola el DTO produce validación (400). Llegar al endpoint no implica satisfacer sus reglas.

3. El mapa vive en una JVM. Detener el proceso elimina ese estado. Dos réplicas tendrían mapas diferentes aunque ejecutaran el mismo código.

El reto necesita definir campos/tipos, unicidad, rutas y errores. Diseñar primero evita que cada cliente interprete una estructura distinta.
