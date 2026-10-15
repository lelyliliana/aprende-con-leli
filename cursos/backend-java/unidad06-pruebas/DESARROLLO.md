# Elegir evidencia para cada riesgo y conservar el estado correcto

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## 1. Empieza por una regla que pueda fallar

«Maven termina» no describe qué comportamiento protege tu prueba. Para una actualización vieja, la regla completa es: responder conflicto y conservar precio/versión de la última actualización aceptada. Preparar crea el recurso, actuar intenta el cambio viejo y comprobar revisa respuesta y dato posterior.

| Riesgo | Frontera útil | Límite de esa evidencia |
|---|---|---|
| Servicio decide guardar un duplicado | Unitario con dependencia controlada | No ejecuta UNIQUE real |
| Esquema admite dos SKU iguales | Repositorio con motor y flush | Identifica solo el motor utilizado |
| DTO inválido llega como éxito | Web con permiso/CSRF adecuados | Una slice puede sustituir el servicio |
| Configuración o empaquetado impide arrancar | JAR con cliente HTTP | No sustituye todas las reglas unitarias |
| Datos desaparecen al reiniciar | Dos procesos sobre el mismo archivo | No demuestra recuperación ante una caída abrupta |

## 2. Lee la conservación posterior, no solo el error

La secuencia REST compara A antes/después del SKU ajeno. La secuencia JPA compara el resultado válido con GET después del 409 y después del reinicio. La secuencia de proveedor compara catálogo completo después de cada cotización, válida o rechazada. Esas consultas hacen observables efectos secundarios que un código HTTP aislado no detectaría.

El [programa de experimentos](../laboratorio/scripts/recorridos_backend.py) reutiliza el cliente y contexto del curso público; no copia sus clases Java. Las peticiones explícitas se cuentan una vez y las comprobaciones adicionales validan cuerpo, headers o estado. Los auxiliares de arranque y CSRF no forman parte de ese contador.

## 3. Distingue un contador de una garantía

Quince casos no son quince peticiones, y ochenta comprobaciones no son ochenta pruebas Maven. Un mismo caso puede hacer varias peticiones y comprobar varios campos. Registra cada medida con su nombre. La revisión pública incluye 77 pruebas Maven en cuatro proyectos y doce recorridos guiados adicionales, que tienen su propio alcance.

La matriz CI describe escenarios configurados. Consulta resultados del commit para afirmar que se ejecutaron; un archivo de workflow no demuestra por sí solo una ejecución verde. H2 en modo PostgreSQL sigue siendo H2 y no prueba todos los comportamientos del otro motor.

## 4. Aplica la misma lectura al precio histórico de pedidos

En la integrada, el pedido se crea BORRADOR. Si el catálogo cambia de 10 a 15 antes de confirmar dos unidades, el total confirmado es 30. Si luego cambia a 99, el historial sigue siendo 30. Cancelar conserva el precio capturado; no permite volver a confirmar el cancelado.

Sigue el [recorrido público de pedidos](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/docs/RECORRIDOS_GUIADOS.md) y las pruebas de rollback/concurrencia. Un rollback de un test dentro del mismo hilo no controla automáticamente escrituras hechas por un JAR que corre en otro proceso. Por eso el verificador usa sus propios datos y procesos de práctica.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Pruebas%20y%20evidencia%20de%20comportamiento%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad06-pruebas%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
