# Añadir guardado sin borrar lo que no pudiste leer

[Unidad](README.md) · [Soluciones](SOLUCIONES.md) · [Recorrido de construcción](../laboratorio/pasos/README.md)

## 1. Compara dos versiones completas

Abre [03-memoria.js](../laboratorio/pasos/03-memoria.js) y [04-guardado.js](../laboratorio/pasos/04-guardado.js). Los dos conservan el recorrido evento → transformación → representación. La segunda añade leer al comenzar, guardar después de una acción válida y bloquear modificaciones si la lectura inicial falló.

Son copias educativas completas para comparar diferencias; las reglas reales se importan del mismo dominio. No debes mantener dos políticas distintas de título o identidad en cada página.

## 2. Comprende las reglas que ya estabas usando

[dominio.js](../laboratorio/src/dominio.js) normaliza el título con String y trim. En esta UI el campo entrega una cadena. Rechaza vacío y longitud mayor de 80 unidades de cadena JavaScript. Esas unidades no equivalen siempre a caracteres visuales: ciertos símbolos utilizan más de una unidad.

Agregar rechaza una colección de 100 tareas y una identidad repetida. Por defecto crea un UUID. Devuelve otro arreglo; alternar también devuelve un arreglo y un objeto nuevo para la tarea afectada. Eliminar usa filter. Esas transformaciones permiten conservar valores anteriores y probar reglas sin navegador visual.

```js
const anterior = [];
const siguiente = agregar(anterior, '  Repasar CSS  ', 'ejemplo-a');
// anterior sigue vacío; siguiente contiene titulo 'Repasar CSS'.
```

El cargador de documentos exige ids de texto no vacíos y únicos; no exige que todos los documentos importados usen el formato UUID. La creación de nuevas tareas y la aceptación del formato persistido son contratos relacionados, pero no idénticos.

## 3. Un objeto debe convertirse en texto para Storage

El documento conserva version 1 y tareas. JSON.stringify lo serializa; JSON.parse intenta reconstruirlo. El número version pertenece al contrato de datos, no al número de versión del paquete npm.

```json
{
  "version": 1,
  "tareas": [
    {"id": "ejemplo-a", "titulo": "Repasar CSS", "completa": false}
  ]
}
```

El adaptador [pasos/almacenamiento.js](../laboratorio/pasos/almacenamiento.js) reutiliza cargar/guardar de la aplicación y dirige sus operaciones a leli.frontend.construccion.v1. No duplica el esquema. La aplicación completa mantiene leli.frontend.plan.v1. Las dos claves pueden coexistir bajo el mismo origen.

## 4. Lee antes de decidir si puedes modificar

Al comenzar, leerPlan devuelve tareas y error. Si la clave no existe, una colección vacía es una inicialización normal. Si el contenido existe pero está roto, el cargador informa error sin sobrescribirlo. La UI bloquea agregar, completar y eliminar para no reemplazar inadvertidamente datos que no pudo interpretar.

| Situación | Memoria de la UI | Documento existente |
|---|---|---|
| Clave ausente | Empieza vacío y permite acciones | Se crea tras un cambio válido |
| Documento válido | Carga tareas | Se conserva hasta una acción |
| JSON o esquema inválido | Informa y bloquea modificaciones | Permanece original |
| Escritura falla después de una acción | Conserva cambio en sesión y avisa | No se promete actualizado |

No añadas un guardado automático de [] al arrancar. Convertir un error de lectura en un guardado vacío destruiría precisamente el contenido necesario para investigar.

## 5. Sigue una acción persistente

Después de una transformación válida, la versión guardada llama guardarPlan y representa las tareas. Si setItem falla, guardar devuelve un mensaje. El arreglo nuevo continúa en memoria. La acción puede ser visible sin quedar persistida; recargar podría recuperar la versión anterior y perder lo no guardado.

No muestres Guardado sin comprobar la operación. El mensaje Tarea agregada describe el cambio de la sesión; el aviso adicional explica que el guardado falló. Son dos dimensiones diferentes del resultado.

## 6. Prueba transferencia y origen

Crea una tarea en paso 4, recarga y confirma. Cierra esa página y abre paso 5; debe leer el mismo documento. Evita ediciones simultáneas: esta práctica no fusiona conflictos entre pestañas. Cambiar a otro puerto puede mostrar otro almacenamiento aunque las rutas y el código sean iguales.

Al ir después a la aplicación completa no esperes importar las tareas de pasos: su clave es distinta de manera deliberada. Realiza también los ejercicios originales entre javascript.html y react.html principales, que sí comparten su propia clave.

## 7. Recupera solo la práctica que estás probando

Con datos ficticios, copia el valor de la clave exacta antes de dañarlo para un ensayo. En DevTools cambia únicamente leli.frontend.construccion.v1 a texto inválido y recarga. Comprueba el bloqueo y que el texto no se reemplazó. Restaura el documento válido que copiaste y vuelve a cargar. No borres todo Storage del origen para reparar una sola clave.

[Contrastar las soluciones](SOLUCIONES.md) · [Volver a la unidad](README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Datos%20locales%20y%20reglas%20del%20proyecto%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad04-persistencia%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
