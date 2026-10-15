# Fuentes técnicas del recorrido Frontend

[Curso](README.md) · [Construcción](laboratorio/pasos/README.md)

Las dependencias ejecutables se fijan en package.json y package-lock.json del laboratorio. Las explicaciones se contrastan con los programas completos de cada etapa; no se atribuye a la documentación externa una prueba de este proyecto.

| Tema | Fuente primaria | Qué permite ampliar |
|---|---|---|
| Documento HTML | [HTML Living Standard](https://html.spec.whatwg.org/multipage/) | Significado de elementos y atributos |
| Nombre de controles | [MDN: label](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/label) | Asociación con for e id |
| Distribución flexible | [MDN: Flexbox](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_flexible_box_layout) | Ejes, tamaños y redistribución |
| Contenido de texto | [MDN: textContent](https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent) | Representar texto sin interpretarlo como marcado |
| Almacenamiento | [MDN: localStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage) | Origen, cadenas y posibles errores |
| Estado React | [React: estado como instantánea](https://react.dev/learn/state-as-a-snapshot) | Qué observa un handler y cuándo se solicita otra representación |
| Colecciones | [React: actualizar arreglos](https://react.dev/learn/updating-arrays-in-state) | Nuevos arreglos y objetos sin mutar el estado anterior |
| Efectos | [React: sincronizar con efectos](https://react.dev/learn/synchronizing-with-effects) | Dependencias y limpieza de una sincronización |
| Peticiones | [MDN: Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) | Respuesta HTTP frente a rechazo de transporte |
| Cancelación | [MDN: AbortController](https://developer.mozilla.org/en-US/docs/Web/API/AbortController) | Señales y cancelación de una operación |
| Entrega | [Vite: build](https://vite.dev/guide/build.html) | Assets y archivos estáticos generados |

Accesibilidad, compatibilidad de navegador y publicación deben comprobarse con el resultado real y el destino elegido. Un build no acredita por sí solo todos esos comportamientos.
