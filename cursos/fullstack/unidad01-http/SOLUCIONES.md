# Soluciones de la Unidad 01

[Volver a la unidad](README.md)

Intenta los ejercicios antes de leer. Las respuestas explican criterios y admiten otras implementaciones coherentes.

1. GET y la URL pertenecen a la petición; estado 200, Content-Type y JSON pertenecen a la respuesta. En la práctica GET devuelve el arreglo en memoria; no prueba JPA.

2. Para el laboratorio JPA, un cuerpo posible es `{"sku":"FS-02","nombre":"Libro","precio":15.50,"categoriaId":1}`, siempre que la categoría 1 exista. No asignas ID ni versión en POST.

3. contenido vacío con total cero es consulta correcta y debe presentar “sin coincidencias”. Una conexión fallida presenta error con reintento y no debe inventar una lista.

**Reto:** define ISBN no vacío y único, título obligatorio y categoriaId existente. Especifica POST 201, 400 para entrada inválida y 409 para duplicado. El diseño exige implementar esas reglas después; no basta escribir estados en una tabla.
