# Unidad 06. Build, configuración y entrega

[Volver al índice](../README.md)

## Objetivos

- Construir y comprobar los artefactos de una aplicación.
- Separar configuración pública, secretos y servicios de ejecución.
- Preparar una entrega reproducible con límites explícitos.

## Antes de comenzar

Debes ejecutar las pruebas y el laboratorio local. Revisa [configuración React](https://github.com/lelyliliana/Curso-React/blob/main/unidad31-configuracion/README.md) o [producción Spring Boot](https://github.com/lelyliliana/Curso-Spring-Boot/blob/main/unidad27-produccion/README.md) solo cuando necesites profundizar en el concepto.

## 1. Build no es despliegue

npm run build prepara los archivos de interfaz. Maven empaqueta el backend como JAR. El resultado exitoso demuestra que se generó un artefacto, pero no que una base esté conectada ni que un usuario remoto pueda completar un flujo.

Completa [la revisión del build](../laboratorio/README.md#paso-8-revisar-el-build). Mantén Spring Boot iniciado y abre preview en 4173. Prueba una consulta y una creación con datos ficticios. No uses preview como servidor permanente de producción.

## 2. Seguir una configuración

El cliente usa /api como ruta relativa. Vite la reenvía en desarrollo y preview, pero ese proxy no está dentro de dist. En producción debes ofrecer un servidor que resuelva /api o configurar una URL pública y CORS en el backend.

Una URL de API es configuración pública. Contraseñas de base de datos y claves privadas corresponden al entorno del servidor. Las variables VITE_ llegan al navegador: aunque provengan de un archivo llamado .env, no ocultan secretos.

## 3. Responsabilidades de la nube

Lee la [guía propia de nube](../material/nube.md). Un alojamiento estático entrega HTML, CSS y JavaScript; no ejecuta un JAR ni sustituye una base. IaaS, PaaS y SaaS describen cuánto administra el proveedor y cuánto debes administrar tú.

No elijas una plataforma solo porque puede mostrar la portada. Comprueba si ejecuta Java, cómo conecta la base, cómo suministra configuración y cómo se observan los errores. Esta unidad prepara la entrega; no exige contratar ni desplegar infraestructura.

## 4. Reproducir la instalación

El lockfile fija el cliente y backend.json registra una revisión compatible del backend. Una persona que recibe tu proyecto debe poder instalar, iniciar y reconocer el resultado esperado sin buscar datos que solo existen en tu computador.

Prueba tu entrega en una copia nueva: dependencias, comandos, puertos, datos ficticios y pruebas. Anota los límites. Este backend educativo no implementa autenticación; no se convierte en una aplicación pública segura por generar un JAR.

## Ejercicios

1. Clasifica estos valores: URL pública de API, contraseña de PostgreSQL, tamaño de página y puerto de proceso. Indica dónde los configurarías y cuáles pueden llegar al navegador.
2. Genera dist y explica qué archivos corresponden a interfaz y dónde queda el proceso Java. Prueba que la aplicación consulta la API al usar preview.
3. Escribe una guía de arranque en una copia nueva e identifica una instrucción ambigua. Corrígela y repite el recorrido.

## Reto

Dibuja una propuesta de despliegue para interfaz, API y base. Define quién resuelve /api, cómo se conservan datos y cómo se recupera una copia. No es necesario contratar un proveedor para justificar la arquitectura.

## Errores frecuentes

- Publicar src en un alojamiento estático esperando que ejecute JSX: usa el build.
- Copiar la configuración del proxy de Vite como si funcionara en cualquier hosting: configura el servidor de destino.
- Guardar claves en VITE_: son visibles para quien recibe la interfaz.
- Afirmar “listo para producción” sin verificar seguridad ni operación: documenta el alcance comprobado.

## Comprobación para avanzar

Puedes generar artefactos, probar el build localmente y entregar instrucciones sin secretos ni supuestos sobre tu equipo.

## Continuar

- [Unidad anterior: Errores, concurrencia y pruebas](../unidad05-calidad/README.md)
- [Volver al índice](../README.md)
- [Soluciones (después de intentar)](SOLUCIONES.md)
- [Siguiente unidad: Proyecto propio y evaluación](../unidad07-proyecto/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Build%2C%20configuraci%C3%B3n%20y%20entrega%20del%20curso%20Desarrollo%20Full%20Stack%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffullstack%2Funidad06-entrega%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
