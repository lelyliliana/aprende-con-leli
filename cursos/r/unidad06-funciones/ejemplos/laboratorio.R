# Laboratorio guiado. Ejecutar desde cursos/r.
minutos_desde_horas <- function(horas) {
  minutos <- horas * 60
  return(minutos)
}
resultado <- minutos_desde_horas(1.5)
print(resultado)
clasificar <- function(horas) {
  if (horas >= 5) {
    return("cinco o más")
  } else {
    return("menos de cinco")
  }
}
print(clasificar(3))
print(clasificar(5))
suma <- 0
for (valor in c(2, 4, 6)) {
  suma <- suma + valor
  print(suma)
}
stopifnot(resultado == 90, suma == 12)
