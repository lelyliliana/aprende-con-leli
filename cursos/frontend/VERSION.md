# Frontend 1.1: construcción progresiva

Fecha: 2026-10-14 (America/Bogota).

Se incorporan ocho desarrollos y ocho soluciones ampliadas, con lectura del código, tablas, ejemplos y diagnóstico. Cinco versiones ejecutables permiten comparar HTML sin estilos, CSS, JavaScript en memoria, persistencia y React. La versión React incluye el componente Tarea extraído como resolución completa del reto.

Los pasos con persistencia reutilizan el esquema y las reglas del proyecto con una clave propia, leli.frontend.construccion.v1. Las páginas principales conservan leli.frontend.plan.v1. No se añaden cuentas o sincronización entre pestañas/equipos.

El build pasa a nueve páginas: tres principales y seis de construcción, contando su índice. El verificador HTTP admite un origen como argumento para comprobar dev o preview con el mismo comando. Se mantienen las versiones de dependencias fijadas.

Las pruebas de interacción cubren transferencia con identidad estable, texto literal, aislamiento de claves y fallos de almacenamiento. Una prueba de respuesta remota tardía comprueba que no reemplace la consulta actual. Consulta los resultados y límites en [VERIFICACION.md](laboratorio/docs/VERIFICACION.md).
