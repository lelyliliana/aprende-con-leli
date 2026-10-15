# Unidad 06. Funciones, parámetros y referencias

[Anterior](../unidad05-entrada/README.md) · [Índice](../README.md) · [Siguiente](../unidad07-texto/README.md)

[Práctica paso a paso](PRACTICA.md) · [Soluciones](SOLUCIONES.md)

## Objetivos y preparación

Al terminar podrás:

- Devolver una conversión.
- Conservar la entrada.
- Modificar de forma explícita.

Estudia primero la unidad anterior. Los ejemplos incorporan las herramientas ya presentadas y las nuevas se explican antes de usarlas. Todos los comandos parten de cursos/cpp.

## Una función recibe, transforma y devuelve

minutos recibe una cantidad de horas y devuelve otra cantidad. La definición int minutos(int horas) declara tipo de salida, nombre y parámetro. return horas*60 entrega el resultado al lugar de la llamada. Definir una función no ejecuta todavía el cálculo; minutos(2) sí realiza una llamada con argumento 2.

### Declara antes de utilizar

En este ejemplo la definición aparece antes de main para que el compilador conozca su firma al encontrar la llamada. En una unidad posterior separaremos declaraciones en cabeceras y definiciones en fuentes. No copies una función dentro de otra esperando que esa sea la organización habitual de C++.

### Mostrar no equivale a devolver

Una función int debe entregar el resultado correspondiente en sus caminos normales. Una función void no entrega una cantidad como resultado. Escribir en cout puede ser un efecto útil, pero no hace que el número mostrado esté disponible para otra operación. En minutos, la salida se devuelve; main decide cómo presentarla.

| Parte | Papel en minutos(2) |
|---|---|
| Parámetro horas | Nombre de la entrada dentro de la función |
| Argumento 2 | Valor de esta llamada |
| Cálculo | 2×60 |
| Resultado devuelto | 120 |

### Pasar por valor crea otra variable

int copia recibe una copia de la cantidad. Incrementarla cambia esa variable local y no el entero original. En el segundo ejemplo el mensaje de copia local muestra 5, mientras el objeto exterior sigue 4. Si necesitas conservar un resultado nuevo sin modificar la entrada, devuélvelo y guárdalo con otro nombre.

### Una referencia permite compartir el mismo objeto

int& cantidad vincula el parámetro con el entero que recibió la llamada. Modificarlo cambia ese objeto. No es una copia ni un puntero que pueda redirigirse a otro objeto después. Un parámetro de salida por referencia debe comunicar claramente que modifica; para una transformación sencilla, suele ser más claro devolver un resultado.

const std::string& permite consultar un texto sin copiarlo en ese parámetro y sin modificarlo a través de esa referencia. La referencia no es propietaria: necesita que el objeto referido siga existiendo. La vida útil tendrá una unidad propia; desde ahora no devuelvas referencias a variables locales que van a terminar.

### Alcance y contratos

Una variable local pertenece a su bloque y su nombre no aparece automáticamente en main. Evita funciones cuyo cálculo dependa de objetos globales modificados antes. Declara entradas, resultado, dominio y efectos. minutos usa enteros pequeños de práctica; no pretende validar cualquier magnitud o detectar todos los posibles desbordamientos.

La firma comunica parte del contrato, pero no expresa por sí sola que horas deba estar entre 0 y 40. Combina validación y tipo con una explicación del problema. La función que hace una cosa pequeña puede probarse y reutilizarse antes de mezclar captura, archivo y presentación.

## Ejemplo 1. Devolver un resultado

[Programa completo](ejemplos/01.cpp) · [Salida comprobada](ejemplos/01.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>

int minutos(int horas) {
    return horas * 60;
}

int main() {
    const int resultado{minutos(2)};
    std::cout << "Minutos: " << resultado << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u06_e01
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u06_e01` |
| Windows (terminal de desarrollo) | `.\build\bin\u06_e01.exe` |

Salida esperada:

```text
Minutos: 120
```

### Lectura paso a paso

La definición se registra antes de main. resultado conserva 120 y cout lo muestra. Cambiar el argumento a 3 cambia la entrada de una llamada, no la definición. Una función puede llamarse varias veces con entradas distintas.

## Ejemplo 2. Valor, referencia y referencia constante

[Programa completo](ejemplos/02.cpp) · [Salida comprobada](ejemplos/02.txt)

Predice la salida antes de ejecutar. Este archivo tiene su propio main y se construye como una meta independiente.

```cpp
#include <iostream>
#include <string>

void intentar_cambiar(int copia) {
    copia += 1;
    std::cout << "Copia local: " << copia << '\n';
}
void aumentar(int& cantidad) { cantidad += 1; }
void mostrar(const std::string& codigo) { std::cout << "ID: " << codigo << '\n'; }

int main() {
    int cantidad{4};
    intentar_cambiar(cantidad);
    std::cout << "Tras pasar por valor: " << cantidad << '\n';
    aumentar(cantidad);
    std::cout << "Tras referencia: " << cantidad << '\n';
    const std::string codigo{"S01"};
    mostrar(codigo);
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u06_e02
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u06_e02` |
| Windows (terminal de desarrollo) | `.\build\bin\u06_e02.exe` |

Salida esperada:

```text
Copia local: 5
Tras pasar por valor: 4
Tras referencia: 5
ID: S01
```

### Lectura paso a paso

intentar_cambiar imprime su copia 5; el original sigue 4. aumentar recibe una referencia y lo deja 5. mostrar recibe una referencia constante al código. La diferencia de comportamiento está en las firmas y los efectos del cuerpo, no en el nombre que tenga cada parámetro.

## Experimenta

Construye dos llamadas minutos(1) y minutos(3) y predice 60 y 180. Después compara una función que devuelve cantidad+1 con otra que recibe int& y la modifica. Dibuja qué objeto observa cada nombre.

## Errores frecuentes

| Señal o confusión | Revisión concreta |
|---|---|
| Definir y esperar que ya se ejecute | Añade una llamada con argumentos. |
| Confundir un print con un valor devuelto | Separa cálculo retornado y presentación. |
| Devolver una referencia a un local | Devuelve un valor que conserve su vida útil correctamente. |

## Autoevaluación

1. ¿Qué distingue argumento y parámetro?
2. ¿void devuelve una cantidad?
3. ¿Qué cambia con int&?

Responde antes de consultar las soluciones. Justifica con una entrada y un recorrido, no solo con el nombre de una instrucción.

## Antes de avanzar

- [ ] Predije y expliqué los resultados del material de esta unidad.
- [ ] Completé los tres pasos y el reto, conservando mis intentos.
- [ ] Puedo distinguir un caso admitido de uno que debe rechazarse.
- [ ] Puedo explicar qué cambia y qué se conserva en cada operación.

[Anterior](../unidad05-entrada/README.md) · [Índice](../README.md) · [Siguiente](../unidad07-texto/README.md)

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2006%20%28Funciones%2C%20par%C3%A1metros%20y%20referencias%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
