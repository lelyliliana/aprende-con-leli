# Recorrido de laboratorios Backend

[Volver al curso](../README.md)

Este recorrido reutiliza el código del curso público de Spring Boot. La revisión compatible de Spring Boot 2.2 es [16c4f54](https://github.com/lelyliliana/Curso-Spring-Boot/tree/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11). No copies clases ni combines los pom.xml de sus proyectos. Los enlaces de esta ruta a fuentes Spring Boot están fijados a esa misma revisión.

## Paso 1. Preparar herramientas

Necesitas Java 21, Maven 3.9.x y Git. Python 3.11 o superior permite usar el cliente/verificador públicos. Sigue [entorno](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/ENTORNO.md) si una herramienta falta o Maven usa otro JDK.

## Paso 2. Descargar una copia de práctica

```text
git clone https://github.com/lelyliliana/Curso-Spring-Boot.git
cd Curso-Spring-Boot
git checkout --detach 16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11
```

HEAD separado es esperado: fija la revisión comprobada. Usa una copia nueva; no realices ese checkout sobre cambios propios sin conservarlos.

Los comandos siguientes parten de esta raíz. Mantén el servidor en una terminal y realiza las peticiones desde otra. Usa python3 en Linux/macOS o py en Windows si tu instalación requiere ese nombre.

## Paso 3. Fundamentos

```text
mvn -f laboratorios/fundamentos/pom.xml verify
mvn -f laboratorios/fundamentos/pom.xml spring-boot:run
```

En otra terminal, desde la misma raíz:

```text
python scripts/peticion.py GET "http://127.0.0.1:8080/api/saludos?nombre=Leli"
```

Espera 200, mensaje Hola, Leli y fecha UTC. Prueba nombre vacío (400) y POST con --sin-csrf en el cliente público (405); fundamentos no tiene Spring Security. Estudia la Unidad 01 y detén el servidor con Ctrl+C antes de continuar.

## Paso 4. REST en memoria

```text
mvn -f laboratorios/rest-memoria/pom.xml verify
mvn -f laboratorios/rest-memoria/pom.xml spring-boot:run
```

Crea en otra terminal:

```text
python scripts/peticion.py POST http://127.0.0.1:8080/api/productos --json datos/producto-memoria.json --sin-csrf
```

Espera 201 y Location. Repetir el SKU devuelve 409. Consulta usando el ID recibido y sigue [contrato de etapas](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/CONTRATO_ETAPAS.md) para PUT y DELETE. El catálogo empieza vacío y se pierde al detener el proceso. Estudia Unidad 02 y detén Java.

## Paso 5. JPA y versión

```text
mvn -f laboratorios/jpa-productos/pom.xml verify
mvn -f laboratorios/jpa-productos/pom.xml spring-boot:run
```

Crea con el cuerpo de JPA:

```text
python scripts/peticion.py POST http://127.0.0.1:8080/api/productos --json datos/producto.json --sin-csrf
```

POST añade categoriaId; PUT requiere version actual. Sigue el [README del laboratorio](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/laboratorios/jpa-productos/README.md) para actualizar y provocar el conflicto 409. No uses el cuerpo de REST en memoria sin cambios.

El perfil dev usa H2 en memoria y datos ficticios. Para H2 en archivo usa [la práctica de persistencia de Aprende con Leli](../../fullstack/laboratorio/docs/PERSISTENCIA.md). Para PostgreSQL consulta operación del curso público; no se exige para iniciar esta etapa. Estudia Unidad 03 y detén Java.

## Paso 6. API integrada

Prepara claves locales siguiendo [entorno](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/ENTORNO.md). Se suministran externamente con APP_EDITOR_PASSWORD y APP_LECTOR_PASSWORD; no hay claves predeterminadas en el código principal.

```text
mvn -f ejemplos/api-productos/pom.xml verify
mvn -f ejemplos/api-productos/pom.xml spring-boot:run
```

En otra terminal:

```text
python scripts/peticion.py GET http://127.0.0.1:8080/api/productos
python scripts/peticion.py POST http://127.0.0.1:8080/api/productos --json datos/producto.json --usuario editor
```

El cliente solicita la clave y gestiona CSRF/cookie. No uses --sin-csrf en el integrado. Consulta el [contrato](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/CONTRATO_API.md) para permisos, errores, métricas y pedidos. Estudia las unidades 04–08 según tu punto de avance; no necesitas dominar todas sus clases de inmediato.

## Paso 7. Comprobar las cuatro etapas

Detén los servidores de práctica. Desde raíz del curso público:

```text
python scripts/verificar.py
```

El verificador compila, ejecuta tests, inicia JAR en puertos temporales y realiza peticiones reales con claves ficticias generadas. Revisa salidas/resultado.json y los logs si algo falla. Detiene los procesos al terminar.

La opción estándar comprueba H2. No declares PostgreSQL, Docker o una prueba de carga comprobados si no ejecutaste sus variantes. Sigue [verificación pública](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/VERIFICACION.md) para esos requisitos.

## Paso 8. Profundizar con experimentos aplicados

Vuelve a la raíz de tu copia de Aprende con Leli y sigue los [cuatro experimentos](../docs/EXPERIMENTOS.md). Reutilizan los JAR construidos y añaden reinicio sobre H2 en archivo, rechazos que conservan datos y respuestas de proveedor con conteo de intentos. No necesitan un servidor manual ni claves personales.

## Paso 9. Entregar un proyecto propio

Usa [plantilla](../docs/PLANTILLA_PROYECTO.md) y los criterios de la Unidad 08. Conserva datos ficticios, documenta configuración externa y demuestra instalación, flujo y rechazos.

## Diagnóstico breve

| Síntoma | Revisar |
|---|---|
| No encuentra pom.xml | Carpeta raíz y argumento -f |
| release 21 no soportado | JDK efectivo de Maven |
| Puerto ocupado | Proceso anterior en 8080 |
| 400 | Entrada, parámetros o protocolo |
| 401 | Identidad requerida/no válida |
| 403 | CSRF o autoridad; examina el contexto |
| 409 | Duplicado o versión/estado incompatible |
| 503 cotización | Proveedor no disponible o respuesta inválida |
| Datos desaparecen al reiniciar | H2 dev en memoria |

[Verificación de esta ruta](../docs/VERIFICACION.md)
