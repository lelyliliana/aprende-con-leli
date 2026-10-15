# Práctica aplicada de la Unidad 06

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Completa un paso antes de seguir con el siguiente. Consulta las soluciones después de intentarlo.

## Paso 1. Relacionar riesgo y prueba

Selecciona una regla del servicio, una restricción UNIQUE y una respuesta HTTP. Escribe qué prueba correspondería y qué cambio incorrecto debería detectar cada una.

## Paso 2. Ejecutar la revisión pública

Desde Curso-Spring-Boot, con herramientas preparadas:

```text
python scripts/verificar.py
```

Guarda resultado.json y consulta un informe Surefire. Identifica pruebas Maven, recorridos, motor y comprobaciones documentales/HTTP.

## Paso 3. Ejecutar evidencia aplicada

Desde Aprende con Leli:

```text
python cursos/backend-java/laboratorio/scripts/recorridos_backend.py --spring ../Curso-Spring-Boot --caso todos
```

Elige una consulta posterior a un rechazo y explica qué fallo pasaría inadvertido si la quitaras.

## Paso 4. Seguir historial de pedidos

En el recorrido integrado identifica cuándo se captura precio y cuándo se incrementa versión. Predice el total después de cambiar catálogo y después de cancelar.

## Paso 5. Proponer una prueba nueva

En una copia propia define la regla «precio máximo 500». Diseña primero una entrada 500 aceptada y otra 500.01 rechazada. Esa regla no está implementada en la referencia. Anota qué pruebas deberían fallar antes de implementarla y qué fronteras deben aplicarla.

Entrega matriz de riesgos, resultados diferenciados y evidencia de estado conservado.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Pruebas%20y%20evidencia%20de%20comportamiento%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad06-pruebas%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
