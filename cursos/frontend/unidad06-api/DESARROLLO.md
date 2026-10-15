# Construir una consulta que distinga datos, vacío y error

[Unidad](README.md) · [Soluciones](SOLUCIONES.md) · [Recorrido de construcción](../laboratorio/pasos/README.md)

## 1. Separa recursos remotos del plan local

Para esta unidad abre react.html principal y [Recursos.jsx](../laboratorio/src/Recursos.jsx). main.jsx monta App y Recursos como responsabilidades distintas. La consulta de recursos no añade tareas, no las borra y no las sincroniza. El endpoint devuelve ejemplos ficticios para poder controlar el ensayo.

La URL `./api/recursos` se resuelve desde la página que se está sirviendo. En react.html principal apunta a /api/recursos, donde el plugin local responde. Copiar el componente a una ruta anidada puede cambiar esa resolución: el paso 5 no incorpora este componente ni promete ese endpoint dentro de /pasos. Comprueba la URL real antes de atribuir un 404 al servidor equivocado.

## 2. Identifica las variables que gobiernan la petición

Modo elige escenario; intento permite reintentar el mismo modo. Estado representa cargando, datos o error. Datos guarda la colección aceptada y error conserva el mensaje de fallo. El efecto depende de modo e intento: al cambiar alguno comienza otro recorrido.

Cada efecto crea su propio AbortController, marca cargando y vacía datos/error anteriores. La función de limpieza aborta esa consulta al reemplazarla o desmontar el componente. El ensayo inicial con API rápida puede no dejar ver la carga durante mucho tiempo; las herramientas de red permiten ralentizar para estudiarla.

## 3. Ejecuta por etapas, no en una única intuición

Primero fetch obtiene una respuesta HTTP. Después se comprueba r.ok. Si fue exitosa, r.json intenta interpretar el cuerpo. Por último se exige un arreglo con elementos cuyo nombre sea cadena e id sea número.

```js
const respuesta = await fetch(url, { signal });
if (!respuesta.ok) throw new Error(`HTTP ${respuesta.status}`);
const datos = await respuesta.json();
```

Este fragmento muestra el orden, no reemplaza el efecto completo: url, signal, validación, estados y limpieza deben conservar un contexto. La referencia real combina cancelación de consulta con un límite temporal de 5000 ms.

Un 503 no provoca por sí solo el rechazo de la promesa fetch: recibiste una respuesta HTTP. Por eso se comprueba ok antes de tratar su cuerpo como recursos. Un corte de red puede originar otro error, sin respuesta HTTP utilizable.

## 4. Construye una tabla antes de pulsar opciones

| Modo | HTTP | Cuerpo del laboratorio | Representación |
|---|---:|---|---|
| normal | 200 | Dos recursos ficticios | Lista |
| vacio | 200 | [] | No hay recursos disponibles |
| error | 503 | Mensaje de fallo controlado | Error y acción de reintento |

Vacío es éxito sin elementos, no ausencia de conexión. La forma de un JSON también importa: un 200 con un objeto no esperado debe rechazarse por el cliente. Esta validación básica no demuestra unicidad de ids ni exactitud de todos los datos de una API real; comprueba el contrato concreto que el programa implementa.

## 5. Evita representar una consulta vieja

Supón que eliges normal y enseguida error. Si normal tarda más y llega después, no debe reemplazar el estado de la elección nueva. La limpieza cancela el controlador anterior y el código comprueba su signal antes de actualizar estados.

Una cancelación por cambio de consulta no es el mismo caso que timeout. La referencia combina las señales y distingue el mensaje temporal. El soporte de estas APIs pertenece al navegador utilizado; la compilación de JavaScript por sí sola no demuestra todos los navegadores posibles.

Para ensayar el orden puedes utilizar interceptación controlada de red en una prueba o ralentizar respuestas en DevTools. No concluyas ausencia de carreras porque una API instantánea siempre devolvió el mismo orden en una sola observación.

## 6. Reintenta una intención concreta

El botón incrementa intento. Si el modo sigue siendo error, el servidor seguirá respondiendo 503: reintentar no cambia automáticamente las condiciones que fallaron. Cambia a normal después para observar recuperación con otra condición. El plan local debe continuar sin perder tareas durante ambos casos.

## 7. Diseña el reto antes de conectarlo

Para convertir un recurso en tarea, decide qué texto pasa al dominio y qué ocurre si el plan ya tiene cien tareas. Una función del padre podría recibir nombre, calcular nuevas=agregar(tareas,nombre), actualizar y guardar. Recursos recibiría un callback alAgregar, sin decidir la política de Storage.

No necesitas duplicar la validación ni asumir que id del recurso equivale a id de tarea. El registro nuevo del plan tiene identidad propia. Ver un recurso no debe producir automáticamente una tarea al montar o repetir un efecto.

## 8. Distingue build de servicio

El endpoint está implementado como middleware en vite.config.js para dev y preview. Copiar los assets a un alojamiento estático no instala ese proceso. El plan local puede seguir funcionando, pero la consulta requerirá un servicio disponible o una variante explícita. Separa esa condición de la apariencia del componente.

[Contrastar las soluciones](SOLUCIONES.md) · [Volver a la unidad](README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Consulta%20de%20datos%20y%20estados%20remotos%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad06-api%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
