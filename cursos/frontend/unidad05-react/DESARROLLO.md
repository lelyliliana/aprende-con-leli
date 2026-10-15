# Pasar a React conservando reglas y significado

[Unidad](README.md) · [Soluciones](SOLUCIONES.md) · [Recorrido de construcción](../laboratorio/pasos/README.md)

## 1. Compara responsabilidades, no solo sintaxis

Abre [05-react.jsx](../laboratorio/pasos/05-react.jsx) y la versión JavaScript con guardado. Ambas utilizan agregar, alternar, eliminar y filtrar del mismo dominio, y leerPlan/guardarPlan de la misma práctica. No necesitamos otro contrato de título ni otra clave por utilizar componentes.

En JavaScript escribías qué nodos crear y qué listeners conectar. En React describes cómo debe verse el estado actual con JSX y entregas handlers para las acciones. React coordina actualizar la representación. El arreglo de tareas sigue siendo el modelo de esta UI y Storage sigue siendo almacenamiento local, no una base de datos remota.

## 2. Empieza por campo y formulario

`const [titulo, setTitulo] = useState('')` conserva el texto de la entrada. value lo representa y onChange solicita actualizarlo. Un campo controlado necesita ambas partes: si value permanece fijo y no atiendes el cambio, no podrá reflejar lo escrito.

```jsx
<input
  value={titulo}
  onChange={evento => setTitulo(evento.target.value)}
/>
```

El fragmento corresponde al input del componente, no a un documento HTML separado. En el archivo completo también están id, etiqueta, ayuda, límites y referencia de foco. No los pierdas al probar una modificación.

El formulario usa onSubmit y preventDefault, como la versión DOM. Un botón dentro del formulario puede enviar tanto al pulsarlo como al confirmar desde el campo. No necesitas un listener distinto para cada forma de enviar.

## 3. Carga una vez sin escribir al iniciar

La inicialización `useState(() => leerPlan())` solicita la lectura como inicializador. leerPlan no guarda ni borra. En modo de desarrollo React puede repetir inicializadores para comprobar pureza; una lectura sin efectos destructivos conserva el contrato.

A partir de inicio se crean tareas y error. Si existe un error de lectura inicial, las acciones se bloquean. No añadas un efecto que guarde tareas vacías al montar: antes necesitas distinguir clave ausente de documento que no pudiste interpretar.

## 4. Sigue una transformación válida

La función aplicar calcula nuevas a partir de tareas. Luego solicita setTareas, intenta guardar exactamente nuevas y actualiza mensajes. No lee tareas inmediatamente después esperando que setTareas haya sustituido la variable capturada por el handler.

```js
const nuevas = cambio(tareas);
setTareas(nuevas);
setError(guardarPlan(nuevas));
```

Esta versión centraliza acciones síncronas de usuario. Si diseñaras actualizaciones encoladas dependientes del estado anterior, estudiarías la forma funcional del setter. No coloques escritura de Storage dentro de un actualizador que debería ser puro para resolverlo: separar cálculo y efecto conserva una responsabilidad comprobable.

Cuando guardar falla, la nueva colección todavía puede representarse y el aviso aclara que sigue en sesión. No confundas la solicitud de un render con una confirmación de persistencia.

## 5. Deriva lo que no necesita otra memoria

Visibles se calcula desde tareas y filtro. Pendientes se cuenta desde tareas. Guardar también esos resultados como estados independientes introduciría el requisito de mantenerlos coordinados en cada acción. Para este proyecto son datos derivados.

| Valor | ¿Qué significa? | ¿Se guarda en el documento? |
|---|---|---|
| tareas | Datos del plan | Sí |
| titulo | Texto aún en el formulario | No |
| filtro | Preferencia de vista en esta sesión | No |
| pendientes | Cuenta calculada de las tareas | No, se deriva |
| error/mensaje | Información de la operación | No |

Recargar conserva tareas si se guardaron, pero puede reiniciar filtro y texto en edición. No es una contradicción: el contrato persistente no incluye esos valores.

## 6. Extrae una tarea como componente completo

La referencia ya contiene Tarea con props tarea, bloqueada, alCompletar y alEliminar. Se usa así:

```jsx
<Tarea
  key={tarea.id}
  tarea={tarea}
  bloqueada={Boolean(inicio.error)}
  alCompletar={id => aplicar(ts => alternar(ts, id), 'Estado actualizado.')}
  alEliminar={id => aplicar(ts => eliminar(ts, id), 'Tarea eliminada.')}
/>
```

Tarea recibe datos y comunica una intención mediante callback. No mantiene otro arreglo oculto ni escribe Storage por su cuenta. El componente padre decide cómo transformar la colección.

key pertenece a la identificación que React usa al reconciliar la lista; el componente recibe el id dentro de tarea. No lo reemplaces por índice cuando la lista puede filtrarse o eliminarse. Dos títulos iguales pueden seguir siendo dos identidades diferentes.

## 7. Foco y texto conservan su función

La ref campo permite devolver foco después de una acción. No sustituye el estado del título: apunta a un elemento concreto. El contenido de tarea.titulo se coloca como texto en span; no usa una API que interprete HTML de la persona.

Prueba el mismo título con signos de marcado que en JavaScript. Comprueba que se mantiene literal, que la casilla actúa sobre su identidad y que el botón tiene un nombre accesible específico.

## 8. Completa una migración observable

Crea una tarea en paso 4, cierra la página y abre paso 5. Completa esa tarea y vuelve al paso 4 después de cerrar React. Debe conservar identidad y nuevo estado. Esa comparación demuestra compatibilidad del documento, no sincronización en tiempo real entre pestañas.

Para incorporar Recursos en la Unidad 06 utiliza react.html principal, donde main.jsx monta App y Recursos. Ese archivo conserva la pareja principal de datos, con su propia clave. El paso 5 mantiene deliberadamente el ejemplo reducido sin petición remota.

[Contrastar las soluciones](SOLUCIONES.md) · [Volver a la unidad](README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Del%20DOM%20a%20componentes%20React%20del%20curso%20Desarrollo%20Frontend%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Ffrontend%2Funidad05-react%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
