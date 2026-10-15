# Soluciones desarrolladas de la Unidad 05

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Contrasta tu evidencia con la secuencia y explica cualquier diferencia.

## 1. Identidad, permiso y token

El caso base editor con CSRF válido crea y devuelve 201. Sin identidad y con token válido se obtiene 401. Lector con token obtiene 403 por falta de PRODUCT_WRITE. Editor sin token obtiene 403 por CSRF. Esos dos 403 tienen causas distintas.

## 2. Validación que sí llega a MVC

Con precio 0, lector más token sigue obteniendo 403; no demuestra @Digits ni precio positivo. Editor más token obtiene 400 con code VALIDATION_ERROR y campo precio. La consulta posterior confirma que no se creó BACK-INV. Una denegación de acceso no debe contarse como prueba de formato.

## 3. Lecturas con políticas distintas

Health público devuelve UP sin components. Métricas sin identidad devuelve 401; con lector, 403; con editor, 200 porque posee OPS_READ. Un lector que consulta /api/pedidos/999999999 recibe 403, mientras editor obtiene 404 al llegar al caso de uso de un recurso ausente.

## Resolución del reto

Ejemplo educativo de materiales: visitante consulta catálogo; editor crea y actualiza; operador lee métricas. Registra PRODUCT_WRITE para cambios y OPS_READ para operación. Comprueba al menos un permiso permitido y uno denegado por ruta.

Si el recurso fuera un expediente personal, esa tabla global sería insuficiente: debes definir y probar quién puede leer cada expediente. El curso no implementa pertenencia por estudiante ni un proveedor de identidad real. La política propuesta debe declarar ese alcance antes de reutilizarla en otro contexto.
