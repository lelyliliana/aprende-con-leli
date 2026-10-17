# Unidad 11. Sesiones, cookies y protección CSRF

[Anterior](../unidad10-formularios/README.md) · [Índice](../README.md) · [Siguiente](../unidad12-pdo/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Conservar estado entre peticiones y proteger las operaciones del formulario.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una cookie viaja entre navegador y servidor. Una sesión guarda datos en el servidor y utiliza normalmente una cookie con un identificador para recuperar ese estado. Llama a `session_start` antes de emitir HTML. No guardes contraseñas en cookies. Para una sesión autenticada configura HttpOnly, SameSite y Secure bajo HTTPS; al iniciar sesión regenera el identificador.

CSRF ocurre cuando otra página provoca una operación usando las credenciales que el navegador envía automáticamente. Un token aleatorio asociado a la sesión debe acompañar cada formulario que cambie datos. Créalo con `bin2hex(random_bytes(32))`, consérvalo en $_SESSION, envíalo en un campo hidden y compáralo con `hash_equals` después de comprobar que ambos valores son cadenas. Rechaza un token ausente o incorrecto con 403 antes de escribir. SameSite ayuda, pero no sustituye esta comprobación.

No hagas cambios por GET: un enlace, vista previa o robot podría activarlos. Un mensaje flash se guarda en sesión durante la redirección y se elimina al mostrarlo. Una sesión tampoco reemplaza la autorización: conocer un ID no implica permiso para editarlo. Los ejemplos siguientes modelan el estado con arreglos locales; el proyecto usa una sesión real y formularios con token.

## Ejemplo 1. Un mensaje de una sola lectura

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$sesion = [];
$sesion["flash"] = "Taller guardado";
$mensaje = $sesion["flash"] ?? "";
unset($sesion["flash"]);
echo $mensaje . "\n";
echo isset($sesion["flash"]) ? "Pendiente\n" : "Consumido\n";
```

```sh
php unidad11-sesiones/ejemplos/01.php
```

Salida esperada:

```text
Taller guardado
Consumido
```

Leer y borrar evita repetir el mensaje en cada petición.

## Ejemplo 2. Comparación de tokens

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$esperado = str_repeat("a", 64); // Solo para reproducir esta prueba.
$recibido = str_repeat("b", 64);
$valido = is_string($recibido) && hash_equals($esperado, $recibido);
echo $valido ? "Permitido\n" : "403: token inválido\n";
```

```sh
php unidad11-sesiones/ejemplos/02.php
```

Salida esperada:

```text
403: token inválido
```

Los valores fijos sirven para probar el rechazo; en la aplicación se generan con random_bytes.

## Comprueba tu comprensión

1. Dibuja dónde están la cookie, el ID y los datos de sesión.
2. Compara token correcto, incorrecto y ausente.
3. Reto: crea un token aleatorio y comprueba su longitud y su comparación con una copia.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad10-formularios/README.md) · [Índice](../README.md) · [Siguiente](../unidad12-pdo/README.md)
