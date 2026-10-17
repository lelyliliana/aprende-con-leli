# Laboratorio 17. Observar un contrato JSON completo

[Lección](../../unidad17-api/README.md) · [Laboratorios](../README.md) · [Código](public/index.php)

## Alcance y arranque

La API utiliza dos talleres ficticios fijos. GET /talleres lista y filtra; POST /validar comprueba una propuesta sin guardarla. No hay cuenta, datos privados ni escritura de estado. El proyecto final mantiene una API de lectura autenticada; este laboratorio aísla formato y validación.

```sh
php -S 127.0.0.1:8017 -t laboratorios/17-api/public
```

Abre http://127.0.0.1:8017/talleres en el navegador. Debes recibir data con PHP y HTML y total 2. La consulta ?q=html conserva una lista con una fila; una búsqueda sin coincidencias devuelve una lista vacía y 200.

## Contrato de validación

El cuerpo debe ser un objeto JSON con titulo textual y cupo entero, por ejemplo `{"titulo":"PHP inicial","cupo":12}`. A diferencia de un formulario, el cupo es un número JSON; la frontera comprueba ese tipo y después lo adapta para reutilizar la regla de título y rango. La respuesta correcta tiene data normalizada y persistido:false. No devuelve 201 porque no creó un recurso.

El endpoint exige Content-Type application/json y admite hasta 4096 bytes de cuerpo. El límite enseña que formato correcto no significa tamaño ilimitado. La profundidad máxima de decodificación es parte de esta aplicación pequeña; un rechazo de formato no debe terminar como una traza interna.

Con curl desde otra terminal:

```sh
curl -i -H "Content-Type: application/json" --data '{"titulo":"PHP inicial","cupo":12}' http://127.0.0.1:8017/validar
```

En PowerShell utiliza curl.exe y, si el escapado de comillas de tu versión dificulta el comando, guarda el JSON en un archivo de práctica y utiliza --data-binary con @archivo.json. También puedes ejecutar scripts/verificar_laboratorios.py, que envía los mismos cuerpos sin depender del escapado del shell.

## Matriz de experimentos

| Petición | Estado | Código o resultado |
|---|---:|---|
| GET /talleres | 200 | Lista de dos filas |
| GET /talleres?q=inexistente | 200 | data vacía |
| POST /talleres | 405 | metodo_no_permitido; Allow: GET |
| POST /validar con tipo de contenido distinto | 415 | se_requiere_json |
| Cuerpo {mal} como JSON | 400 | json_mal_formado |
| Cuerpo [] | 422 | estructura_invalida |
| Objeto con cupo "12" como cadena | 422 | estructura_invalida |
| Objeto con cupo 0 entero | 422 | datos_invalidos |
| Objeto válido | 200 | Datos normalizados; persistido false |
| Cuerpo mayor que el límite | 413 | cuerpo_demasiado_grande |

En cada caso verifica estado, tipo de contenido y forma del cuerpo. El error de esquema y el de rango pueden compartir el estado 422 y conservar códigos distintos para que el cliente identifique qué contrato falló. La búsqueda utiliza texto literal y no ejecuta SQL porque los datos están en memoria.

## Taller

Añade un parámetro max_cupo opcional al listado. Define tipo y rango, filtra antes de contar y conserva data como lista consecutiva. Diseña una entrada válida, una sin coincidencias, una decimal y una como arreglo. No conviertas cualquier cadena a entero antes de comprobarla.

Entrega un contrato actualizado y las cuatro respuestas. Si después integras el filtro en el proyecto SQLite, adapta el repositorio con parámetros y conserva la comprobación de identidad. Copiar solo el endpoint de este laboratorio eliminaría un requisito importante del proyecto: su acceso autenticado.
