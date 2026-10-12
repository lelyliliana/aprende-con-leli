# Soluciones de la Unidad 04

[Volver a la unidad](README.md)

Intenta los ejercicios antes de consultar.

1. Además del HTTP, se verifica SKU y precio positivo. Una respuesta formalmente válida puede no corresponder a la petición.

2. Proveedor 404 se representa como recurso no encontrado; un fallo o cuerpo inválido puede traducirse a 503 según el contrato propio. El cliente no necesita conocer internals del proveedor.

3. GET de cotización consulta información externa; no realiza una escritura en el Repository de productos. Verifica con GET de producto antes/después.

El reto debe controlar la respuesta del servidor local y esperar rechazo, no introducir un valor ficticio en la capa de presentación. El test pertenece al cliente de proveedor.
