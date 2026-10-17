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

## Separar credenciales, identidad y permisos

La credencial permite demostrar una identidad mediante una verificación. La identidad resultante se conserva en la sesión y los permisos deciden qué acciones se admiten. Un formulario con nombre y contraseña cubre solo el primer momento. Si una ruta acepta escrituras porque aparece un campo usuario_id enviado por el navegador, no ha comprobado una identidad confiable: cualquier cliente puede cambiar ese valor.

El proyecto crea las cuentas desde CLI y asigna a todas el mismo permiso administrativo. No implementa registro público ni perfiles de estudiantes. Esa restricción permite aprender el ciclo completo sin fingir que ya existe una política de cuentas compleja. Cuando diseñes roles, debes definir permisos por operación y recurso, no confiar en que quien conoce la URL debería poder utilizarla.

### Hash de contraseña y sal incorporada

password_hash almacena una derivación de la clave con algoritmo, parámetros y sal en la representación que devuelve. La sal evita que dos cuentas con la misma clave tengan que compartir el mismo hash; no se trata de un secreto adicional que debas esconder en otra tabla para que password_verify funcione. La verificación recibe la clave candidata y el hash guardado y realiza la comparación apropiada.

El hash no permite recuperar la contraseña para enviarla de nuevo a la persona. Una recuperación real crea otro proceso de autorización para establecer una nueva clave, normalmente con tokens limitados y caducidad. El proyecto no lo incluye. No reemplaces ese proceso enviando por correo una clave original que nunca debiste conservar en texto.

### Límites de entrada y cambios de algoritmo

El límite de longitud debe tener en cuenta el algoritmo elegido. Con bcrypt existe un límite relevante en bytes; el ejemplo de creación de cuenta usa un máximo de 72 bytes para no aceptar claves distintas que se vuelvan equivalentes por truncamiento. La cantidad de caracteres UTF-8 puede ser menor que los bytes. No deduzcas que «72 caracteres» significa lo mismo para todos los textos.

PASSWORD_DEFAULT permite que la recomendación cambie en versiones futuras; no prometas un algoritmo fijo sin comprobar el entorno. password_needs_rehash detecta cuándo el hash guardado ya no coincide con la política actual. Después de una verificación correcta puedes producir otro hash y actualizarlo. No intentes transformar un hash antiguo en uno nuevo sin conocer la clave válida que acaba de verificarse.

### Flujo de acceso y salida

El login valida tipos, consulta la cuenta con parámetros y verifica la clave. Un mensaje genérico evita diferenciar en pantalla si falló el nombre o la contraseña. La aplicación no debe emitir sus detalles internos en un rechazo. Tras el éxito renueva el ID y guarda la identidad mínima necesaria, por ejemplo el ID de usuario. Cada petición protegida puede comprobar que la cuenta sigue existiendo.

Al salir se elimina la identidad y se renueva el estado necesario. Volver atrás en el navegador puede mostrar una pantalla conservada, pero cualquier nueva operación protegida debe rechazarse. Cache-Control no-store reduce almacenamiento de respuestas sensibles; no sustituye la autorización del servidor. La evidencia del cierre de sesión es una nueva petición denegada, no solo que desaparezca el nombre de la cabecera.

### Fuerza bruta y alcance local

Un formulario que verifica claves correctamente puede seguir admitiendo intentos ilimitados. Antes de exponerlo a Internet necesitas una política de límites que funcione para todas las instancias, registro de eventos y recuperación. Una variable de sesión por navegador no detiene a alguien que cambie cookies o distribuya peticiones. La primera versión local declara esa limitación para que no se confunda con una cuenta pública lista para operar.

El [laboratorio de acceso](../laboratorios/16-acceso/README.md) utiliza el proyecto real con una base temporal elegida por ti. Comprobarás credenciales correctas e incorrectas, renovación del ID, aislamiento de otra sesión y rechazo tras salir. No copies valores de cookies o contraseñas en tu bitácora; registra las propiedades y resultados que demuestran el mecanismo.

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | password_hash produce una representación con sal. |
| 2 | La primera verificación recibe la misma clave y resulta verdadera. |
| 3 | La segunda recibe otra clave y resulta falsa, aunque el hash no cambió. |

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

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La identidad existe porque el arreglo tiene un ID. |
| 2 | El rol lector no coincide con administrador. |
| 3 | La decisión de editar se deniega aunque la identidad sea conocida. |

## Ejemplo 3. Denegar por defecto un permiso desconocido

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

function permite(?array $usuario, string $accion): bool {
    if ($usuario === null) { return false; }
    $permisos = ["lector" => ["leer"], "administrador" => ["leer", "crear", "editar", "eliminar"]];
    $rol = $usuario["rol"] ?? null;
    if (!is_string($rol)) { return false; }
    return in_array($accion, $permisos[$rol] ?? [], true);
}
echo permite(null, "leer") ? "Permitido\n" : "Denegado\n";
echo permite(["rol" => "lector"], "editar") ? "Permitido\n" : "Denegado\n";
echo permite(["rol" => "administrador"], "editar") ? "Permitido\n" : "Denegado\n";
echo permite(["rol" => "desconocido"], "leer") ? "Permitido\n" : "Denegado\n";
```

Ejecuta desde cursos/php:

```sh
php unidad16-autenticacion/ejemplos/03.php
```

Resultado que debes obtener:

```text
Denegado
Denegado
Permitido
Denegado
```

### Lectura guiada y experimentos

La función recibe una identidad ya obtenida de un origen confiable; no lee el rol del formulario. La matriz enumera acciones permitidas y utiliza una lista vacía ante un rol desconocido. De ese modo un dato nuevo o incompleto no amplía acceso por accidente. La lectura anónima también se deniega según este contrato concreto.

Esta es una demostración de autorización por rol; no añade roles al proyecto actual ni comprueba propiedad de recursos. Si cada docente solo pudiera editar sus talleres, haría falta además comparar la relación entre identidad y taller. Agrega esa condición en tu diseño antes de afirmar que el rol administrador resuelve todos los permisos posibles.

## Comprueba tu comprensión

1. Verifica una clave correcta y una incorrecta.
2. Explica por qué no se debe comparar un hash nuevo con el hash guardado.
3. Reto: crea una función de autorización que deniegue por defecto si falta el rol.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad15-composer/README.md) · [Índice](../README.md) · [Siguiente](../unidad17-api/README.md)
