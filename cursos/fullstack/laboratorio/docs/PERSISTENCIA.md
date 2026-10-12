# Guardar cambios entre reinicios

[Volver al laboratorio](../README.md)

## Paso 1. Comparar memoria y archivo

Con la ejecución normal del laboratorio, crea un producto y recarga el navegador: permanece. Reinicia Spring Boot: desaparece y regresan los datos ficticios iniciales. H2 en memoria dura mientras vive el proceso Java.

Para usar H2 en archivo, primero detén Spring Boot con Ctrl+C. No cambies archivos de código ni el curso de Spring Boot.

## Paso 2. Empaquetar

Desde la raíz de tu copia de Curso-Spring-Boot:

```text
mvn -f laboratorios/jpa-productos/pom.xml package
```

## Paso 3. Usar una base en archivo

Desde esa misma raíz ejecuta esta única línea:

```text
java -jar laboratorios/jpa-productos/target/jpa-productos.jar "--spring.datasource.url=jdbc:h2:file:./datos-fullstack/productos;MODE=PostgreSQL"
```

La ruta es relativa a la carpeta desde donde ejecutas Java. Inicia siempre desde la raíz de Curso-Spring-Boot para usar el mismo archivo. El perfil dev conserva las migraciones y categorías de demostración; Flyway no vuelve a insertar datos ya aplicados.

No mantengas a la vez otro backend en el puerto 8080 ni dos procesos usando el mismo archivo de base de datos.

## Paso 4. Comprobar

Con React iniciado, crea un producto `ARCHIVO-01`. Reinicia solo el backend usando exactamente el comando anterior y pulsa Actualizar catálogo. El producto debe seguir ahí. Después elimina el producto de prueba.

H2 en archivo permite practicar almacenamiento duradero. Para una aplicación multiusuario real, estudia el [entorno PostgreSQL del curso Spring Boot](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/docs/OPERACION.md), migraciones, copias y recuperación.

No subas la carpeta datos-fullstack a Git. Guarda datos ficticios de práctica y realiza una copia del archivo con el proceso detenido si quieres conservarlo. El laboratorio no incluye automatización de copias ni despliegue de PostgreSQL.
