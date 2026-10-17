# Práctica 16. Contraseñas, autenticación y permisos

[Volver a la lección](README.md) · [Consultar después: soluciones](SOLUCIONES.md)

## Antes de escribir

Explica con tus palabras: Verificar identidad sin almacenar contraseñas en texto plano.

## Hazlo en tres pasos

1. Verifica una clave correcta y una incorrecta.
2. Explica por qué no se debe comparar un hash nuevo con el hash guardado.
3. Reto: crea una función de autorización que deniegue por defecto si falta el rol.

## Entrega y autocontrol

- Un archivo propio que resuelva el reto, sin copiar primero la solución.
- Una predicción y la salida real de los tres ejemplos; explica cualquier diferencia.
- Un caso normal y uno límite o inválido con resultado esperado.
- Un párrafo sobre el error que encontraste y cómo lo investigaste.

Compara después con SOLUCIONES.md. Si tu respuesta difiere, comprueba el contrato antes de cambiarla: puede haber varias soluciones correctas.

## Taller de profundización

1. **Identidad:** sigue el laboratorio de acceso y describe qué comprueba la clave y qué dato queda en sesión.
2. **Autorización:** amplía la matriz del ejemplo con una acción exportar y decide explícitamente qué rol la admite.
3. **Salida:** inicia sesión, cierra y solicita la API; debe responder 401 aunque conserves la URL.
4. **Diseño:** plantea tres controles necesarios para convertir el acceso local en servicio público y explica qué problema resuelve cada uno.

Conserva tu primera versión y una corregida. Justifica cada cambio con una entrada concreta; no reemplaces una explicación por «ahora funciona».

## Laboratorio conectado

Completa también [16-acceso](../laboratorios/16-acceso/README.md) y conserva la evidencia indicada allí.
