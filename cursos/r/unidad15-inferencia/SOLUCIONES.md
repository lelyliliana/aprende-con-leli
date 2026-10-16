# Soluciones razonadas de la Unidad 15

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar el paso correspondiente. Si tu resultado difiere, revisa entrada, operación y significado antes de cambiar el código.

## Paso 1. Parámetro y alcance

La media es 10 con n=5 y el IC 95% aproximadamente [8.037, 11.963]. Bajo el modelo y condiciones del procedimiento, el intervalo estima una media poblacional. No es un rango de 95% de observaciones. p=1 refleja estadístico coincidente con la hipótesis nula en este caso; no prueba igualdad exacta ni equivalencia.

## Paso 2. Diferencia con dirección

Se calcula media(x)-media(y)=4.2, con n_x=5 y n_y=6. La salida comprobada del script muestra el intervalo numérico. Welch no exige varianzas iguales; siguen importando independencia, diseño y condiciones de distribución/aproximación. Un signo positivo se interpreta en la dirección x-y, que debes conservar.

## Paso 3. Seis diferencias individuales

La unión uno a uno recupera cambios 1, 2, 1, 3, 2, 3, con media 2. Son seis personas medidas dos veces. El modelo pareado trabaja sobre sus diferencias y requiere revisar sus condiciones. El orden inverso del archivo no cambia la identidad porque se une por ID, no por posición.

## Reto de transferencia. Error estándar y grados de libertad

Define a=var(x)/n_x y b=var(y)/n_y. El error estándar es raíz(a+b) y los grados de libertad aproximados son (a+b)²/[a²/(n_x-1)+b²/(n_y-1)]. Con ese cuantil t, el intervalo es diferencia±cuantil×error_estándar. La solución usa esos componentes y contrasta con t.test mediante tolerancia numérica. La concordancia verifica el cálculo del ejemplo, no valida el diseño.

## Respuestas de autoevaluación

El error estándar cuantifica variación de la estimación bajo el modelo. p=1 no establece verdad del nulo. Welch permite varianzas distintas, pero no elimina supuestos de diseño eindependencia. Unir por ID conserva pares aunque cambie el orden del archivo.

## Solución ejecutable de los tres pasos y del reto

[Archivo completo](solucion.R) · [Salida comprobada](solucion.txt)

```r
# Solución completa. Intenta antes la práctica y el reto.
# Paso 1. Estimación e intervalo de una media.
x <- c(8, 9, 10, 11, 12)
una_media <- t.test(x, mu = 10)
stopifnot(mean(x) == 10, abs(una_media$p.value - 1) < 1e-12)
cat(sprintf("Paso 1: media=10; IC95%%=[%.3f, %.3f]; parámetro=media.\n", una_media$conf.int[1], una_media$conf.int[2]))
# Paso 2. Dirección explícita: media de x menos media de y.
x <- c(12, 13, 11, 16, 14)
y <- c(8, 9, 10, 7, 12, 8)
welch <- t.test(x, y, var.equal = FALSE)
diferencia <- mean(x) - mean(y)
stopifnot(abs(diferencia - 4.2) < 1e-12, grepl("Welch", welch$method))
cat(sprintf("Paso 2: n_x=5; n_y=6; diferencia=4.2; IC95%%=[%.3f, %.3f].\n", welch$conf.int[1], welch$conf.int[2]))
# Paso 3. Emparejar por identidad antes de restar.
antes <- data.frame(id = 1:6, puntaje = c(60, 65, 70, 75, 80, 85))
despues <- data.frame(id = 6:1, puntaje = rev(antes$puntaje + c(1, 2, 1, 3, 2, 3)))
pares <- dplyr::inner_join(antes, despues, by = "id", suffix = c("_antes", "_despues"), relationship = "one-to-one")
stopifnot(nrow(pares) == 6, !anyNA(pares))
cambios <- pares$puntaje_despues - pares$puntaje_antes
pareada <- t.test(pares$puntaje_despues, pares$puntaje_antes, paired = TRUE)
stopifnot(identical(cambios, c(1, 2, 1, 3, 2, 3)), abs(unname(pareada$estimate) - 2) < 1e-12)
cat("Paso 3: seis pares; cambios=1,2,1,3,2,3; cambio medio=2.\n")
# Reto. Comprobar el cálculo manual de Welch con las mismas entradas.
error_estandar <- sqrt(var(x) / length(x) + var(y) / length(y))
gl <- (var(x) / length(x) + var(y) / length(y))^2 /
  ((var(x) / length(x))^2 / (length(x) - 1) + (var(y) / length(y))^2 / (length(y) - 1))
manual <- diferencia + c(-1, 1) * qt(0.975, df = gl) * error_estandar
stopifnot(max(abs(manual - unname(welch$conf.int[1:2]))) < 1e-10)
cat("Reto: intervalo de Welch contrastado con error estándar y grados de libertad.\n")
```

Desde la raíz del curso:

```text
Rscript --vanilla unidad15-inferencia/solucion.R
```

Salida esperada:

```text
Paso 1: media=10; IC95%=[8.037, 11.963]; parámetro=media.
Paso 2: n_x=5; n_y=6; diferencia=4.2; IC95%=[1.618, 6.782].
Paso 3: seis pares; cambios=1,2,1,3,2,3; cambio medio=2.
Reto: intervalo de Welch contrastado con error estándar y grados de libertad.
```

---

### ¿Necesitas apoyo con este tema?

Si necesitas comprender una parte, resolver un error o adaptar la práctica a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2015%20%28Intervalos%2C%20contrastes%20y%20dise%C3%B1o%20de%20comparaci%C3%B3n%29%20del%20curso%20R%20desde%20cero%20para%20an%C3%A1lisis%20de%20datos%20e%20investigaci%C3%B3n%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
