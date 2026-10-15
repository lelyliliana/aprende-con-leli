# Construir el plan por incrementos

[Curso](../../README.md) · [Laboratorio completo](../README.md)

Inicia el servidor según el laboratorio y abre `http://127.0.0.1:5174/pasos/`. No necesitas sustituir todos los archivos de golpe: cada paso es una versión completa que permite observar una diferencia concreta.

| Paso y fuente | Qué cambia | Unidad para construirlo |
|---|---|---|
| [01 HTML](01-html.html) | Documento, regiones y formulario sin estilos; controles todavía deshabilitados | [Desarrollo 01](../../unidad01-html/DESARROLLO.md) |
| [02 CSS](02-css.html) y [base.css](base.css) | Presentación de la misma estructura y redistribución según ancho | [Desarrollo 02](../../unidad02-css/DESARROLLO.md) |
| [03 Memoria](03-memoria.html) y [JavaScript completo](03-memoria.js) | Estado, eventos, representación y filtros sin persistencia | [Desarrollo 03](../../unidad03-javascript/DESARROLLO.md) |
| [04 Guardado](04-guardado.html) y [JavaScript completo](04-guardado.js) | Lectura inicial, guardado y políticas ante fallo | [Desarrollo 04](../../unidad04-persistencia/DESARROLLO.md) |
| [05 React](05-react.html) y [componentes completos](05-react.jsx) | Mismas reglas/documento, estado React y componente Tarea | [Desarrollo 05](../../unidad05-react/DESARROLLO.md) |

GitHub muestra fuentes. Las páginas se ejecutan con el servidor local o desde un build servido; los nombres de archivo de esta tabla no significan que GitHub ejecute los módulos de la práctica.

## Comparar una diferencia a la vez

1. En HTML identifica qué significa cada región y control.
2. En CSS comprueba que no se añadió interacción por presentar mejor el formulario.
3. En memoria crea una tarea y recarga: debe desaparecer porque no se guardó.
4. En guardado crea otra y recarga: debe seguir si se completó la escritura.
5. Cierra guardado, abre React y completa la tarea. Cierra React y vuelve a guardado para comprobar el mismo id y estado.

Los módulos 03 y 04 están escritos como versiones completas separadas para que puedas comparar el cambio de persistencia sin seguir una abstracción adicional. Importan las mismas reglas de dominio. La versión React extrae Tarea y conserva una sola responsabilidad para modificar el plan.

## Dos claves con propósitos distintos

| Práctica | Clave | Compartida por |
|---|---|---|
| Construcción | leli.frontend.construccion.v1 | Pasos 4 y 5 |
| Aplicación principal | leli.frontend.plan.v1 | javascript.html y react.html principales |

El paso 3 no utiliza Storage. El [adaptador de construcción](almacenamiento.js) reutiliza el contrato del proyecto y dirige sus operaciones solo a su clave. Los datos no se importan entre ambas parejas y no se coordinan ediciones simultáneas entre pestañas.

## Qué no incluye todavía el paso 5

El ejemplo reducido representa tareas locales. La consulta de recursos se estudia en [Unidad 06](../../unidad06-api/DESARROLLO.md) usando react.html principal, donde se monta Recursos. Su URL relativa de API pertenece a esa ruta; copiarla a otra carpeta puede cambiar el destino de la petición.

## Comprobar

Desde laboratorio ejecuta `npm test` y después `npm run build`. El build contiene nueve páginas: tres principales, este recorrido y cinco pasos. Preview sirve también esas páginas. El endpoint de práctica existe en dev/preview y necesita un servicio equivalente en otro destino; los pasos reducidos no dependen de esa API.

[Ver evidencias de verificación](../docs/VERIFICACION.md).
