# Datos de práctica y diccionario

[Curso](../README.md) · [Calidad](../unidad08-limpieza/README.md)

Todos los archivos fueron construidos para este curso. No contienen participantes ni monitoreos reales y no sostienen conclusiones sustantivas sobre personas o poblaciones.

## Encuesta válida

[encuesta.csv](encuesta.csv): 36 filas, una por participante ficticio. Separador coma, decimal punto, codificación UTF-8 y vacío como NA cuando el campo lo permite.

| Campo | Tipo de lectura | Regla del ejercicio |
|---|---|---|
| id | Texto | No vacío ni repetido |
| grupo | Texto | A o B, no faltante |
| edad | Numérico | Entre 18 y 90, finita y no faltante |
| horas_semana | Numérico | Entre 0 y 40; puede faltar |
| puntaje | Numérico | Entre 0 y 100, finito y no faltante |
| satisfaccion | Texto/categoría | baja, media o alta; puede faltar |

Hay 18 filas por grupo. Horas tiene tres faltantes (A: uno; B: dos). Satisfacción tiene dos faltantes. Los límites son reglas del archivo docente, no valores universales para toda investigación.

[grupos.csv](grupos.csv) contiene una modalidad por grupo. Debe relacionarse muchos a uno con la encuesta, por grupo. No existe asignación experimental real.

## Entrada para auditar

[encuesta_sucia.csv](encuesta_sucia.csv): ocho filas. Incluye espacios, coma decimal, una repetición equivalente, edad no interpretable, horas negativas, categoría desconocida y puntaje fuera del dominio. La política conserva la primera aparición equivalente de un ID y rechaza contradicciones del mismo ID. Las filas inválidas se registran; un vacío permitido no se imputa como cero.

## Registro ambiental

[ambiental.csv](ambiental.csv): doce registros de dos estaciones ficticias y seis fechas. ID identifica registro; estación/fecha identifica una medición en ese diseño. Temperatura está en °C y conteo admite faltantes. Hay once conteos conocidos. Un registro sin conteo no significa que se observaran cero.

La suma de conteos no es automáticamente abundancia de una población ni una tasa comparable sin considerar esfuerzo y diseño. Se utiliza como caso descriptivo para transferir la definición de unidad, grupo, fecha y denominador.

## Libro Excel

El ejemplo de Excel usa datasets.xlsx incluido con readxl y su hoja iris; se localiza con readxl_example. No exige descargar un libro externo ni aportar archivos privados. El ejemplo limita la lectura a cinco filas para estudiar hoja, tipos y dimensiones.
