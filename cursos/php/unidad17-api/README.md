# Unidad 17. APIs JSON y contratos HTTP

[Anterior](../unidad16-autenticacion/README.md) · [Índice](../README.md) · [Siguiente](../unidad18-pruebas/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Exponer datos estructurados y distinguir estados de respuesta.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una API ofrece un contrato para que otro programa solicite operaciones o datos. El cuerpo JSON no es HTML. Antes de emitirlo configura Content-Type: application/json; charset=utf-8 y un estado adecuado. 200 indica éxito de lectura, 201 creación, 400 petición mal formada, 401 falta de autenticación, 403 permiso insuficiente o CSRF inválido, 404 recurso inexistente, 405 método no admitido, 422 validación de dominio fallida y 500 un error interno.

Decodifica una petición JSON con JSON_THROW_ON_ERROR, distingue un objeto de una lista y valida cada propiedad. Un JSON válido como [1,2] puede incumplir el contrato. No expongas automáticamente todas las columnas de una tabla: selecciona las que forman parte de la respuesta. En particular no incluyas contraseñas ni hashes.

El proyecto implementa una API de lectura autenticada en /api/talleres con filtro y paginación. No habilita escrituras por JSON: los cambios se hacen mediante formularios protegidos. Esta decisión reduce la superficie del primer proyecto. Las cookies de sesión viajan también en las llamadas del mismo origen; no agregues CORS permisivo como solución general a un error del navegador. Un cliente externo necesitaría un mecanismo de autenticación diseñado para ese caso.

## Diseñar la respuesta antes de programarla

Una API es útil si otro programa puede depender de su contrato sin inspeccionar la implementación. Define método, ruta, autenticación, parámetros, estados y forma del cuerpo. Si unas veces data contiene un objeto y otras una lista según cuántos resultados haya, el cliente necesita adivinar un caso especial innecesario. Mantén siempre una lista para un recurso de colección, incluso cuando está vacía.

Selecciona las propiedades que expones. Devolver directamente SELECT * de una tabla de usuarios podría revelar un hash o una columna añadida después. Un contrato explícito permite evolucionar el almacenamiento sin cambiar automáticamente la representación pública. El proyecto devuelve id, titulo y cupo, más metadatos de paginación; no anuncia operaciones de escritura que no implementa.

### Métodos, estados y cabeceras forman parte del resultado

GET consulta sin modificar el recurso. POST puede crear o ejecutar otra operación definida; PUT suele representar un reemplazo y PATCH una modificación parcial, pero tu servidor debe implementar y documentar exactamente lo que acepta. No agregues nombres de métodos a la guía como si existieran por convención. Para un método no admitido responde 405 y Allow con los admitidos.

Un 204 no lleva cuerpo; no lo combines con un JSON que el cliente espera leer. Un 201 puede indicar creación con una ubicación del recurso según el diseño. El proyecto solo necesita 200 para sus lecturas y estados de error conocidos. Elegirlos de forma coherente permite que el cliente distinga una lista vacía, un acceso denegado y una caída del servidor sin buscar palabras en un mensaje.

### Cuerpos JSON y estructuras inesperadas

Cuando un endpoint recibe JSON, el contenido está en el cuerpo y no aparece automáticamente en $_POST como si fuera un formulario. Lee php://input, impón límites apropiados y decodifica con un manejo de error explícito. Un objeto {}, una lista [] y null son documentos válidos diferentes. Si decodificas todo a arreglos, el objeto vacío y la lista vacía pueden perder una distinción que tu contrato necesita.

Usar stdClass para comprobar la forma exterior y después validar propiedades permite conservar esa diferencia. Rechaza campos de tipos incompatibles antes de convertir. Decide también qué ocurre con propiedades desconocidas: ignorarlas puede facilitar compatibilidad, pero aceptar cambios arbitrarios de columnas puede abrir una asignación masiva no deseada. La decisión debe documentarse y probarse.

### Clientes, cookies y origen

Un navegador que llama al mismo origen puede enviar la cookie de sesión según sus reglas. Una aplicación externa necesita su propia estrategia de autenticación; copiar cookies personales en un script no constituye un diseño de integración. No expongas tokens de sesión en URLs ni los agregues a respuestas de depuración.

CORS regula qué respuestas puede leer código de otro origen en el navegador; no reemplaza autenticación ni impide todas las peticiones del mundo. Poner un comodín no corrige un login sin contrato. Antes de habilitar acceso entre orígenes identifica al cliente, qué credenciales usará y qué operaciones realmente necesita. La API educativa mantiene el mismo origen para reducir decisiones mientras aprendes el flujo.

### Manejo de errores que un cliente pueda usar

Una respuesta de error debe tener forma estable y no mezclar una página HTML completa con JSON. Un mensaje está pensado para personas; un código estable permite que un cliente decida sin depender de su redacción. El ejemplo de la primera versión muestra ese diseño. El proyecto usa status y message; si amplías códigos por campo, actualiza contrato y pruebas a la vez.

El [laboratorio JSON](../laboratorios/17-api/README.md) ofrece una lista de datos ficticios, búsqueda y un endpoint de validación sin persistencia. Observarás formato inválido, estructura incorrecta y dominio inválido por separado. El laboratorio es público solo sobre tu servidor local y no transporta información privada. Después contrástalo con la API autenticada del proyecto para reconocer qué responsabilidad añade el acceso.

## Ejemplo 1. Un contrato de lista

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$respuesta = ["data" => [["id" => 1, "titulo" => "PHP", "cupo" => 12]], "page" => 1];
echo json_encode($respuesta, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE) . "\n";
```

```sh
php unidad17-api/ejemplos/01.php
```

Salida esperada:

```text
{"data":[{"id":1,"titulo":"PHP","cupo":12}],"page":1}
```

data mantiene una lista incluso con un solo elemento. page describe la página solicitada.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | data se construye como una lista de registros. |
| 2 | page conserva el número de página independiente de la lista. |
| 3 | json_encode produce un cuerpo que el cliente puede decodificar sin interpretar HTML. |

## Ejemplo 2. Formato válido, estructura inválida

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$dato = json_decode("[1,2]", false, 512, JSON_THROW_ON_ERROR);
if (!$dato instanceof stdClass) {
    echo "422: se esperaba un objeto\n";
}
```

```sh
php unidad17-api/ejemplos/02.php
```

Salida esperada:

```text
422: se esperaba un objeto
```

Decodificar a objetos permite distinguir {} de []; después faltaría validar las propiedades.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | El documento [1,2] tiene sintaxis JSON válida. |
| 2 | La decodificación conserva una lista en lugar de stdClass. |
| 3 | El contrato exigía objeto y el control de estructura lo rechaza. |

## Ejemplo 3. Conservar listas después de filtrar

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

$talleres = [["id" => 1, "titulo" => "PHP", "cupo" => 12], ["id" => 2, "titulo" => "HTML", "cupo" => 8]];
$seleccion = array_filter($talleres, fn (array $taller): bool => $taller["cupo"] < 10);
$respuesta = ["data" => array_values($seleccion), "total" => count($seleccion)];
echo json_encode($respuesta, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE) . "\n";
```

Ejecuta desde cursos/php:

```sh
php unidad17-api/ejemplos/03.php
```

Resultado que debes obtener:

```text
{"data":[{"id":2,"titulo":"HTML","cupo":8}],"total":1}
```

### Lectura guiada y experimentos

array_filter conserva la clave original del taller seleccionado: queda una entrada con clave 1. array_values crea la lista consecutiva que json_encode representa entre corchetes. La función flecha recibe cada registro y devuelve si debe conservarse; no modifica los datos ni imprime dentro del filtro.

Quita array_values en una copia y compara la forma del cuerpo, no solo el título. Después usa un filtro que no acepte ningún elemento: data debe ser [] y total cero. Un cliente que recorre una colección puede tratar ambas respuestas con el mismo contrato sin preguntar cuántos resultados había para deducir su forma.

## Comprueba tu comprensión

1. Describe una respuesta 401 y otra 404.
2. Prueba un JSON mal formado y uno válido con estructura incorrecta.
3. Reto: genera un error JSON con un código estable y un mensaje para título ausente.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad16-autenticacion/README.md) · [Índice](../README.md) · [Siguiente](../unidad18-pruebas/README.md)
