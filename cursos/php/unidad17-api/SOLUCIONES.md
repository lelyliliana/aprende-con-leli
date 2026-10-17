# Soluciones 17. APIs JSON y contratos HTTP

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

401 comunica que falta una identidad válida; 404 que no se encontró el recurso solicitado. Un JSON mal formado lanza JsonException; una lista JSON válida se decodifica, pero incumple un contrato que exige objeto. Formato y estructura deben probarse por separado.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

$error = ["error" => ["code" => "titulo_requerido", "message" => "Escribe el título del taller"]];
echo json_encode($error, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE) . "\n";
```

Desde cursos/php:

```sh
php unidad17-api/soluciones/reto.php
```

Un cliente puede usar code sin depender de la redacción del mensaje. En HTTP debes asignar el estado correspondiente antes de emitir el cuerpo.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.

## Solución razonada del taller de profundización

El laboratorio separa el endpoint GET de lista del POST de validación sin escritura. JSON mal formado produce 400; un documento válido con estructura o dominio incorrectos produce 422 según ese contrato. El primer error es de formato, el segundo de esquema y el tercero de regla de negocio.

array_values recupera claves consecutivas después de filtrar. La interfaz muestra un estado vacío solo si la lectura 200 entrega una colección vacía; ante 401 ofrece iniciar sesión y ante 500 informa que no pudo consultar y permite reintentar. Presentar los tres como «no hay talleres» ocultaría tanto un problema de acceso como una indisponibilidad real.

[Volver al tercer ejemplo](ejemplos/03.php). Compara tus decisiones con las reglas descritas, sin exigir que los nombres de las variables sean iguales.
