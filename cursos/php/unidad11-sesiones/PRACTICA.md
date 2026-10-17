# Práctica 11. Sesiones, cookies y protección CSRF

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Conservar estado entre peticiones y proteger las operaciones del formulario.

## Hazlo en tres pasos

1. Dibuja dónde están la cookie, el ID y los datos de sesión.
2. Compara token correcto, incorrecto y ausente.
3. Reto: crea un token aleatorio y comprueba su longitud y su comparación con una copia.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Recorrido:** dibuja dos peticiones del mismo navegador y ubica Set-Cookie, Cookie, ID y datos del servidor.
2. **Aislamiento:** guarda una nota en el laboratorio y abre un perfil separado; explica por qué no debería aparecer allí.
3. **Rechazo:** envía un POST sin token y otro con token incorrecto; demuestra 403 y conservación del valor previo.
4. **Diseño:** describe qué renovarías después de un login y qué invalidarías al salir; distingue esa tarea del escape HTML.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».

## Laboratorio conectado

Completa también [11-sesiones](../laboratorios/11-sesiones/README.md) y conserva la evidencia indicada allí.
