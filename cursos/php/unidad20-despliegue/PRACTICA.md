# Práctica 20. Configuración, publicación y mantenimiento

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Preparar una entrega reproducible y reconocer lo que requiere un servidor real.

## Hazlo en tres pasos

1. Explica por qué subir un .php a GitHub Pages no ejecuta el programa.
2. Localiza los archivos que no deben estar en la raíz pública.
3. Reto: valida que una ruta de base configurada no esté vacía antes de abrir PDO.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Instalación:** completa el laboratorio de entrega con otra base y documenta versiones, extensiones, raíz pública y ruta de datos sin publicar secretos.
2. **Respaldo:** guarda datos ficticios, detén el servidor, copia la base y restáurala en otra ruta; verifica una fila conocida.
3. **Exposición:** solicita por HTTP un archivo de src y la ruta de la base; documenta el rechazo y explica por qué .gitignore no basta.
4. **Migración:** enumera cinco decisiones que revisarías para cambiar de SQLite a MySQL sin afirmar que PDO convierte automáticamente el esquema.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».

## Laboratorio conectado

Completa también [20-entrega](../laboratorios/20-entrega/README.md) y conserva la evidencia indicada allí.
