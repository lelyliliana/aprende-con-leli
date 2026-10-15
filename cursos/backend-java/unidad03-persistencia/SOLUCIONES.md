# Soluciones desarrolladas de la Unidad 03

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Contrasta tu evidencia con la secuencia y explica cualquier diferencia.

## 1. Categoría y restricción

categoriaId se obtiene de la API, no de una suposición sobre la secuencia de otra base. El servicio busca la categoría; si falta, devuelve 404. El motor conserva una FK. Validar que un número sea positivo no demuestra que exista el registro referenciado.

## 2. Versión desarrollada

Creación: precio 10/version 0. PUT válido: envía 0 y recibe precio 15/version 1. PUT viejo: envía 0 y precio 99, recibe 409. GET final: mantiene la respuesta válida. No sumes uno a la versión en el cliente como si pudieras decidir qué número acepta el servidor; envía la última que recibiste.

La consulta explícita posterior es necesaria: un 409 aislado no prueba que no haya mutación. El servicio compara versión antes de cambiar campos y la base usa @Version para la escritura concurrente.

## 3. Duración entre reinicios

Recargar el cliente no termina Java. Reiniciar H2 en memoria pierde cambios. Reiniciar con el mismo archivo conserva id, precio, categoría y versión; una ruta relativa distinta podría abrir otra base. El experimento usa una ruta absoluta temporal y cierra el primer proceso antes del segundo.

No se vuelven a insertar las migraciones ya aplicadas al abrir el mismo archivo. Se comprueba que BACK-DUR siga una sola vez. El archivo temporal desaparece al finalizar el programa, después de comprobar duración entre procesos.

## Resolución del reto

Dos creaciones simultáneas del mismo SKU deben dejar una sola fila. Se espera un 201 y un 409, con UNIQUE como garantía en el motor. Anota cómo coordinaste ambas peticiones y consulta la fila final. El verificador público tiene una variante PostgreSQL para esa carrera; el experimento de archivo de esta unidad demuestra otro riesgo y no debe presentarse como esa prueba concurrente.
