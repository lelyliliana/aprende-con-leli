# Unidad 21. Proyecto integrador: gestor de talleres

[Anterior](../unidad20-despliegue/README.md) · [Índice](../README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Entregar una aplicación local explicada, comprobada y ampliable.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

La necesidad es organizar talleres de una docente: crear título y cupo, encontrarlos, editar información y retirar los cancelados. La cuenta administradora cambia los datos y consulta la API. No se gestionan estudiantes ni datos personales en esta primera versión. Escribe primero tres historias de uso y sus criterios de aceptación.

Abre proyecto/CONSTRUCCION.md y sigue las cuatro etapas. El código de referencia completo está disponible para contrastar decisiones después de intentarlo; no representa automáticamente tu evidencia de aprendizaje. En cada etapa entrega una captura o salida, una explicación del flujo y una prueba de rechazo. No avances si solo puedes demostrar el caso feliz.

El recorrido integra datos, funciones, texto, HTTP, sesiones, SQL, objetos y pruebas. La rúbrica de proyecto/RUBRICA.md permite revisar el resultado con criterios observables. Como ampliación elige una sola característica: fechas estrictas, categorías, exportación CSV o control de versiones de edición. Declara qué cambia en los datos, la interfaz y las pruebas antes de programarla.

Has terminado cuando puedes reinstalar en una carpeta nueva, crear una cuenta, completar el CRUD, demostrar rechazos de entradas inválidas y acceso sin sesión, ejecutar las pruebas y explicar las limitaciones del uso local. Después puedes estudiar un framework; comprender primero el flujo HTTP y los contratos hará más fácil reconocer lo que automatiza.

## Ejemplo 1. Criterios observables

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$criterios = ["Crear un taller válido", "Rechazar cupo cero", "Conservar datos al reiniciar"];
foreach ($criterios as $indice => $criterio) { echo ($indice + 1) . ". $criterio\n"; }
```

```sh
php unidad21-proyecto/ejemplos/01.php
```

Salida esperada:

```text
1. Crear un taller válido
2. Rechazar cupo cero
3. Conservar datos al reiniciar
```

Un criterio describe algo que se puede observar y comprobar.

## Ejemplo 2. Decidir si una entrega está completa

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$evidencias = ["crud" => true, "seguridad" => true, "pruebas" => false];
$completa = !in_array(false, $evidencias, true);
echo $completa ? "Lista para revisar\n" : "Faltan evidencias\n";
```

```sh
php unidad21-proyecto/ejemplos/02.php
```

Salida esperada:

```text
Faltan evidencias
```

No basta que las pantallas funcionen: falta demostrar las pruebas.

## Comprueba tu comprensión

1. Completa las cuatro etapas de CONSTRUCCION.md.
2. Evalúa la entrega con RUBRICA.md y vincula cada criterio con una evidencia.
3. Reto: diseña una ampliación de categorías indicando esquema, validación y tres casos de prueba.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad20-despliegue/README.md) · [Índice](../README.md)
