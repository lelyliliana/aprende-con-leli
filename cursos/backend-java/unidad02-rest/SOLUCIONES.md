# Soluciones desarrolladas de la Unidad 02

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Contrasta tu evidencia con la secuencia y explica cualquier diferencia.

## 1. CRUD y forma de la respuesta

POST devuelve 201 y una Location que termina en el id recibido. GET de esa ruta devuelve el recurso. PUT válido conserva la identidad y devuelve datos actualizados. DELETE devuelve 204 sin cuerpo; el GET posterior devuelve 404. No se exige version porque no existe en el DTO REST.

## 2. Rechazo desarrollado

A tiene BACK-A y precio 10; B tiene BACK-B y precio 20. PUT de A con BACK-B y precio 99 produce 409. GET de A debe conservar BACK-A y precio 10, además del nombre e id anteriores. comprobarSku se ejecuta antes de productos.put; sustituir primero y validar después rompería esta garantía.

Precio 1.001 produce 400/VALIDATION_ERROR. El experimento envía también un SKU existente en esa petición, pero solo atribuye el rechazo a validación: el servicio todavía no demuestra unicidad en ese camino.

## 3. Filtro, borrado y reinicio

Con dos coincidencias, pagina=2 y tamano=1 devuelven contenido vacío y total 2. El total describe el conjunto filtrado, no la página actual. Borrar B reduce los datos de la JVM; reiniciar elimina también A y deja total 0 porque no hay almacenamiento externo.

## Resolución del reto

Un contrato de materiales mínimo define código único, nombre no blanco, precio positivo, id administrado y rutas. Incluye un válido, precio con tres decimales y duplicado. La garantía de unicidad del mapa pertenece a una instancia; una base compartida requerirá una restricción propia. El [experimento ejecutable](../docs/EXPERIMENTOS.md) permite contrastar estas expectativas con el código real.
