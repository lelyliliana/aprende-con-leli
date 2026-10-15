# Verificar una entrega que otra persona pueda ejecutar

[Unidad](README.md) · [Soluciones](SOLUCIONES.md) · [Recorrido de construcción](../laboratorio/pasos/README.md)

## 1. Comienza por comportamientos observables

Una mejora debe tener un criterio verificable. Por ejemplo, poder buscar una tarea sin borrar las ocultas; volver a leerla después de recargar; o rechazar un documento incompatible sin sustituirlo por vacío. Una captura final no muestra por sí sola esas propiedades.

Antes de entregar elige problema y persona usuaria. Un plan de lectura necesita una acción concreta distinta de cambiar colores: quizá separar lecturas pendientes y completadas por una regla que puedas comprobar. Limita el primer alcance para terminar un recorrido completo.

## 2. Cada tipo de prueba responde una pregunta

| Comprobación | Qué examina | Qué queda fuera de esa evidencia |
|---|---|---|
| Dominio | Reglas sobre colecciones y fronteras | Diseño visual y red real |
| Storage con medio controlado | Documento, errores y persistencia de la simulación | Sincronización remota |
| Componente/DOM en jsdom | Eventos y representación con entorno controlado | Distribución real de píxeles |
| HTTP contra servidor escuchando | Rutas, códigos, cuerpos y métodos | Toda interacción por teclado |
| Navegador real | Recorrido visible, foco y redistribución | Todos los dispositivos posibles |

No escribas una prueba por cada línea. Elige casos que fallen si se rompe una regla importante. Títulos iguales con ids diferentes, límite de cantidad, documento inválido y escritura fallida son casos que revelan problemas que una sola tarea feliz no muestra.

## 3. Ejecuta una comprobación a la vez

Desde laboratorio, termina primero:

```text
npm test
```

Si falla, lee el caso y el primer error relevante. Una vez resuelto, genera:

```text
npm run build
```

El build comprueba construcción y produce dist. Incluye tres páginas principales y seis del recorrido de construcción, contando su índice. No sirve todavía una aplicación accesible desde cualquier equipo.

Después inicia:

```text
npm run preview
```

Preview escucha 4174 en la referencia. Abre por sus nombres las tres principales y /pasos/index.html. Los datos del origen de dev no aparecen automáticamente bajo este otro puerto. No confundas eso con un fallo del empaquetado.

## 4. Verifica HTTP además de compilar

Con dev iniciado, una comprobación reproducible es:

```text
npm run verify:http
```

El script comprueba nueve páginas y escenarios de la API. Para verificar preview ejecuta:

```text
npm run verify:http -- http://127.0.0.1:4174
```

El argumento permite elegir el origen sin comandos de variables de entorno distintos por sistema. El servidor correspondiente debe estar escuchando. Un script que consulta 5174 no está verificando automáticamente la instancia de preview.

## 5. Recorre ancho estrecho y teclado

Prueba al menos una ventana amplia y otra estrecha, una tarea con texto largo, foco visible y uso de Enter/Tab. Registra qué navegador y ancho usaste. Un resultado observado no acredita todos los sistemas o tecnologías de asistencia. Si una fila desborda, vuelve a sus restricciones CSS y a la longitud real del contenido.

El recorrido de construcción ofrece una comprobación adicional: paso 3 pierde memoria al recargar; pasos 4/5 comparten identidad persistida; un documento roto bloquea modificaciones y conserva el valor original. La aplicación principal conserva otra clave para no mezclar ambas prácticas.

## 6. Publica lo que realmente incluye la entrega

Dist contiene HTML, CSS, JavaScript y assets. No contiene un proceso Vite que se ejecute por copiar la carpeta. La API de recursos requiere un servicio en el destino; las tareas locales pueden funcionar en un hosting estático bajo su propio origen.

No incluyas node_modules como sustitución de instrucciones de instalación ni claves privadas. Conserva package-lock.json y documenta versiones, carpeta de ejecución y comandos. Una ruta exclusiva de tu computador no es una instrucción reproducible.

## 7. Documenta un incremento propio

Escribe cuatro piezas: problema, regla nueva, criterio de aceptación y evidencia. Ejemplo de búsqueda: una consulta oculta tareas no coincidentes, pero al borrarla todas reaparecen con los mismos ids y estados. La prueba debe detectar si la búsqueda destruye datos; no basta comprobar que existe un input llamado Buscar.

El esquema de evaluación del curso suma cien puntos: problema/aceptación 15, estructura/diseño 20, interacción/reglas 25, persistencia/errores 15, React/estados remotos 15 y pruebas/documentación 10. Para cada uno conserva una evidencia y señala qué falta.

## 8. Haz una entrega que pueda revisarse

Incluye un README con instalación, modelo, clave de Storage, límites, casos y recuperación. Otra persona debe poder distinguir una API ficticia, un dato local y una cuenta remota que no existe en esta práctica. Demuestra un fallo y su recuperación además del caso válido. Terminar significa poder explicar y repetir el resultado, no solamente que una compilación terminó en verde.

[Contrastar las soluciones](SOLUCIONES.md) · [Volver a la unidad](README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Pruebas%2C%20publicaci%C3%B3n%20y%20proyecto%20propio%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad07-proyecto%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
