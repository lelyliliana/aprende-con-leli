# Datos ficticios y diccionario

[Curso](../README.md) · [Proyecto](../proyecto/README.md)

Los registros representan materiales inventados para practicar. No proceden de una institución, inventario real ni estudiantes. Los precios usan centavos de una unidad monetaria de práctica.

## inventario.csv

Una fila representa un material identificado por código. La entrada contiene seis materiales y utiliza encabezado exacto `codigo;cantidad;precio_centavos`, con punto y coma como delimitador.

| Campo | Representación y dominio | Ausencia |
|---|---|---|
| codigo | Texto ASCII de 1 a 20 bytes: A-Z, 0-9, guion o guion bajo; único en el lote | No permitida |
| cantidad | Entero representable, de 0 a 100000 incluidos | No permitida |
| precio_centavos | Entero representable, de 0 a 100000000 incluidos | No permitida |

Se permiten de 1 a 10000 productos por lote. Un 0 conocido es válido. El formato no admite espacios alrededor de los enteros, caracteres numéricos sobrantes, campos adicionales, comillas ni registros multilínea. Un signo negativo que produzca un valor menor que cero se rechaza por dominio. No se realiza normalización automática de códigos.

El lector acepta finales LF y CRLF y retira un BOM UTF-8 inicial si existe. Eso no lo convierte en un analizador de cualquier variante CSV ni en un validador Unicode general. El nombre .csv identifica este formato de práctica delimitado; su contrato está en este diccionario.

Los límites conservan productos y sumas dentro de int64_t en las plataformas comprobadas. Además se comprueba el total antes de escribir. No se utiliza punto flotante para representar cantidades monetarias de este ejercicio.

## Otros archivos

- lectura.txt tiene dos líneas de práctica para aprender flujos antes del lector del proyecto.
- invalido.csv contiene una cantidad negativa deliberada para comprobar un rechazo previo.
- entradas contiene casos controlados para probar el programa de captura de la Unidad 05.
- stdout-vacio.txt es una referencia de salida estándar vacía para los casos rechazados.

## Reporte y fuente son esquemas distintos

El reporte añade subtotal_centavos y ordena por código. Su esquema tiene cuatro columnas, por lo que no debe pasarse al lector de entrada que exige tres. La [muestra de salida](../proyecto/muestra/reporte.csv) conserva CAJA con cantidad 0 y total de subtotales 55000. No se eliminan materiales por aportar cero al total.
