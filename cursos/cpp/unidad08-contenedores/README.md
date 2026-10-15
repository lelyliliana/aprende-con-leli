# Unidad 08. std::array y std::vector

[Anterior](../unidad07-texto/README.md) · [Índice](../README.md) · [Siguiente](../unidad09-algoritmos/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Resumir una colección.
- Seleccionar sin borrar.
- Modificar la copia.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Un contenedor reúne elementos con una estructura

`std::array<int, 3>` fija su número de elementos en el tipo. `std::vector<int>` conserva enteros y puede cambiar de tamaño. Ambos gestionan sus elementos; no necesitas crear manualmente una zona de memoria con new para comenzar a trabajar con una colección.

### Distingue tamaño y capacidad

size informa cuántos elementos existen. En un vector, capacity expresa espacio reservado para elementos antes de necesitar otra reasignación. Reservar capacidad no crea elementos. No accedas a la posición 5 porque reserve(10) haya preparado espacio: si size es 2, solo existen posiciones 0 y 1.

En el primer ejemplo horas comienza con 2, 4 y push_back añade 6. El tamaño pasa a 3. El array conserva sus tres elementos desde la inicialización y no tiene push_back. La elección depende de si tu cantidad de elementos está fijada como parte de la estructura o si necesitas crecer.

### Recorre valores y referencias conscientemente

for(const int valor: horas) recibe una cantidad de cada elemento y permite sumar sin modificar la entrada. for(int& valor: cantidades) vincula una referencia a cada entero y permite cambiarlo. Esa diferencia retoma paso por valor y referencia de funciones: el símbolo & no es decorativo.

| Operación | Colección antes | Colección después |
|---|---|---|
| Copiar un valor en el ciclo | 2, 4, 6 | 2, 4, 6 |
| Duplicar por referencia | 2, 4, 6 | 4, 8, 12 |
| push_back de 8 | 2, 4, 6 | 2, 4, 6, 8 |

### Comprueba posiciones antes de acceder

Un contenedor de tamaño 3 tiene posiciones 0, 1, 2. at comprueba rango y puede lanzar una excepción si lo incumples; esa gestión se desarrolla en la Unidad 11. El segundo ejemplo valida el índice antes de llamar at. operator[] exige que tú respetes su precondición y no se utiliza para ensayar posiciones inválidas.

Un vector vacío tiene size 0 y no tiene un primer elemento para leer. El rango de índices se expresa con indice&lt;size, sin necesidad de restar 1 a un tamaño sin signo. Esa resta en un contenedor vacío podría introducir otra confusión de representación.

### Una modificación puede afectar observadores

Cuando un vector crece puede cambiar la ubicación de sus elementos y dejar inválidas referencias, punteros e iteradores que guardaste antes. No modifiques su tamaño dentro de un recorrido que depende de esos observadores sin estudiar sus reglas de invalidación. Primero termina la modificación y después obtén un observador actualizado; la vida útil tendrá una explicación específica.

### Conserva la identidad cuando selecciones

En esta unidad solo hay cantidades. Una copia seleccionada conserva esos valores pero no información adicional sobre personas o materiales. Cuando cada cantidad tenga un código, guárdalos juntos en registros. Ordenar o sustraer vectores separados por posición puede perder esa correspondencia, aunque sus tamaños coincidan.

## Ejemplo 1. Elegir tamaño fijo o dinámico

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <array>
#include <vector>

int main() {
    const std::array<int, 3> fijas{2, 4, 6};
    std::vector<int> horas{2, 4};
    horas.push_back(6);
    int suma{0};
    for (const int valor : horas) { suma += valor; }
    std::cout << "Tamaño fijo: " << fijas.size() << '\n';
    std::cout << "Vector: " << horas.size() << "; suma=" << suma << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u08_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u08_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u08_e01.exe` |

Salida esperada:

```text
Tamaño fijo: 3
Vector: 3; suma=12
```

### Lectura paso a paso

El array tiene 3 elementos y el vector también después de añadir 6. La suma del vector es 12. La operación de suma no cambia horas; push_back sí había cambiado su tamaño. Son efectos distintos que puedes seguir con size y contenido.

## Ejemplo 2. Índices y modificación por referencia

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <cstddef>
#include <iostream>
#include <vector>

int main() {
    std::vector<int> cantidades{2, 4, 6};
    for (int& valor : cantidades) { valor *= 2; }
    std::cout << "Primero: " << cantidades.at(0) << "; último: " << cantidades.at(2) << '\n';
    const std::size_t indice{3};
    if (indice < cantidades.size()) {
        std::cout << cantidades.at(indice) << '\n';
    } else {
        std::cout << "Índice 3 rechazado: solo existen 0,1,2\n";
    }
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u08_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u08_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u08_e02.exe` |

Salida esperada:

```text
Primero: 4; último: 12
Índice 3 rechazado: solo existen 0,1,2
```

### Lectura paso a paso

Las referencias del ciclo duplican cantidades. at(0) vale 4 y at(2) vale 12. El índice 3 se rechaza mediante una decisión previa y no se desreferencia una posición inválida. El mensaje no procede de ejecutar comportamiento indefinido.

## Experimenta

Compara un ciclo por valor que multiplique su copia y otro por referencia. Predice en cuál cambia el vector. Luego utiliza un vector vacío y decide si existe índice 0 antes de acceder; no lo pruebes con operator[] para «ver qué pasa».

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Confundir reserve con resize | Capacidad no significa elementos construidos. |
| Usar&lt;=size para el último índice | La última posición existente es anterior a size. |
| Guardar referencias atravesando un crecimiento | Revisa invalidación y vuelve a obtener observadores tras modificar. |

## Autoevaluación

1. ¿reserve crea elementos?
2. ¿Qué índices existen con size 3?
3. ¿Puede push_back invalidar referencias?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad07-texto/README.md) · [Índice](../README.md) · [Siguiente](../unidad09-algoritmos/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2008%20%28std%3A%3Aarray%20y%20std%3A%3Avector%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
