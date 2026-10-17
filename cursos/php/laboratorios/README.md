# Laboratorios progresivos de PHP

[Volver al curso](../README.md)

Estos diez laboratorios conectan las lecciones con el proyecto. Cada uno delimita qué puedes observar, cómo ejecutarlo y qué evidencia entregar. No es necesario abrir la aplicación final para practicar la primera petición. Usa únicamente datos ficticios y ejecuta los servidores sobre 127.0.0.1.

Todos los comandos parten de cursos/php. En los laboratorios web abre una terminal para el servidor, conserva esa terminal abierta y utiliza el navegador o una segunda terminal para las peticiones. Detén con Ctrl+C antes de usar el mismo puerto en otro laboratorio. No abras los .php directamente desde el explorador.

| Después de | Laboratorio | Qué debes demostrar |
|---|---|---|
| Unidad 9 | [HTTP y HTML](09-http/README.md) | Consulta GET, contenido escapado, estado y método |
| Unidad 10 | [Formulario sin persistencia](10-formularios/README.md) | Validación real, campos conservados y 422 |
| Unidad 11 | [Nota de sesión](11-sesiones/README.md) | Cookie, continuidad, flash, redirección y CSRF |
| Unidad 12 | [SQL relacional](12-sql/README.md) | JOIN, agregación, clave foránea y rollback |
| Unidad 13 | [CRUD en sesión](13-crud/README.md) | IDs estables, transiciones, filtro y paginación |
| Unidad 15 | [Autoload entre archivos](15-autoload/README.md) | Namespace, resolución y carga por demanda |
| Unidad 16 | [Acceso del proyecto](16-acceso/README.md) | Login, cambio de sesión, aislamiento y salida |
| Unidad 17 | [Contrato JSON](17-api/README.md) | Método, formato, estructura y dominio |
| Unidad 18 | [Prueba que detecta un defecto](18-pruebas/README.md) | Caso de frontera y código de salida no cero |
| Unidad 20 | [Entrega y restauración](20-entrega/README.md) | Otra instalación, copia coherente y recuperación |

## Qué comparar entre laboratorios

El formulario no guarda, la nota guarda estado de una sesión y el CRUD utiliza una colección de esa sesión. Ninguno de esos tres es la base SQLite del proyecto. SQL se practica primero por CLI y después se integra con acceso administrativo en la aplicación completa. La separación permite atribuir cada resultado a su mecanismo: no es lo mismo cerrar una pestaña que eliminar una fila de la base.

Los ejemplos cortos de las unidades se comprueban como programas CLI con salida esperada. Los laboratorios web se comprueban mediante peticiones HTTP reales y cookies aisladas. Las pruebas automáticas no sustituyen tus experimentos: intenta predecir un resultado y explica por qué ocurrió antes de consultar la solución del taller.

## Verificar las aplicaciones de práctica

```sh
python3 scripts/verificar_laboratorios.py
```

En Windows puedes usar `py scripts/verificar_laboratorios.py`. El comando crea servidores solo locales, directorios temporales y sesiones de prueba. No utiliza ni modifica tu base de estudio. Las aplicaciones se prueban una a una y cada servidor se detiene al terminar. Las pruebas del proyecto final siguen en scripts/verificar_http.py.
