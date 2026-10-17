# Laboratorio 18. Una prueba que demuestra el defecto

[Lección](../../unidad18-pruebas/README.md) · [Laboratorios](../README.md) · [Programa](ejecutar.php)

## La regla antes del programa

Un cupo válido está entre 1 y 100, ambos inclusive. Escribe cuatro casos: 0 falso, 1 verdadero, 100 verdadero y 101 falso. Son expectativas de dominio, no resultados calculados por la implementación. El programa puede seleccionar una función correcta o una defectuosa que excluye el límite cien.

```sh
php laboratorios/18-pruebas/ejecutar.php
```

Debe mostrar Fallos: 0 y terminar con código cero. Ahora ejecuta la variante deliberadamente incorrecta:

```sh
php laboratorios/18-pruebas/ejecutar.php --defectuosa
```

Debe mostrar FALLO: cupo 100, después Fallos: 1, y terminar con código uno. Este rechazo es el resultado esperado del experimento; no corrijas la prueba para que acepte 100 como inválido.

## Observar el código de terminación

En Linux/macOS, inmediatamente después del comando consulta `echo $?`. En PowerShell consulta `$LASTEXITCODE`. La salida textual ayuda a una persona a investigar; el código permite a una herramienta automatizada decidir si el conjunto pasó. Un programa que imprime «falló» y termina con cero puede comunicar éxito a una integración continua que solo evalúa el código.

El verificador general del curso registra explícitamente que esta ejecución defectuosa debe terminar en uno. Esa excepción solo pertenece a la demostración. Las pruebas reales del proyecto deben terminar en cero cuando el comportamiento de la aplicación sea correcto y en no cero ante un incumplimiento.

## Por qué el caso cien aporta evidencia

Las dos funciones son idénticas salvo <=100 frente a <100. Probar únicamente 20 y 30 no detectaría la diferencia. El valor cien hace visible una frontera que la implementación equivocada cambió. Agregar muchos valores interiores no compensa omitir ese extremo. La selección de casos responde a caminos y límites, no a una meta de cantidad.

En una copia, retira cien de la tabla. La función defectuosa deja de ser detectada. Restáuralo y modifica el extremo inferior a >1: ahora el caso uno debe fallar. Recupera la versión correcta al terminar. Guarda las dos evidencias y explica qué hipótesis podía distinguir cada caso.

## Transferir al proyecto

Localiza las tablas de entradas inválidas de proyecto/tests/integracion.php. Identifica qué caso detecta un título de 101 caracteres, un arreglo como cupo y un token vacío. Después lee una comprobación HTTP: no solo debe observar el estado de error, también debe confirmar que no quedó un registro creado.

Entrega una prueba propia para la regla de fecha estricta de la unidad 6. Fija la fecha de referencia si agregas límites temporales y utiliza un día bisiesto válido y otro inválido. No hagas depender el esperado de hoy ni de la misma función que estás probando. Esa independencia convierte tu bitácora de errores en una protección que podrás volver a ejecutar después.
