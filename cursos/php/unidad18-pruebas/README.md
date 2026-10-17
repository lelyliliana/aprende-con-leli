# Unidad 18. Pruebas automatizadas y casos límite

[Anterior](../unidad17-api/README.md) · [Índice](../README.md) · [Siguiente](../unidad19-arquitectura/README.md)

[Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Lo que aprenderás

Comprobar resultados, fallos y persistencia con evidencias reproducibles.

Requisito: haber completado la unidad anterior. Si un concepto te cuesta, vuelve a su ejemplo antes de avanzar. Todos los comandos parten de `cursos/php`.

## Explicación

Una prueba prepara una situación, ejecuta una operación y compara el resultado con un contrato esperado. Una prueba unitaria se concentra en una regla pequeña; una de integración comprueba colaboradores reales, como PDO y SQLite; una prueba HTTP sigue peticiones y respuestas de la aplicación. Todas aportan evidencia distinta.

No uses únicamente assert de PHP para una comprobación obligatoria: puede estar deshabilitado según la configuración. Nuestro verificador lanza RuntimeException si algo no coincide y termina con código distinto de cero. Las salidas esperadas de los ejemplos están guardadas junto al código para que puedas contrastarlas. Cambiar el resultado esperado para que pase una prueba no corrige automáticamente el programa.

Comprueba caminos negativos: título vacío, cupo cero, entrada como arreglo, ID inexistente, token incorrecto y acceso sin sesión. Usa una base temporal por prueba y nunca borres la base de estudio para reiniciar el conjunto. Evita llamadas a servicios externos para que las pruebas no dependan de Internet. Más adelante puedes aprender PHPUnit con estos mismos principios; no hace falta instalarlo para completar esta ruta.

## Una comprobación necesita poder equivocarse

Una prueba aporta evidencia si falla cuando el comportamiento rompe el contrato. Ejecutar un archivo y observar que no termina con error es insuficiente si nunca comparó lo que debía producir. Antes de escribir la comprobación, escribe el resultado esperado desde la regla del problema. Si copias exactamente la expresión del programa para calcular ese esperado, puedes reproducir el mismo error en los dos lados.

El ciclo preparar, actuar y comprobar separa responsabilidades. Preparar crea los datos y dependencias. Actuar llama a la operación una vez en el escenario elegido. Comprobar compara un resultado o cambio observable. Si una prueba prepara un taller editándolo mediante la misma función que intenta probar, un fallo de edición podría ocultarse en la preparación. Utiliza datos conocidos y pasos claros.

### Elegir casos por comportamiento, no por cantidad

Para título de 3 a 100 caracteres, prueba 2, 3, 100 y 101, además de tipo inválido. Esas entradas cubren fronteras que muchos textos de longitud media no distinguirían. Para cupo agrega ausencia, decimal y arreglo; cada uno pone a prueba una suposición diferente. No hace falta generar miles de variantes si todas atraviesan el mismo camino y no añaden evidencia.

Una tabla de casos ayuda a mantener entrada, esperado y propósito juntos. La salida de fallo debe identificar el caso para que no tengas que repetir todo a mano. Al comprobar excepciones, confirma que apareció el tipo previsto; una excepción de conexión no demuestra que se validó correctamente un cupo. Un catch demasiado amplio puede hacer pasar una prueba por el motivo equivocado.

### Aislamiento y estado compartido

Las pruebas de repositorio usan una base en memoria o un archivo temporal nuevo. No deben depender del orden en que se ejecutaron ni de que tu cuenta de estudio exista. Crear el esquema de forma conocida evita un falso éxito basado en filas antiguas. Para comprobar persistencia en disco necesitas cerrar y reabrir una conexión a un archivo temporal: memoria por sí sola no demuestra esa propiedad.

Las pruebas HTTP añaden el servidor, cabeceras, formularios, cookies y redirecciones. No reemplazan las de reglas pequeñas, porque un fallo en una pantalla completa puede tener muchas causas. Las de reglas tampoco demuestran que el controlador llamó a la función correcta ni que escapó la salida. Cada nivel comprueba una frontera distinta y debe tener un propósito que puedas señalar.

### Evitar dependencias del reloj y del entorno

Una prueba de fecha que usa hoy puede pasar en octubre y fallar en noviembre sin cambios de código. Recibe una fecha de referencia o utiliza una fija en el caso. El mismo principio se aplica a servicios externos, rutas personales, locale y orden no declarado de SQL. Decide qué parte del entorno forma parte del contrato y fija o aísla lo demás para reproducirlo.

Los verificadores del curso normalizan finales de línea para Windows, pero no borran diferencias de contenido ni mensajes de error. Si un programa emite una advertencia nueva, debe investigarse. No amplíes la tolerancia hasta que todo pase sin comprender qué cambió. La función del verificador es ayudarte a detectar diferencias significativas.

### Una pequeña prueba de mutación

Cambiar deliberadamente una condición correcta en una copia permite comprobar que tus casos la detectan. Si sustituyes cupo <=100 por cupo <100 y ninguna prueba falla, faltaba el extremo superior. Si cambias && por || y todo sigue verde, probablemente no comprobaste rechazos independientes. El objetivo no es dejar código roto: restaura la versión correcta después del experimento.

En el [laboratorio de pruebas](../laboratorios/18-pruebas/README.md) compararás dos implementaciones con la misma tabla de casos. La defectuosa debe fallar precisamente en un límite. Documentar ese fallo esperado es más formativo que agregar una prueba que solo refleja la implementación. La suite del curso mantiene sus rechazos HTTP y SQL para proteger también las integraciones.

## Ejemplo 1. Comprobar un resultado

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/01.php) · [Salida esperada](ejemplos/01.txt)

