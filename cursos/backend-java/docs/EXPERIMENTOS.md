# Cuatro experimentos aplicados de Backend

[Curso](../README.md) · [Laboratorio](../laboratorio/README.md) · [Resultados](VERIFICACION.md)

## Paso 1. Identificar las dos raíces

Trabaja con dos copias locales hermanas:

| Copia | Contenido | Dónde ejecutar |
|---|---|---|
| aprende-con-leli | Esta ruta y recorridos_backend.py | Comandos de los experimentos |
| Curso-Spring-Boot | Fuentes Java, pom y JAR | Maven y verificador público |

Si no tienes Aprende con Leli, clónalo desde la carpeta donde guardarás ambas copias:

```text
git clone https://github.com/lelyliliana/aprende-con-leli.git
```

Obtén Curso-Spring-Boot con el [laboratorio](../laboratorio/README.md), que fija la revisión **16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11**. El programa comprueba HEAD antes de iniciar Java; si es distinto, detente y utiliza una copia de práctica de esa revisión. No cambies de revisión sobre trabajo propio sin conservarlo.

Necesitas Git, Java 21 y Python 3.11 o superior en PATH. Maven 3.9.x construye los JAR. Usa python3 o py si ese es el nombre de Python en tu instalación. Los comandos no necesitan paquetes Python adicionales.

## Paso 2. Construir solo la etapa elegida

Desde **Curso-Spring-Boot**, comienza con REST:

```text
mvn -f laboratorios/rest-memoria/pom.xml verify
```

No hay pom en la raíz. El experimento no invoca Maven ni descarga dependencias por su cuenta. Para las otras etapas, construye el proyecto de la tabla antes de elegirlas:

| Experimento | Comando Maven desde Curso-Spring-Boot |
|---|---|
| rest | `mvn -f laboratorios/rest-memoria/pom.xml verify` |
| persistencia | `mvn -f laboratorios/jpa-productos/pom.xml verify` |
| proveedor | `mvn -f ejemplos/api-productos/pom.xml verify` |
| seguridad | El mismo JAR integrado del anterior |
| todos | Los tres JAR anteriores construidos |

## Paso 3. Ejecutar REST desde Aprende con Leli

Cambia a la raíz de **aprende-con-leli** y ejecuta:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso rest
```

El argumento --spring señala la raíz de tu copia de Spring Boot. Si las carpetas no son hermanas, reemplaza únicamente ese argumento con la ruta real entre comillas cuando tenga espacios.

El programa inicia sus propios JAR en puertos loopback temporales. Descarta configuración Spring/DB heredada de la terminal mediante el contexto de la revisión pública. Las claves educativas se generan durante el proceso y no se imprimen. No envía peticiones a un backend que ya tengas abierto.

## Paso 4. Predecir y elegir el siguiente caso

Ejecuta un comando a la vez después de construir el JAR correspondiente:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso persistencia
```

Ese caso utiliza H2 en un archivo temporal propio. Termina el primer proceso antes de abrir el mismo archivo con el segundo, compara el recurso completo y elimina la carpeta al finalizar. No conserva archivos para tu proyecto ni realiza una copia de seguridad.

Para el proveedor, elige en una siguiente ejecución:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso proveedor
```

El programa levanta un proveedor HTTP local, configura dos intentos y cuenta llamadas. La respuesta válida es 75 y el producto guardado permanece en 10. Otro SKU, JSON roto, 404, 429 y 503 tienen expectativas diferentes. No necesitas una API pública.

Para permisos, en otra ejecución:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso seguridad
```

Compara identidad, autoridad, CSRF y cuerpo inválido, además de salud/métricas/pedidos. El cliente obtiene cookie y token para aislar el control que se pretende observar.

## Paso 5. Interpretar las comprobaciones

| Experimento | Casos | Qué debe conservarse o rechazarse |
|---|---|---|
| REST | 3 | SKU ajeno no cambia A; página vacía mantiene total; 204 sin cuerpo; reinicio vacía mapa |
| Persistencia | 2 | Versión vieja no sobrescribe; id/precio/versión permanecen después de reiniciar sobre archivo |
| Proveedor | 7 | Cuerpo correcto, SKU distinto, JSON roto, 404, 429, 503 transitorio y 503 permanente; catálogo intacto |
| Seguridad | 3 | Matriz de acceso, validación que alcanza MVC y lecturas con distintas autoridades |

La ejecución completa observada tiene **15 casos, 45 peticiones explícitas y 80 comprobaciones**. Las peticiones auxiliares para esperar el arranque y obtener CSRF no se suman a las 45. Las llamadas al proveedor son peticiones internas contadas por escenario; tampoco se suman a ese contador del cliente de la API.

Una excepción detiene la secuencia y cierra los contextos de los procesos iniciados. Abre los logs backend-*.log en salidas de Curso-Spring-Boot si falla una expectativa. El código está en [recorridos_backend.py](../laboratorio/scripts/recorridos_backend.py).

## Paso 6. Repetir el conjunto y relacionarlo con la ruta

Después de construir los tres JAR:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso todos
```

| Unidad | Desarrollo | Práctica |
|---|---|---|
| 00 | [Elegir etapa y evidencia](../unidad00-ruta/DESARROLLO.md) | [Preparar](../unidad00-ruta/PRACTICA.md) |
| 01 | [Petición, configuración y reloj](../unidad01-fundamentos/DESARROLLO.md) | [Fundamentos](../unidad01-fundamentos/PRACTICA.md) |
| 02 | [Contrato y rechazo sin mutación](../unidad02-rest/DESARROLLO.md) | [REST](../unidad02-rest/PRACTICA.md) |
| 03 | [Duración y versión](../unidad03-persistencia/DESARROLLO.md) | [Persistencia](../unidad03-persistencia/PRACTICA.md) |
| 04 | [Proveedor e intentos](../unidad04-integracion/DESARROLLO.md) | [Integración](../unidad04-integracion/PRACTICA.md) |
| 05 | [Controles separados](../unidad05-seguridad/DESARROLLO.md) | [Seguridad](../unidad05-seguridad/PRACTICA.md) |
| 06 | [Riesgos y evidencia](../unidad06-pruebas/DESARROLLO.md) | [Pruebas](../unidad06-pruebas/PRACTICA.md) |
| 07 | [Señales y medición](../unidad07-operacion/DESARROLLO.md) | [Operación](../unidad07-operacion/PRACTICA.md) |
| 08 | [Entrega reconstruible](../unidad08-proyecto/DESARROLLO.md) | [Proyecto](../unidad08-proyecto/PRACTICA.md) |

Fundamentos y pedidos utilizan además los [doce recorridos públicos de Spring Boot](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/RECORRIDOS_GUIADOS.md). Estos cuatro experimentos aplicados complementan esa evidencia. No miden carga, no ejecutan PostgreSQL/Docker y no acreditan identidad de producción.
