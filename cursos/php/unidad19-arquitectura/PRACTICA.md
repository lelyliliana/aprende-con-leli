# Práctica 19. Arquitectura sencilla y proyecto por etapas

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Separar validación, persistencia y presentación sin agregar complejidad innecesaria.

## Hazlo en tres pasos

1. Localiza las cuatro responsabilidades en el proyecto.
2. Explica por qué var no está dentro de public.
3. Reto: escribe una regla de título que rechace más de 100 caracteres y no dependa de HTTP.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Mapa:** sigue un POST de creación por public/index.php, validacion.php, TallerRepository.php y la redirección. Ubica cada responsabilidad.
2. **Dependencia:** prueba prepararAlta con un callback que cuente invocaciones y demuestra cero para la entrada inválida.
3. **Ampliación:** diseña el impacto de añadir categoría obligatoria: datos existentes, esquema, vista, validación, repositorio, API y pruebas.
4. **Revisión:** encuentra una responsabilidad que no debería cambiar al añadir categoría y explica por qué una dependencia oculta la volvería frágil.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».
