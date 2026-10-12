# Soluciones de la Unidad 06

[Volver a la unidad](README.md)

Intenta los ejercicios antes de consultar.

1. Service se puede probar con dependencia controlada; UNIQUE requiere verificar la restricción del motor; el estado HTTP pertenece al contrato web. Son fronteras complementarias.

2. Registra revisión, comando y resultado, distinguiendo H2/PostgreSQL y JAR/MockMvc. El recuento pertenece a esa ejecución y puede cambiar con una revisión nueva.

3. El 409 debe acompañarse de una consulta que confirme que no se sobrescribió el cambio válido. El código de estado solo no prueba el dato conservado.

El reto define un caso permitido y un rechazo de tu regla, y debe fallar si quitas su implementación. Usa evidencia observable del comportamiento.
