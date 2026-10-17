# Construye el gestor de talleres por etapas

[Curso](../README.md) · [Referencia ejecutable](README.md) · [Rúbrica](RUBRICA.md)

Tu objetivo es resolver una necesidad y poder explicar el código. Antes de mirar la implementación, crea una carpeta de trabajo propia fuera de public. No sirvas archivos de prácticas con claves o bases. Todos los comandos de esta guía se ejecutan desde cursos/php.

## Problema y criterios de aceptación

Leli necesita organizar talleres con un título y una capacidad. La persona administradora puede crear, buscar, editar y eliminar talleres; una sesión anónima ve únicamente el acceso. No se guardan estudiantes.

1. Un título normalizado debe tener entre 3 y 100 caracteres UTF-8.
2. El cupo es un entero entre 1 y 100, ambos inclusive.
3. Los cambios persisten al reiniciar el servidor.
4. Una entrada inválida explica qué corregir y conserva el texto ingresado.
5. Nadie sin sesión administrativa puede consultar la API ni modificar datos.
6. Toda operación por formulario que cambia estado exige token CSRF.
7. El listado pagina de diez en diez y la búsqueda trata el filtro como texto literal.

## Etapa 1. Datos y reglas (después de la unidad 8)

**Entrega:** un programa de consola que recibe un arreglo de título y cupo, devuelve datos normalizados o errores por campo y demuestra cinco rechazos.

1. Escribe ejemplos de taller válido e inválido en papel. Decide cómo representar ausente, vacío y un arreglo donde esperabas texto.
2. Implementa validarTaller sin imprimir ni leer $_POST. Devuelve dos claves: datos y errores.
3. Comprueba is_string antes de trim o filter_var. Usa mb_strlen para el título y comparación estricta con false para el cupo.
4. Prueba títulos con espacios, 2, 3, 100 y 101 caracteres; cupos 0, 1, 100, 101, decimal, texto y arreglo.
5. Conserva una evidencia por caso con entrada, esperado y obtenido.

**Para contrastar:** [validacion.php](src/validacion.php). Observa que una función no necesita saber si la entrada viene de CLI o HTTP.

**Pregunta de salida:** ¿por qué convertir directamente "abc" a int puede ocultar un error? Debes distinguir conversión de validación.

## Etapa 2. Persistencia y CRUD (después de la unidad 15)

**Entrega:** esquema SQL y operaciones crear, buscar por ID, listar, editar y eliminar, primero desde un programa de consola.

1. Diseña talleres con ID estable, título NOT NULL y cupo con CHECK. Dibuja tres filas y explica qué dato identifica cada una.
2. Crea la base mediante un comando independiente. No crees un botón web que borre toda la información.
3. Construye TallerRepository con PDO recibido en el constructor. Las funciones SQL no deben leer $_POST ni generar HTML.
4. Prepara las sentencias para todos los valores variables. Inserta un título con comilla y busca un texto parecido a SQL; ninguno debe cambiar la estructura de la consulta.
5. Agrega ORDER BY id DESC, LIMIT 10 y un OFFSET controlado. Genera doce talleres y comprueba que las dos páginas no repiten IDs.
6. Cierra y vuelve a abrir una conexión a la base en archivo para demostrar persistencia. Usa memoria solo para pruebas aisladas.

**Para contrastar:** [schema.sql](schema.sql), [repositorio](src/TallerRepository.php) e [inicializador](bin/inicializar.php).

**Pregunta de salida:** ¿por qué la posición en una tabla HTML no sirve como identificador al editar después de ordenar?

## Etapa 3. Formularios y acceso (después de la unidad 17)

**Entrega:** interfaz accesible por navegador con login, formulario de taller, errores, listado, edición, eliminación confirmada y cierre de sesión.

1. Dibuja las pantallas antes de escribir HTML. Usa label asociado a cada campo y un botón con acción clara.
2. Crea la cuenta desde CLI con password_hash. Comprueba password_verify en el login y regenera el ID tras entrar.
3. Configura sesión y cookie antes de cualquier salida. Mantén la base y el código privado fuera de public.
4. Crea un token por sesión con random_bytes y exige su comparación con hash_equals en cada POST, incluido el acceso y cierre de sesión.
5. Procesa primero método, token, identidad y acción. Las operaciones de editar y borrar deben comprobar el ID y la existencia de la fila.
6. Ejecuta validarTaller. Si falla devuelve 422 y conserva los campos escapados; si funciona modifica la base, guarda un flash y redirige con 303.
7. Muestra el título escapado incluso si contiene <script>. Un texto que se almacena correctamente aún debe escaparse al presentarlo.
8. Implementa /api/talleres como lectura autenticada. Define método, campos y estados antes de programar.

**Para contrastar:** [index.php](public/index.php), [creación de cuenta](bin/crear_usuario.php) y [contrato API](API.md).

**Pregunta de salida:** ¿qué cambia entre una petición sin sesión, una con sesión pero token incorrecto y una con datos inválidos? Explica 401, 403 y 422.

## Etapa 4. Comprobación y entrega (después de la unidad 21)

**Entrega:** proyecto reproducible, pruebas, bitácora y explicación de cinco minutos del flujo completo.

1. Ejecuta los tres verificadores descritos en README.md. Lee un fallo real o provoca uno en una copia para comprobar que el verificador falla.
2. Sigue el recorrido manual de abajo. Agrega un caso propio que no esté en la lista.
3. Copia el proyecto en una carpeta nueva, inicializa otra base y crea otra cuenta. Confirma que las instrucciones bastan sin archivos ocultos de tu equipo.
4. Evalúa RUBRICA.md. Vincula cada criterio con un archivo, salida o captura y explica un límite sin prometer una función inexistente.
5. Diseña una sola ampliación. Escribe qué cambia en los contratos y tres pruebas antes de empezar.

## Recorrido manual reproducible

| Acción | Resultado esperado |
|---|---|
| Abrir la raíz sin sesión | Formulario de acceso; no muestra talleres |
| Consultar /api/talleres sin sesión | 401 con error JSON |
| Acceder con clave incorrecta | 401 y mensaje genérico |
| Crear PHP inicial, cupo 12 | Redirección y taller visible |
| Enviar cupo cero desde una petición manipulada | 422; no cambia la base |
| Enviar titulo[] en lugar de título | 422; no ocurre TypeError |
| Crear un título que contiene <b>PHP</b> | Se muestra el texto, no una etiqueta activa |
| Editar un ID inexistente | 404 |
| Omitir o alterar el token en POST | 403; no cambia la base |
| Recargar después de guardar | No duplica el taller; flash ya consumido |
| Crear doce talleres | Diez en la primera página, dos en la siguiente |
| Confirmar eliminar | Desaparece solo ese ID |
| Reiniciar el servidor | Los datos persisten |
| Cerrar sesión y consultar la API | 401 |

## Un mapa para leer la referencia

Empieza por validarTaller y sus pruebas; sigue con el repositorio y schema.sql. En index.php localiza responderError y volver antes del bloque try. El bloque try procesa la petición y prepara datos; el HTML posterior solo los presenta con escapar. El servidor PHP ejecuta ese recorrido de nuevo en cada petición; la sesión y SQLite conservan el estado que las variables locales no conservan.
