# Práctica 12. SQL, SQLite y PDO

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Consultar datos con sentencias preparadas y restricciones.

## Hazlo en tres pasos

1. Inserta dos títulos y léelos con ORDER BY id.
2. Busca un título con comilla simple usando un parámetro.
3. Reto: inicia una transacción, inserta un taller y revierte; comprueba que no queda la fila.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Esquema:** dibuja categorías y talleres, señala claves primarias y foránea, y explica qué nombre no necesitas repetir en cada taller.
2. **Consulta:** completa el laboratorio SQL y predice el informe de una categoría vacía antes de ejecutar.
3. **Integridad:** intenta insertar un taller con categoria_id inexistente, con foreign_keys activado; debe fallar sin agregar la fila.
4. **Transacción:** agrega dos operaciones relacionadas y provoca un fallo en la segunda; confirma que ninguna queda guardada tras revertir.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».

## Laboratorio conectado

Completa también [12-sql](../laboratorios/12-sql/README.md) y conserva la evidencia indicada allí.
