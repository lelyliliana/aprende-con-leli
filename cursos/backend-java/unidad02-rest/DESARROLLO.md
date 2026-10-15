# Diseñar un contrato y demostrar que un rechazo no modifica datos

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## 1. Define lo observable antes de añadir clases

El recurso material utiliza sku, nombre y precio. El servidor asigna id. En esta etapa no hay categoriaId, version ni autenticación. Documentar esos campos antes de hacer peticiones evita copiar contratos de otro proyecto y atribuirles capacidades que el mapa no tiene.

| Acción | Petición | Resultado de referencia |
|---|---|---|
| Crear | POST /api/productos | 201, Location y recurso |
| Consultar | GET /api/productos/{id} | 200 o 404 |
| Reemplazar datos | PUT /api/productos/{id} | 200, 400, 404 o 409 |
| Eliminar | DELETE /api/productos/{id} | 204 sin cuerpo, o 404 |

El cliente debe leer id o Location; no adivinar que el siguiente recurso tendrá id 1. El cuerpo de un 204 está vacío y no debe analizarse obligatoriamente como JSON.

## 2. Sigue dos causas de rechazo diferentes

Precio 1.001 incumple @Digits en el DTO y produce 400 antes de ejecutar el caso de uso. Un SKU ya registrado con una entrada válida produce 409 por el estado del catálogo. Si envías ambos errores juntos, el 400 no demuestra que se haya comprobado unicidad.

El [servicio REST](https://github.com/lelyliliana/Curso-Spring-Boot/blob/16c4f54d1271fa9d7a99ad4d6e990c49ed46cb11/laboratorios/rest-memoria/src/main/java/com/lelyliliana/rest/ProductoService.java) comprueba SKU antes de sustituir el valor del mapa. Crea A y B; intenta dar a A el SKU de B y precio 99. La consulta posterior de A debe conservar todos sus campos. Observar solo 409 dejaría sin comprobar esa parte del contrato.

## 3. Distingue colección, filtro y recurso individual

Con dos materiales coincidentes y tamaño 1, página 0 contiene uno y total es 2. Página 2 puede contener cero y seguir informando total 2. No equivale a consultar un id inexistente: una colección filtrada puede estar vacía sin que falle la ruta.

La implementación filtra sin distinguir mayúsculas y ordena por id antes de aplicar desplazamiento. GET no añade materiales ni cambia precios. El orden es estable para un estado de datos dado; no promete una fotografía permanente si otra operación cambia el catálogo.

## 4. Relaciona capas con garantías concretas

Controller interpreta HTTP; DTO define forma y restricciones; Service coordina el mapa; advice representa errores. synchronized mantiene comprobación y escritura dentro del monitor de una instancia. No coordina réplicas y no guarda datos al detener la JVM.

El [experimento REST](../docs/EXPERIMENTOS.md) demuestra rechazo sin mutación, página vacía, 204 y reinicio. Después adapta en una copia el contrato a materiales de tu contexto. Cambiar solo el título de una entidad sin definir aceptación no constituye una nueva regla de negocio.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Contratos%20REST%2C%20validaci%C3%B3n%20y%20capas%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad02-rest%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
