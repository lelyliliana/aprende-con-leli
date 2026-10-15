# Unidad 04. Ciclos, acumuladores y trazas

[Anterior](../unidad03-decisiones/README.md) · [Índice](../README.md) · [Siguiente](../unidad05-entrada/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Sumar 1 a 5.
- Terminar una cuenta regresiva.
- Contar [0, 5).

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Repetir necesita condición, cambio y estado

Un ciclo ejecuta un bloque varias veces. for comunica inicialización, condición y actualización en un mismo encabezado. En for(int valor{1}; valor<=4; ++valor), se crea valor en 1, se comprueba el límite antes de cada vuelta y se incrementa después de ejecutar el cuerpo.

### Sigue el acumulador en una tabla

suma empieza en 0 fuera del ciclo. En cada vuelta suma+=valor conserva el acumulado anterior más el nuevo número. Si reinicias suma dentro del cuerpo, pierdes la información anterior.

| Vuelta | valor | suma antes | suma después |
|---|---|---|---|
| 1 | 1 | 0 | 1 |
| 2 | 2 | 1 | 3 |
| 3 | 3 | 3 | 6 |
| 4 | 4 | 6 | 10 |

### Una condición se evalúa antes del cuerpo

Si la condición inicial es falsa, for y while pueden ejecutar cero vueltas. while(pendientes>0) requiere que alguna instrucción reduzca pendientes o que otra decisión salga. Un ciclo sin cambio hacia su terminación puede repetirse indefinidamente aunque compile sin errores.

En el segundo ejemplo pendientes recorre 3, 2, 1 y termina en 0. El valor 0 no se imprime porque se evalúa de nuevo la condición antes del cuerpo siguiente. Escribe cuándo ocurre cada paso; adivinar desde el último mensaje suele producir errores de una iteración.

### Distingue intervalo cerrado y semiabierto

De 1 hasta 5 incluyendo 5 hay cinco enteros. Desde 0 mientras n<5 también hay cinco vueltas, pero los valores son 0, 1, 2, 3, 4. Ese intervalo[0, 5) aparece al recorrer posiciones de contenedores en una unidad posterior. Sustituir< por<= añade una posición que podría no existir.

### Decide qué actualiza cada vuelta

El operador% calcula resto de división entera. n%2==0 identifica pares en estos enteros positivos. continue salta el resto del cuerpo y prosigue con la actualización del for. break abandona el ciclo más interno. Ninguno significa automáticamente terminar todo el programa.

La suma de pares hasta 6 es 2+4+6=12. No confundas cantidad de valores que cumplen (tres) con suma de esos valores(doce). Usa un contador si preguntas cuántos y otro acumulador si preguntas cuánto suman.

### Haz visible la terminación

Antes de ejecutar responde: ¿qué cambia?, ¿qué hará falsa la condición?, ¿cuántas vueltas espero? Nuestros límites son pequeños y representables. Un contador entero con signo tampoco puede aumentar indefinidamente sin considerar su rango. La corrección de una repetición incluye tanto su resultado como sus condiciones de parada.

## Ejemplo 1. Seguir un acumulador

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int main() {
    int suma{0};
    for (int valor{1}; valor <= 4; ++valor) {
        suma += valor;
        std::cout << "valor=" << valor << "; suma=" << suma << '\n';
    }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u04_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u04_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u04_e01.exe` |

Salida esperada:

```text
valor=1; suma=1
valor=2; suma=3
valor=3; suma=6
valor=4; suma=10
```

### Lectura paso a paso

Cada mensaje se produce después de actualizar suma. Por eso aparecen 1, 3, 6, 10 como acumulados. El contador valor tiene un papel diferente: recorre 1, 2, 3, 4. Distingue los dos estados en la traza.

## Ejemplo 2. Una condición de salida que cambia

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int main() {
    int pendientes{3};
    while (pendientes > 0) {
        std::cout << "Pendientes: " << pendientes << '\n';
        --pendientes;
    }
    int suma_pares{0};
    for (int n{1}; n <= 6; ++n) {
        if (n % 2 != 0) { continue; }
        suma_pares += n;
    }
    std::cout << "Suma de pares: " << suma_pares << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u04_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u04_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u04_e02.exe` |

Salida esperada:

```text
Pendientes: 3
Pendientes: 2
Pendientes: 1
Suma de pares: 12
```

### Lectura paso a paso

El while imprime antes de decrementar; al llegar a 0 termina. El for de pares utiliza continue para omitir impares y conservar 2, 4, 6. Cambiar el orden de impresión y actualización cambiaría la traza aunque el valor final pudiera coincidir.

## Experimenta

Mueve temporalmente suma=0 al cuerpo del primer ciclo y predice 1, 2, 3, 4 en lugar de acumulados. Después cambia el while para imprimir tras decrementar: predice 2, 1, 0. Recupera la versión original antes de comparar su salida comprobada.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Reiniciar el acumulador en cada vuelta | Inicializa fuera cuando debe conservar estado. |
| Usar&lt;= al recorrer posiciones[0, n) | Revisa la última posición válida. |
| Esperar que continue termine el programa | Solo omite el resto de esa vuelta del ciclo. |

## Autoevaluación

1. ¿Puede while ejecutar cero veces?
2. ¿Dónde inicializas una suma persistente?
3. ¿Qué diferencia break y continue?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad03-decisiones/README.md) · [Índice](../README.md) · [Siguiente](../unidad05-entrada/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2004%20%28Ciclos%2C%20acumuladores%20y%20trazas%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
