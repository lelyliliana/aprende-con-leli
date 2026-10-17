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

## Integrar significa explicar cómo colaboran las partes

El proyecto final no es solo una colección de temas del temario. Es un recorrido que debe conservar reglas al atravesar varias fronteras. Una entrada comienza como datos HTTP inciertos, se valida, produce una operación de dominio, se persiste y termina como respuesta. La identidad y el token se comprueban antes de cambiar información. Puedes demostrar cada paso por separado, pero la entrega debe demostrar también que están conectados correctamente.

Antes de ejecutar la referencia, escribe tres historias concretas. «Como docente quiero cambiar el cupo de un taller para reflejar otra aula» es más verificable que «tener administración». Añade qué cuenta puede hacerlo, qué datos son válidos y cómo compruebas que el cambio se conservó. Una historia termina con una condición observable; no con la existencia de un botón.

### Construir entregas pequeñas que mantengan una promesa

La etapa uno valida en consola y no necesita pantalla. La segunda conserva datos con SQL y distingue filas inexistentes. La tercera incorpora interacción HTTP, sesión y token. La cuarta añade evidencia completa de acceso, API y reproducción. No adelantes la última pantalla si todavía no puedes demostrar el rechazo de datos inválidos de la primera etapa.

Los [laboratorios](../laboratorios/README.md) son puentes entre esas entregas. El formulario de validación no guarda; el de notas muestra una sesión; el CRUD de sesión aísla transiciones; el proyecto une SQLite y autenticación. Al compararlos, identifica exactamente qué responsabilidad aparece por primera vez. Así no tienes que aprender toda la aplicación completa para observar por qué una redirección evita reenvíos accidentales.

### Leer la referencia desde sus contratos

Empieza por schema.sql y validarTaller para conocer los estados admitidos. Después lee el repositorio y sigue una consulta preparada. Por último entra a public/index.php y localiza las salidas que terminan la petición: responderError, volver y la respuesta JSON. Dibuja una rama válida y otra inválida del mismo POST, marcando dónde dejan de compartir recorrido.

No copies la referencia cambiando solamente nombres para considerar terminado el aprendizaje. Una buena evidencia es poder introducir una regla pequeña con pruebas, por ejemplo una categoría permitida o una fecha estricta. Si ese cambio exige borrar todos los errores y empezar de nuevo, vuelve al mapa de responsabilidades. Conserva la versión anterior y describe qué contrato se amplió.

### Diseñar una ampliación acotada

Una exportación CSV parece pequeña, pero requiere decidir quién accede, qué filas incluye, qué columnas conserva y cómo trata texto que una hoja de cálculo podría interpretar como fórmula. El escape HTML no resuelve ese contexto. Una fecha añade formato, calendario, zona y límites del dominio. Una categoría añade una relación y migración de filas existentes. Elegir una característica no significa que solo cambie un input.

Selecciona una de esas ampliaciones y escribe tres casos antes de implementarla. Si el alcance incluye funciones o riesgos que aún no estudiaste, reduce la primera entrega o consulta documentación específica. Declarar un límite es parte de un diseño honesto; no conviertas una demostración local en una promesa de gestionar información sensible sin revisar almacenamiento y acceso.

### Entregar evidencia que otra persona pueda revisar

Tu bitácora debe permitir repetir el trabajo: versiones, comandos, entradas, resultados y un fallo investigado. Las capturas muestran experiencia de uso; las pruebas muestran contratos. Necesitas ambas cuando un criterio incluye servidor y presentación. Una captura de un error rojo no demuestra por sí sola que la base no cambió; consulta después para comprobarlo.

Cierra con una instalación nueva y una explicación de cinco minutos según la rúbrica. Señala qué aprendiste a resolver sin ayuda y qué consultarías para un entorno público: límites de intentos, recuperación, concurrencia, copias y observabilidad. Los siguientes pasos pueden incluir MySQL, un framework o servicios externos, pero serán más provechosos cuando reconozcas las tareas que automatizan en lugar de atribuirles un funcionamiento mágico.

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | Los criterios se escriben como acciones comprobables. |
| 2 | foreach recorre cada texto con un índice desde cero. |
| 3 | La presentación suma uno para una numeración humana de 1 a 3. |

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | El arreglo registra tres evidencias independientes. |
| 2 | in_array detecta que todavía existe una evidencia false. |
| 3 | La negación impide declarar lista una entrega con pruebas pendientes. |

## Ejemplo 3. Recorrer el dominio y el repositorio reales

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

require_once dirname(__DIR__, 2) . "/proyecto/src/bootstrap.php";
$db = new PDO("sqlite::memory:", null, null, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);
$db->exec(file_get_contents(dirname(__DIR__, 2) . "/proyecto/schema.sql"));
$repo = new Aprende\TallerRepository($db);
$validacion = Aprende\validarTaller(["titulo" => " Taller PHP ", "cupo" => "12"]);
if ($validacion["errores"] !== []) { throw new RuntimeException("La entrada debería ser válida"); }
$datos = $validacion["datos"];
$id = $repo->crear($datos["titulo"], $datos["cupo"]);
echo "Creado: " . $repo->buscar($id)["titulo"] . "\n";
$repo->actualizar($id, "Taller PHP web", 20);
echo "Cupo editado: " . $repo->buscar($id)["cupo"] . "\n";
$repo->eliminar($id);
echo "Registros finales: " . $repo->contar() . "\n";
```

Ejecuta desde cursos/php:

```sh
php unidad21-proyecto/ejemplos/03.php
```

Resultado que debes obtener:

```text
Creado: Taller PHP
Cupo editado: 20
Registros finales: 0
```

### Lectura guiada y experimentos

Este ejemplo reutiliza exactamente la validación, el esquema y el repositorio del proyecto, con una base aislada en memoria. El título se normaliza antes de insertar, el ID devuelto se conserva para la edición y el borrado no depende del orden de la lista. La base de estudio no participa ni se modifica.

El recorrido demuestra colaboración de dominio y almacenamiento; no demuestra autenticación ni cabeceras, porque no hay HTTP. Esas propiedades se comprueban mediante la interfaz y las pruebas HTTP. Cambia cupo a "0": el ejemplo debe detenerse antes de crear el taller. Después restaura el dato válido y confirma los tres resultados esperados.

## Comprueba tu comprensión

1. Completa las cuatro etapas de CONSTRUCCION.md.
2. Evalúa la entrega con RUBRICA.md y vincula cada criterio con una evidencia.
3. Reto: diseña una ampliación de categorías indicando esquema, validación y tres casos de prueba.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad20-despliegue/README.md) · [Índice](../README.md)
