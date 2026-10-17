# Unidad 08. Errores, excepciones y depuración

[Anterior](../unidad07-archivos/README.md) · [Índice](../README.md) · [Siguiente](../unidad09-web/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Distinguir errores de sintaxis, fallos esperados y errores de programación.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Un error de sintaxis impide interpretar el archivo: compruébalo con `php -l archivo.php`. Un resultado incorrecto requiere inspeccionar el estado y la lógica, aunque no aparezca un mensaje. `var_dump` y una traza pequeña ayudan durante el desarrollo. Lee el tipo de error, archivo y línea; reduce el caso antes de cambiar muchas cosas.

Una excepción comunica que una operación no pudo cumplir su contrato. `throw new InvalidArgumentException` expresa una entrada no admitida; `try` delimita una operación y `catch` decide cómo responder. `finally` se ejecuta para liberar un recurso incluso cuando hay una excepción. Captura el tipo concreto que sabes resolver y no conviertas todos los fallos en un mensaje de éxito.

En desarrollo activa los errores para investigarlos. En una aplicación publicada no muestres trazas, rutas ni credenciales: registra el detalle en el servidor y responde con un mensaje general. Las advertencias de funciones tradicionales no se convierten automáticamente en excepciones. Sigue comprobando retornos false cuando el contrato lo indique. En las pruebas una condición incumplida debe producir salida distinta de cero.

## Investigar sin adivinar ni ocultar el fallo

Un error necesita una reproducción mínima: la entrada, la operación y la diferencia entre resultado esperado y obtenido. Antes de editar, clasifica lo que observas. Un error de sintaxis impide analizar el archivo; una excepción interrumpe una operación en ejecución; una advertencia puede permitir continuar con un resultado no utilizable; un error de lógica puede no producir mensajes. Cada clase requiere una evidencia diferente.

Si el intérprete informa una línea, lee también la instrucción que la precede. Un paréntesis abierto puede descubrirse bastante después del lugar donde faltaba cerrarlo. Si el resultado es numérico pero incorrecto, una traza con tres entradas pequeñas suele aportar más que cambiar operadores al azar. La depuración consiste en reducir incertidumbre y comprobar hipótesis, no en acumular cambios hasta que desaparezca un síntoma.

### Excepciones como contratos incumplidos

Una función que promete devolver un taller no debería devolver silenciosamente un registro vacío cuando no puede construirlo. Puede utilizar una excepción si la entrada incumple su contrato, o un retorno nullable cuando «no encontrado» es un resultado normal previsto. Elegir entre ambos depende de la operación. Buscar un ID inexistente en un repositorio puede devolver null; intentar operar sobre un cupo negativo puede lanzar InvalidArgumentException.

La excepción contiene un tipo y un mensaje; una traza añade el recorrido de llamadas. Capturar el tipo que sabes resolver evita presentar como problema de usuario un fallo de programación. Un catch de Throwable en la frontera HTTP puede generar un 500 general y registrar el detalle, pero no debe anunciar que el guardado ocurrió. Resolver un error no significa suprimir toda señal de que sucedió.

### Propagar hasta el lugar que puede decidir

Imagina un controlador que llama a un servicio y este al repositorio. El repositorio sabe ejecutar SQL, pero no si debe responder HTML o JSON. Puede dejar propagar un fallo de conexión hacia la frontera que conoce HTTP. La validación de cupo, en cambio, puede devolver errores de campo para que el formulario se corrija. La política de presentación pertenece a una capa distinta del mecanismo que detectó el fallo.

Evita capturar y relanzar la misma excepción en cada función sin añadir contexto útil. También evita guardar información sensible en mensajes que pueden terminar expuestos: rutas internas, consultas con datos y credenciales no pertenecen a una página de error pública. Para investigar, correlaciona una operación con un registro del servidor y conserva únicamente los detalles necesarios.

### finally y limpieza de recursos

finally se ejecuta al salir del bloque protegido en sus recorridos normales y de excepción. Es apropiado para cerrar un recurso o eliminar un temporal. No lo uses para devolver un valor que oculte una excepción pendiente: un return dentro de finally puede sustituir el flujo que intentabas conservar. Mantén la limpieza separada del resultado de negocio.

Cuando una transacción falla, comprueba si sigue activa antes de revertir. Una operación que no llegó a iniciar transacción no debe producir un segundo fallo al intentar revertirla. La misma idea se aplica a un recurso que no pudo abrirse: no intentes cerrarlo como si siempre existiera. El manejo de errores también tiene un contrato y merece casos negativos.

### Construir un registro de investigación

Para cada fallo guarda una hipótesis y una comprobación que pueda desmentirla. «El total es incorrecto porque cantidad se reinicia» se comprueba mostrando cantidad antes y dentro del ciclo. Si no se reinicia, la evidencia obliga a buscar otra causa. No atribuyas un resultado al entorno sin comprobar el programa con una entrada mínima y versiones conocidas.

Después de corregir, convierte la entrada que descubrió el problema en un caso de prueba. Así la solución no depende de que recuerdes manualmente repetirla. Un programa pequeño que falla de manera clara puede ser una mejor evidencia que una pantalla extensa que solo muestra el caso feliz.

## Ejemplo 1. Rechazar cantidades imposibles

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

function subtotal(int $precio, int $cantidad): int {
    if ($precio < 0 || $cantidad < 0) { throw new InvalidArgumentException("No se aceptan negativos"); }
    return $precio * $cantidad;
}
try { echo subtotal(2500, -1); }
catch (InvalidArgumentException $error) { echo $error->getMessage() . "\n"; }
```

```sh
php unidad08-errores/ejemplos/01.php
```

Salida esperada:

```text
No se aceptan negativos
```

La excepción evita continuar con un subtotal que carece de sentido.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | subtotal detecta una cantidad negativa antes de multiplicar. |
| 2 | throw interrumpe la llamada y llega al catch específico. |
| 3 | El mensaje se imprime sin presentar un total inventado. |

## Ejemplo 2. Capturar un formato inválido

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

try {
    json_decode("{mal}", true, 512, JSON_THROW_ON_ERROR);
} catch (JsonException $error) {
    echo "JSON inválido\n";
} finally {
    echo "Operación terminada\n";
}
```

```sh
php unidad08-errores/ejemplos/02.php
```

Salida esperada:

```text
JSON inválido
Operación terminada
```

catch resuelve el error de formato. finally se ejecuta después del manejo.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | El texto no cumple la sintaxis JSON. |
| 2 | JSON_THROW_ON_ERROR produce una JsonException. |
| 3 | catch muestra el rechazo y finally ejecuta el cierre del recorrido. |

## Ejemplo 3. Propagar y limpiar sin anunciar éxito

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

function leerConfiguracion(string $texto): array {
    $datos = json_decode($texto, true, 512, JSON_THROW_ON_ERROR);
    if (!is_array($datos)) { throw new InvalidArgumentException("La configuración debe ser un arreglo"); }
    return $datos;
}
try {
    leerConfiguracion("null");
    echo "Configuración cargada\n";
} catch (InvalidArgumentException $e) {
    echo "Rechazada: " . $e->getMessage() . "\n";
} finally {
    echo "Recurso de práctica liberado\n";
}
```

Ejecuta desde cursos/php:

```sh
php unidad08-errores/ejemplos/03.php
```

Resultado que debes obtener:

```text
Rechazada: La configuración debe ser un arreglo
Recurso de práctica liberado
```

### Lectura guiada y experimentos

El JSON null es válido, de modo que json_decode no lanza un error de sintaxis. La función detecta después que no puede cumplir el contrato de arreglo y lanza InvalidArgumentException. El echo de éxito no se alcanza. catch presenta el rechazo y finally demuestra el punto donde realizaríamos la limpieza; el ejemplo no abre un recurso real.

Prueba con []: ahora se alcanza el mensaje de configuración cargada y también finally. Prueba con {mal}: se lanza JsonException, que este catch deliberadamente no resuelve. En una copia agrega un catch específico y un mensaje distinto para mostrar que formato y estructura son fallos diferentes. No uses el mismo mensaje de éxito para las tres entradas.

## Comprueba tu comprensión

1. Introduce un error de sintaxis en una copia y usa php -l.
2. Prueba subtotal con cero y con un negativo.
3. Reto: crea una función para dividir que rechace divisor cero.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad07-archivos/README.md) · [Índice](../README.md) · [Siguiente](../unidad09-web/README.md)
