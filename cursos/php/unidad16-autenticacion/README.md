# Unidad 16. Contraseñas, autenticación y permisos

[Anterior](../unidad15-composer/README.md) · [Índice](../README.md) · [Siguiente](../unidad17-api/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Verificar identidad sin almacenar contraseñas en texto plano.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Autenticar es comprobar quién accede; autorizar es decidir qué puede hacer. Una sesión existente no prueba por sí sola que tenga permiso administrativo. Nuestro proyecto protege las modificaciones y la API con una cuenta local administradora creada por un comando; no incluye registro público, recuperación de cuentas ni roles múltiples.

`password_hash($clave, PASSWORD_DEFAULT)` genera un hash con sal y parámetros incorporados. `password_verify` comprueba una contraseña frente a ese hash; no intentes descifrarlo. No uses MD5, SHA1 ni un hash rápido casero para contraseñas. `password_needs_rehash` permite actualizar el hash tras una verificación correcta si cambia la configuración. La columna debe admitir hashes suficientemente largos, por ejemplo TEXT en SQLite o VARCHAR(255) en otros motores.

Tras verificar, regenera el ID de sesión para reducir la fijación de sesión y guarda solo la identidad necesaria. Al salir elimina el estado autenticado y renueva el token. Responde con un mensaje genérico ante usuario o clave incorrectos. Antes de exponer un login a Internet hace falta además limitar intentos en un componente compartido, TLS y una política de recuperación. No confundas el ejemplo local con un servicio listo para aceptar cuentas públicas.

## Ejemplo 1. Verificar una clave

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$hash = password_hash("una-frase-larga-de-prueba", PASSWORD_DEFAULT);
echo password_verify("una-frase-larga-de-prueba", $hash) ? "Correcta\n" : "Incorrecta\n";
echo password_verify("otra", $hash) ? "Correcta\n" : "Incorrecta\n";
```

```sh
php unidad16-autenticacion/ejemplos/01.php
```

Salida esperada:

```text
Correcta
Incorrecta
```

El hash cambia entre ejecuciones por la sal. La verificación sí produce los mismos resultados.

## Ejemplo 2. Separar identidad y permiso

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$usuario = ["id" => 7, "rol" => "lector"];
$autenticado = isset($usuario["id"]);
$puedeEditar = $autenticado && $usuario["rol"] === "administrador";
echo $autenticado ? "Identidad conocida\n" : "Sin sesión\n";
echo $puedeEditar ? "Puede editar\n" : "403: sin permiso\n";
```

```sh
php unidad16-autenticacion/ejemplos/02.php
```

Salida esperada:

```text
Identidad conocida
403: sin permiso
```

Un lector tiene identidad conocida y carece del permiso administrativo.

## Comprueba tu comprensión

1. Verifica una clave correcta y una incorrecta.
2. Explica por qué no se debe comparar un hash nuevo con el hash guardado.
3. Reto: crea una función de autorización que deniegue por defecto si falta el rol.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad15-composer/README.md) · [Índice](../README.md) · [Siguiente](../unidad17-api/README.md)
