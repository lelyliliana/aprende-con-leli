# Soluciones de la Unidad 05

[Volver a la unidad](README.md)

Intenta los ejercicios antes de consultar.

1. Editor con token/cookie puede crear si la entrada es válida. Lector con token recibe 403. Sin identidad pero con token se espera 401. Sin token puede rechazarse antes con 403.

2. Una entrada inválida autorizada alcanza la validación del DTO. Una petición denegada por Security no demuestra que el DTO valide.

3. El catálogo GET es público; métricas necesitan OPS_READ y pedidos PRODUCT_WRITE. Define acceso por ruta/operación y no solo por el nombre del método HTTP.

El reto debe registrar actor, permiso y respuesta esperada. Mantén identidad y reglas de negocio como responsabilidades relacionadas pero diferentes.
