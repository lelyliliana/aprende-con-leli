# Práctica aplicada de la Unidad 01

[Unidad](README.md) · [Desarrollo](DESARROLLO.md) · [Práctica](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

Completa un paso antes de seguir con el siguiente. Consulta las soluciones después de intentarlo.

## Paso 1. Observar el caso mínimo

Construye e inicia fundamentos con el [laboratorio](../laboratorio/README.md). Consulta el saludo con Leli y con Ana. Registra los campos que cambiaron y el que depende del reloj.

## Paso 2. Cambiar una sola entrada

Envía nombre vacío y uno de 41 letras. Después prueba POST con el cliente público añadiendo `--sin-csrf`, porque fundamentos no tiene Spring Security. Predice 400, 400 y 405 antes de observarlos.

## Paso 3. Ejecutar sin reloj variable

Desde Curso-Spring-Boot ejecuta:

```text
mvn -f laboratorios/fundamentos/pom.xml -Dtest=SaludoServiceTest test
```

Localiza el instante fijo y la fecha esperada en la prueba. Explica por qué comparar con tu fecha local actual sería otra expectativa.

## Paso 4. Reutilizar el JAR

Detén el servidor. Arráncalo con el argumento del reto y consulta de nuevo. Como comparación automática, después de construirlo ejecuta desde Curso-Spring-Boot:

```text
python scripts/recorridos.py --etapa fundamentos
```

Entrega petición válida, dos rechazos y la relación entre constructor, configuración y reloj.

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Primera%20API%20y%20responsabilidades%20del%20curso%20Backend%20y%20APIs%20con%20Java%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2Faprende-con-leli%2Fblob%2Fmain%2Fcursos%2Fbackend-java%2Funidad01-fundamentos%2FREADME.md%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
