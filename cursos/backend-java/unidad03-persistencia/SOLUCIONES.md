# Soluciones de la Unidad 03

[Volver a la unidad](README.md)

Intenta los ejercicios antes de consultar.

1. La entrada contiene categoriaId y la base exige una referencia válida. Un ID inexistente se rechaza; no basta que sea un número positivo.

2. La primera actualización usa la versión leída y el servidor la incrementa. Repetir la anterior produce 409; GET permite confirmar que el estado válido no se perdió.

3. Recargar un cliente no reinicia Java. H2 en memoria pierde cambios al detenerlo; H2 en archivo conserva el registro si se abre la misma ruta. El motor real de cada prueba debe registrarse.

Para el reto, dos POST del mismo SKU no deben producir dos filas. Espera una creación y un conflicto, respaldados por UNIQUE, y consulta el resultado final.
