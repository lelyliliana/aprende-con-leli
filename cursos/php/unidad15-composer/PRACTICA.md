# Práctica 15. Namespaces, Composer y organización

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Separar archivos y comprender la carga automática de clases.

## Hazlo en tres pasos

1. Lee proyecto/composer.json y localiza autoload y scripts.
2. Explica por qué use no sustituye require_once.
3. Reto: representa la ruta de Aprende\Servicio\Inscripcion bajo src.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Archivos:** completa el laboratorio de autoload y localiza el archivo de cada clase a partir de su nombre completo.
2. **Experimento:** crea dos instancias y comprueba que cada archivo se incluye una sola vez en la ejecución normal del cargador.
3. **Diagnóstico:** cambia en una copia una mayúscula de la ruta y explica por qué puede fallar en Linux aunque funcionara en otro sistema.
4. **Reproducción:** explica qué conservarías en Git y qué regenerarías si el proyecto usa dependencias instaladas con Composer.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».

## Laboratorio conectado

Completa también [15-autoload](../laboratorios/15-autoload/README.md) y conserva la evidencia indicada allí.
