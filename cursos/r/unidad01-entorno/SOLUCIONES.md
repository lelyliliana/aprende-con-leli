# Soluciones de la Unidad 01

[Lección](README.md) · [Práctica](PRACTICA.md)

Contrasta después de intentarlo. Una salida correcta necesita una explicación de la unidad, el denominador y el contrato que corresponden al caso.

R.version.string identifica la ejecución de R; getwd muestra la carpeta desde la que se resuelven rutas. Ninguno sustituye al otro. El proyecto debe abrir cursos/r, no la raíz general de Aprende con Leli.

2+3*4 produce 14 por precedencia. (2+3)*4 produce 20. La media de 7,8,9 es 8. Una sesión limpia debe obtener esos resultados leyendo el archivo completo, sin objetos anteriores.

Rscript es un comando de terminal. Dentro de la consola R puedes usar source para ejecutar un archivo; no escribas allí el comando de terminal como si fuera una expresión R. La solución ejecutable compara ambos resultados aritméticos.

## Solución ejecutable

[Archivo completo](solucion.R)

```r
# Solución ejecutable. Intentar primero la práctica.
a <- 2 + 3 * 4
b <- (2 + 3) * 4
stopifnot(a == 14, b == 20)
cat("Sin paréntesis:", a, "; con paréntesis:", b, "\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad01-entorno/solucion.R
```
