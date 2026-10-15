# Diagnóstico de ejecución

[Curso](../README.md) · [Entorno](ENTORNO.md)

| Síntoma | Comprobación siguiente |
|---|---|
| Rscript no se reconoce | Terminal, PATH de R o ejecución con source desde RStudio |
| No encuentra src o datos | getwd y existencia de Curso-R.Rproj; raíz cursos/r |
| Falta un paquete | Ejecutar el instalador una vez y revisar su mensaje completo |
| Una columna numérica aparece como texto | Tipos, delimitador y marca decimal del archivo |
| Aparecen NA tras convertir | Comparar con el original y revisar problems/incidencias |
| La unión aumenta filas | Clave y cardinalidad del catálogo antes de resumir |
| Media NA o NaN | Cantidad realmente observada y política de faltantes |
| El contraste falla con datos constantes | Variación, diseño y dominio de la función; no inventar ruido para obtener un resultado |
| Quarto no encuentra R o un paquete | La instalación de R que usa esa terminal y sus bibliotecas |
| El informe no coincide con datos | Volver a renderizar, revisar raíz y retirar cifras escritas manualmente que ya no coincidan |

No cambies la salida esperada para ocultar un error de contrato. Reduce primero a un archivo pequeño y conserva entrada, comando y mensaje. Distingue un rechazo previsto de una instalación incompleta.
