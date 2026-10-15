# Diagnosticar con señales y formular una medición que se pueda comparar

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## 1. Define qué pregunta responde cada señal

Health indica el estado de los componentes configurados. La salida pública omite components. Readiness incluye base de datos; liveness responde otra pregunta sobre el proceso. Un health UP no demuestra que una creación tenga permisos, formato o SKU aceptables.

Métricas requieren OPS_READ. El editor educativo tiene esa autoridad, el lector no. Antes de interpretar un rechazo de métricas como caída de la aplicación, compara identidad/permiso y consulta salud pública. La [práctica de seguridad](../unidad05-seguridad/PRACTICA.md) ya permite observar esas diferencias.

## 2. Usa request ID como correlación local

El filtro acepta un X-Request-Id de 1 a 64 caracteres alfanuméricos o guion. Si no es válido, genera UUID. Lo devuelve en headers y lo agrega al MDC del hilo; el finally registra método/status y limpia la entrada para no contaminar una petición posterior.

El [recorrido integrado público](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/RECORRIDOS_GUIADOS.md) comprueba eco de guia-123 y reemplazo de un identificador demasiado largo. Ese dato sirve para buscar el registro asociado en salidas. No autentica al emisor ni demuestra propagación automática a otro servicio o tarea asíncrona.

## 3. Formula una hipótesis antes de lanzar carga

Una comparación necesita revisión, endpoint, tamaño de datos, calentamiento, cantidad, concurrencia, errores y distribución de latencia. Conserva esas condiciones al cambiar una variable, como la estrategia de fetch. Si cambias base, cantidad de filas e índice a la vez, no puedes atribuir toda diferencia al índice.

Ejemplo didáctico inventado (no es una medición de la API): latencias 10, 20, 30, 40 y 900 ms. La media es 200 ms y la mediana 30 ms. Con la convención de rango más cercano, p95 selecciona la quinta observación: 900 ms. Con solo cinco datos, ese percentil es muy poco representativo; demuestra por qué un promedio aislado oculta la cola, no una capacidad de usuarios.

## 4. Interpreta errores antes de comparar velocidad

Una cotización fallida con 503 no es equivalente a una consulta de catálogo válida con 200. El proveedor controlado del experimento demuestra semántica y cantidad de intentos; no es un benchmark. Para medir ambas rutas debes registrar también respuesta, tamaño de muestra y fallos.

http.server.requests utiliza rutas normalizadas. Añadir cada SKU o request ID como etiqueta multiplicaría las series. Elige etiquetas con valores acotados y unidad explícita. La referencia no incorpora un timer propio del proveedor por el solo hecho de usar RestClient: proponer esa métrica exige instrumentarla.

## 5. Cierra el diagnóstico con una siguiente observación

Si aumenta latencia, examina distribución y errores, después señales de base/proveedor/JVM coherentes con la petición. Un timeout de lectura no demuestra por sí solo el plazo total de todo el caso de uso. Conserva una hipótesis y una medición que pueda descartarla; evita modificar varias capas para esconder el síntoma.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Observabilidad%20y%20rendimiento%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad07-operacion%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
