# Soluciones 16. Contraseñas, autenticación y permisos

[Lección](README.md) · [Práctica](PRACTICA.md)

## Ejemplos y cambios propuestos

Consulta las salidas en [ejemplo 1](ejemplos/01.txt) y [ejemplo 2](ejemplos/02.txt). Sigue las variables instrucción por instrucción para justificar cada línea.

## Respuestas a los dos primeros pasos

password_verify devuelve true para la clave original y false para otra. Dos llamadas a password_hash con la misma clave normalmente producen hashes distintos por la sal aleatoria. Por eso no se comparan hashes nuevos: se verifica contra el hash guardado.

## Reto resuelto

[Programa ejecutable](soluciones/reto.php)

```php
<?php
declare(strict_types=1);

function puedeAdministrar(array $usuario): bool {
    return isset($usuario["id"]) && ($usuario["rol"] ?? null) === "administrador";
}
echo puedeAdministrar(["id" => 1]) ? "Permitido\n" : "Denegado\n";
```

Desde cursos/php:

```sh
php unidad16-autenticacion/soluciones/reto.php
```

Falta un rol autorizado, por eso se deniega. No deduzcas el permiso de un campo enviado por el navegador: debe proceder del estado confiable del servidor.

## Revisión

Contrasta el resultado con el contrato y ejecuta también el caso límite que propusiste. No basta con que el programa termine: debes explicar por qué su resultado satisface las reglas.
