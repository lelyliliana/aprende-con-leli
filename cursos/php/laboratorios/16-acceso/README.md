# Laboratorio 16. Verificar el acceso sobre el proyecto real

[Lección](../../unidad16-autenticacion/README.md) · [Laboratorios](../README.md) · [Instalación del proyecto](../../proyecto/README.md)

## Objetivo y aislamiento

Aquí no agregamos otro login parecido: estudiamos el que realmente utiliza la aplicación final. Crearás una base de práctica distinta para observar éxito, rechazo, renovación de sesión y cierre. Todo continúa en tu computador, con datos ficticios. No expongas el servidor integrado a otras máquinas.

Desde cursos/php, configura una ruta nueva bajo proyecto/var. Linux/macOS:

```sh
export APP_DB="$PWD/proyecto/var/acceso-practica.sqlite"
```

PowerShell:

```powershell
$env:APP_DB = Join-Path (Get-Location).Path "proyecto/var/acceso-practica.sqlite"
```

Si ya hiciste el ejercicio, elige otro nombre para comenzar desde una base nueva. Inicializar no borra datos anteriores. Mantén la misma terminal para los siguientes comandos:

```sh
php proyecto/bin/inicializar.php
php proyecto/bin/crear_usuario.php docente
php -S 127.0.0.1:8016 -t proyecto/public
```

La creación solicita una frase exclusiva de práctica, con los límites explicados en el proyecto. No uses claves personales. Abre http://127.0.0.1:8016/ y conserva el registro de Red.

## Recorrido de identidad

Antes de entrar solicita /api/talleres: debe devolver 401. Intenta una contraseña incorrecta: también debes observar un rechazo sin saber por el mensaje si el nombre existe. Después usa la cuenta válida: el servidor verifica el hash, renueva el ID y redirige al listado.

En las herramientas de cookies comprueba que cambió el identificador entre antes y después. No publiques sus valores. La evidencia es que hubo renovación, no copiar el secreto en la bitácora. Revisa el código que asigna usuario_id y explica por qué no conserva la contraseña original en la sesión.

## Aislamiento y autorización

Crea un taller y consulta la API desde esa sesión. Luego usa un perfil separado e intenta la misma URL: debe obtener 401. El dato en disco es el mismo, pero la identidad no está compartida. Esta diferencia contrasta con el laboratorio CRUD de sesión, donde cada perfil tenía también su colección independiente.

Conserva una pantalla antigua abierta, cierra sesión desde otra pestaña y vuelve a solicitar la API o enviar una operación. Debe rechazarse la petición nueva aunque la pantalla vieja todavía exista en memoria del navegador. El servidor comprueba cada operación; esconder botones no implementa el permiso.

## Entrega y límites

Entrega una tabla de seis observaciones: acceso anónimo, clave incorrecta, éxito, ID renovado, otro perfil y salida. Relaciona cada una con el archivo del proyecto que la resuelve. Explica por separado qué pruebas corresponden a autenticación y cuáles al token CSRF.

Cuando termines, detén con Ctrl+C. Para volver a la base local predeterminada, en Linux/macOS usa `unset APP_DB`; en PowerShell `Remove-Item Env:APP_DB`. La base de práctica puede conservarse como evidencia local y está ignorada por Git.

Este acceso no tiene registro público, recuperación ni limitador compartido de intentos. Las pruebas demuestran el alcance local descrito, no que ya puedas ofrecer cuentas a estudiantes en Internet. La unidad de despliegue explica las decisiones adicionales.
