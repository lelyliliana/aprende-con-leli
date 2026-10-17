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

## Comprueba tu comprensión

1. Describe una respuesta 401 y otra 404.
2. Prueba un JSON mal formado y uno válido con estructura incorrecta.
3. Reto: genera un error JSON con un código estable y un mensaje para título ausente.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad16-autenticacion/README.md) · [Índice](../README.md) · [Siguiente](../unidad18-pruebas/README.md)
