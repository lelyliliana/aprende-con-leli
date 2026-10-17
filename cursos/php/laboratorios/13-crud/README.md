# Laboratorio 13. Un CRUD pequeño antes del proyecto completo

[Lección](../../unidad13-crud/README.md) · [Laboratorios](../README.md) · [Controlador](public/index.php)

## Alcance

Practica crear, listar, editar y eliminar con una colección de sesión. No hay cuentas ni base SQLite: es un puente para observar IDs, acciones, validación y redirecciones sin aprender todas las capas al mismo tiempo. Los datos pertenecen a tu sesión y pueden perderse al caducar. Usa solo talleres ficticios sobre el servidor local.

```sh
php -S 127.0.0.1:8013 -t laboratorios/13-crud/public
```

Abre http://127.0.0.1:8013/. Crea PHP inicial con cupo 12 y HTML con cupo 8. Observa los enlaces de edición: cada uno conserva un ID numérico. El siguiente ID no se obtiene de count; tiene un contador independiente para no reutilizarlo al borrar una entrada.

## Construir el modelo de estado

La sesión contiene csrf, talleres y siguiente_id. La colección usa los IDs como claves y guarda también id dentro de cada registro. Esta duplicación pequeña permite recorrer registros y construir enlaces sin deducir identidad desde su posición. krsort mantiene IDs descendentes y array_slice limita la página sin cambiar el contrato de cada fila.

El filtro se compara con texto normalizado mediante mb_strtolower. Este laboratorio utiliza una búsqueda Unicode en memoria; el repositorio SQLite del proyecto declara comparación ASCII básica. Una misma etiqueta Buscar no garantiza que dos implementaciones tengan exactamente la misma semántica. Documentar esa diferencia evita prometer un resultado que el SQL no implementa.

## Recorrer cambios y rechazos

Al crear, el programa exige POST, token válido y datos válidos; luego asigna un ID y redirige. Al editar o eliminar, exige además ID positivo y fila existente. La consulta GET con editar solo carga el formulario; no cambia el taller. El POST de edición realiza la modificación.

Edita el primer taller y conserva el segundo sin cambios. Después abre Eliminar y cancela cerrando el detalle: no debe desaparecer nada. Finalmente confirma el POST y comprueba que solo desaparece ese ID. Una confirmación visual no reemplaza el token ni la búsqueda del registro en el servidor.

## Paginación y estado vacío

Crea doce talleres distintos. La primera página debe contener diez y la segunda dos. Conserva el filtro al navegar; al realizar otra búsqueda desde el formulario se omite page y se comienza en uno. Borra registros de una página alta hasta vaciarla y reconoce el mensaje de conjunto vacío. Esa pantalla no significa que se borraron todos los talleres de otras páginas.

Prueba un filtro sin coincidencias y otro con el signo %. Ambos se tratan como texto literal. La consulta q[]=PHP debe devolver 400 sin romper el programa. Una petición POST con cupo cero debe devolver 422 y mantener el título para corregirlo.

## Taller de comparación con SQL

Escribe qué métodos necesitaría un repositorio para sustituir la colección: crear, buscar, listar, contar, actualizar y eliminar. Relaciona cada bloque de sesión con la operación SQL que estudiaste en la unidad 12. No empieces cambiando el HTML: primero define el contrato de cada función.

El proyecto final ya tiene ese repositorio y añade autenticación, pero ahora podrás explicar qué responsabilidad aporta cada componente. Entrega doce IDs sin duplicados entre páginas, una edición, un rechazo que no cambie estado y una eliminación confirmada. Comprueba también que un perfil separado comienza con una colección propia.