```php
<?php
declare(strict_types=1);

function comprobar(bool $condicion, string $mensaje): void {
    if (!$condicion) { throw new RuntimeException($mensaje); }
}
function total(int $precio, int $cantidad): int { return $precio * $cantidad; }
comprobar(total(2500, 3) === 7500, "Subtotal incorrecto");
comprobar(total(2500, 0) === 0, "Caso cero incorrecto");
echo "2 comprobaciones correctas\n";
```

```sh
php unidad18-pruebas/ejemplos/01.php
```

Salida esperada:

```text
2 comprobaciones correctas
```

Los resultados esperados se escriben explícitamente e incluyen cantidad cero.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | La función total entrega un resultado que se puede comparar. |
| 2 | Las expectativas 7500 y cero provienen del contrato del problema. |
| 3 | comprobar lanza un fallo si cualquiera de esas igualdades deja de cumplirse. |

## Ejemplo 2. Probar el rechazo

Antes de ejecutar, predice la salida y señala qué instrucción produce cada línea.

[Archivo completo](ejemplos/02.php) · [Salida esperada](ejemplos/02.txt)

```php
<?php
declare(strict_types=1);

function validar(int $cupo): void {
    if ($cupo < 1) { throw new InvalidArgumentException("Cupo inválido"); }
}
$rechazado = false;
try { validar(0); } catch (InvalidArgumentException $e) { $rechazado = true; }
if (!$rechazado) { throw new RuntimeException("Se aceptó un cupo cero"); }
echo "Rechazo comprobado\n";
```

```sh
php unidad18-pruebas/ejemplos/02.php
```

Salida esperada:

```text
Rechazo comprobado
```

La prueba falla si la función deja de rechazar el caso, incluso si no aparece ninguna excepción.

### Lectura por estados

| Momento | Qué ocurre |
|---|---|
| 1 | El indicador rechazado comienza en falso. |
| 2 | validar(0) debe lanzar la excepción prevista. |
| 3 | El indicador cambia y la comprobación final confirma que el rechazo realmente ocurrió. |

## Ejemplo 3. Detectar una implementación equivocada con los mismos casos

[Programa completo](ejemplos/03.php) · [Salida esperada](ejemplos/03.txt)

```php
<?php
declare(strict_types=1);

$casos = [[1, true], [100, true], [0, false], [101, false]];
$correcta = fn (int $cupo): bool => $cupo >= 1 && $cupo <= 100;
$defectuosa = fn (int $cupo): bool => $cupo >= 1 && $cupo < 100;
foreach (["Correcta" => $correcta, "Defectuosa" => $defectuosa] as $nombre => $regla) {
    $fallos = 0;
    foreach ($casos as [$entrada, $esperado]) {
        if ($regla($entrada) !== $esperado) { $fallos++; }
    }
    echo "$nombre: $fallos fallos\n";
}
```

Ejecuta desde cursos/php:

```sh
php unidad18-pruebas/ejemplos/03.php
```

Resultado que debes obtener:

```text
Correcta: 0 fallos
Defectuosa: 1 fallos
```

### Lectura guiada y experimentos

Las dos funciones reciben exactamente las mismas entradas y se contrastan con resultados escritos desde el dominio. La única diferencia es incluir o excluir cien. El caso del extremo superior detecta el fallo; los demás siguen pasando. La función flecha es un callback y la variable regla se invoca como una función en cada vuelta.

Retira temporalmente el caso cien: la implementación defectuosa deja de ser detectada. Restáuralo y cambia ahora >=1 por >1: debes detectar el extremo inferior. El mensaje del ejemplo informa cuántos fallos encontró cada implementación, de modo que la demostración completa termina correctamente cuando observa el contraste esperado. Un verificador de producción, en cambio, debe terminar con error si falla su implementación principal.

## Comprueba tu comprensión

1. Modifica una copia de total para que sume y observa el fallo.
2. Agrega una comprobación para un solo producto.
3. Reto: comprueba resultados para cantidades 0, 1 y 3 en una tabla de casos.

Resuelve la [práctica](PRACTICA.md) antes de abrir las soluciones. Puedes avanzar cuando explicas la salida, modificas el ejemplo y justificas un caso límite.

[Anterior](../unidad17-api/README.md) · [Índice](../README.md) · [Siguiente](../unidad19-arquitectura/README.md)
