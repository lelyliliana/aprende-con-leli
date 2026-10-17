# Unidad 09. HTML, HTTP y páginas dinámicas

[Anterior](../unidad08-errores/README.md) · [Índice](../README.md) · [Siguiente](../unidad10-formularios/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Explicar el viaje de una petición y generar HTML con salida escapada.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

HTML describe la estructura del documento: `h1` es un título, `p` un párrafo y `a` un enlace. Los atributos aportan información como href. El navegador solicita una URL; el servidor interpreta PHP y envía un estado HTTP, cabeceras y cuerpo. GET obtiene una representación; POST envía una operación. Una nueva petición no conserva por sí sola las variables de la anterior.

Para una aplicación local usa `php -S 127.0.0.1:8000 -t proyecto/public` desde cursos/php, cuando llegues al proyecto. Abre http://127.0.0.1:8000 en el navegador y detén el servidor con Ctrl+C. No abras el archivo .php con doble clic. El servidor integrado es solo para desarrollo local; no lo uses como servidor público.

Todo texto de una persona que se inserte en contenido HTML o un atributo entre comillas debe pasar por `htmlspecialchars($texto, ENT_QUOTES | ENT_SUBSTITUTE, "UTF-8")`. Sin escape, un título que contenga etiquetas podría ejecutarse como código en el navegador (XSS). El escape depende del contexto: esta función no hace seguro insertar texto dentro de JavaScript, CSS o URLs arbitrarias. En el proyecto solo insertamos textos en HTML y construimos enlaces con IDs validados.

Las cabeceras se envían antes del cuerpo: `header` y los códigos de respuesta deben ocurrir antes de echo. Un espacio previo a <?php puede causar «headers already sent». Estos ejemplos imprimen HTML en la terminal para inspeccionar el resultado; el proyecto mostrará ese mismo principio por HTTP.

## Seguir una petición completa antes de mezclar formularios

Una URL identifica una petición que el navegador entrega al servidor. Tiene esquema, servidor, posible puerto, ruta y consulta. En http://127.0.0.1:8000/?nombre=Leli, el esquema es http, el destino es tu equipo, el puerto 8000 y la consulta contiene nombre. El servidor decide qué archivo o controlador atiende la ruta. Una carpeta del disco y una ruta URL no son automáticamente la misma cosa.

El navegador puede solicitar además estilos e imágenes, de modo que abrir una página suele producir varias peticiones. Cada ejecución PHP comienza con variables locales nuevas. Puedes comprobarlo mostrando un valor inicial y recargando: sin persistencia explícita vuelve a empezar. Más adelante la sesión y la base conectarán peticiones; no supongas que una variable global vive para todos los visitantes.

### Sigue el viaje en un diagrama

```mermaid
sequenceDiagram
    participant N as Navegador
    participant S as Servidor con PHP
    participant A as Archivo y reglas
    N->>S: GET /?nombre=Leli
    S->>A: Ejecutar instrucciones con la entrada
    A-->>S: HTML con datos escapados
    S-->>N: Estado 200 + Content-Type + cuerpo HTML
    Note over N: Presenta HTML; no recibe las instrucciones PHP
```

Cada flecha indica una frontera. Cambiar el nombre modifica la entrada del mismo programa; no crea un nuevo archivo. El estado y el tipo de contenido acompañan al cuerpo para que el cliente sepa cómo tratarlo.

### Cabeceras y cuerpo tienen un orden

La respuesta contiene un código de estado, cabeceras y un cuerpo. Un 200 con un párrafo «error» sigue comunicando éxito al protocolo; si la operación no existe o falla, el estado debe expresarlo. Content-Type indica cómo interpretar el cuerpo. Un documento HTML y un JSON pueden contener textos parecidos, pero tienen contratos de presentación distintos.

PHP puede preparar cabeceras mientras todavía no envió el cuerpo. Una salida accidental previa puede impedir cambiarlas. Por eso las decisiones de método, sesión, validación y redirección se toman antes de imprimir la vista. Capturar salida en un búfer no sustituye entender el orden: puede posponer el síntoma sin hacer más clara la arquitectura.

### Construir un documento HTML comprensible

El documento debe indicar idioma y codificación, tener un título de pestaña y un encabezado principal que describa la pantalla. Un enlace a otra página y un botón para una operación no significan lo mismo. Un label asociado a un campo permitirá identificarlo sin depender de su posición visual. Esta estructura aporta accesibilidad y facilita las comprobaciones automatizadas.

Puedes alternar PHP y HTML cerrando el bloque en una plantilla. La forma `<?= ... ?>` imprime el valor de una expresión; no lo escapa automáticamente. Un bucle que genere elementos de lista debe producir etiquetas bien anidadas. Antes de añadir estilos, inspecciona el HTML y confirma que la información tiene sentido sin presentación decorativa.

### Escapar en el lugar donde se presenta

Un título almacenado puede contener <b>PHP</b> como texto legítimo. Guardarlo no lo vuelve seguro para cualquier salida. Al insertarlo en contenido HTML, htmlspecialchars conserva su apariencia textual evitando que esas marcas creen una etiqueta activa. Al devolver JSON, usa json_encode; el escape HTML no es la transformación apropiada para todos los formatos.

Tampoco construyas una URL arbitraria con texto escapado y supongas que su destino es seguro. Para un enlace de edición, la aplicación fija la ruta y usa un ID entero validado. El contexto decide qué operación necesitas. Esta distinción evita enseñar una función como una receta universal de seguridad.

### Observar con herramientas del navegador

En las herramientas de desarrollo, la pestaña Red muestra método, URL, estado y cabeceras. El inspector muestra el documento que el navegador construyó; «ver código fuente» muestra el HTML recibido. Ninguno debe mostrar las instrucciones PHP del servidor. Si aparecen, revisa qué servicio está sirviendo el archivo antes de trabajar en su estilo.

El [laboratorio HTTP](../laboratorios/09-http/README.md) permite modificar una consulta, observar 200 y 405 y probar texto con etiquetas. Se ejecuta por separado del proyecto para que puedas seguir una sola petición pequeña. Guarda una captura del estado y una explicación de la diferencia entre el parámetro que enviaste, el HTML de respuesta y el texto que viste.

## Ejemplo 1. Una página mínima

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

$titulo = 'Mi primer taller';
echo '<!doctype html><html lang="es"><meta charset="UTF-8"><title>Taller</title><h1>' . $titulo . "</h1></html>\n";
```

```sh
php unidad09-web/ejemplos/01.php
```

Salida esperada:

```text
<!doctype html><html lang="es"><meta charset="UTF-8"><title>Taller</title><h1>Mi primer taller</h1></html>
```

El servidor genera texto HTML. Aquí titulo es una constante nuestra; para datos externos usa el siguiente ejemplo.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | titulo es texto fijo de la aplicación. |
| 2 | La concatenación lo coloca entre las etiquetas h1. |
| 3 | La terminal muestra el HTML como texto; un navegador lo presentaría como documento. |

## Ejemplo 2. Mostrar texto como texto

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

$titulo = "<script>alert(1)</script>";
$seguro = htmlspecialchars($titulo, ENT_QUOTES | ENT_SUBSTITUTE, "UTF-8");
echo "<h1>$seguro</h1>\n";
```

```sh
php unidad09-web/ejemplos/02.php
```

Salida esperada:

```text
<h1>&lt;script&gt;alert(1)&lt;/script&gt;</h1>
```

Las entidades se muestran como caracteres y no como una etiqueta ejecutable.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | El título contiene marcas que podrían ser interpretadas como etiquetas. |
| 2 | htmlspecialchars sustituye esos delimitadores por entidades. |
| 3 | El HTML conserva el texto del título sin crear un script activo. |

## Ejemplo 3. Generar una lista HTML escapada

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

$titulos = ["PHP & HTML", "<b>SQL</b>"];
echo "<ul>\n";
foreach ($titulos as $titulo) {
    $texto = htmlspecialchars($titulo, ENT_QUOTES | ENT_SUBSTITUTE, "UTF-8");
    echo "  <li>$texto</li>\n";
}
echo "</ul>\n";
```

Ejecuta desde cursos/php:

```sh
php unidad09-web/ejemplos/03.php
```

Resultado que debes obtener:

```text
<ul>
  <li>PHP &amp; HTML</li>
  <li>&lt;b&gt;SQL&lt;/b&gt;</li>
</ul>
```

### Lectura guiada y experimentos

El bucle conserva la estructura fija de la lista y escapa solo los datos variables. La primera cadena convierte & en su entidad y la segunda convierte las marcas de etiqueta en texto. Si copiaras la salida a un HTML, el navegador mostraría ambos títulos sin interpretar b como énfasis.

Prueba una cadena que contenga comillas y observa el resultado de ENT_QUOTES. Después contrasta la salida CLI con el laboratorio en el navegador: aquí inspeccionas el documento como texto, allí observas su presentación. No elimines el escape solo porque la primera entrada de práctica no tenga símbolos especiales.

## Comprueba tu comprensión

1. Identifica título, párrafo y enlace en una página HTML.
2. Predice qué ocurre con el texto <b>PHP</b> al escaparlo.
3. Reto: genera un párrafo con el nombre Ana & Luis escapado.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad08-errores/README.md) · [Índice](../README.md) · [Siguiente](../unidad10-formularios/README.md)
