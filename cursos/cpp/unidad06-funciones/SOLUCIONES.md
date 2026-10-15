# Soluciones razonadas de la Unidad 06

[Lección](README.md) · [Práctica](PRACTICA.md)

Consulta cada sección después de intentar su paso. Si tu salida difiere, revisa entrada, reglas y recorrido antes de cambiar una expectativa.

## Paso 1. Devolver una conversión

La función devuelve 180; main lo muestra. No es necesario que minutos escriba en cout para que su cálculo sea accesible.

## Paso 2. Conservar la entrada

sumar_uno devuelve 6 y stock sigue 5. Se compara entrada y resultado, que tienen funciones distintas.

## Paso 3. Modificar de forma explícita

La modificación permanece después de la llamada porque no se realizó sobre una copia. Este efecto debe constar en el contrato.

## Reto de transferencia. Consultar texto sin modificarlo

La etiqueta es "Código: S01" con su espacio de presentación. El original permanece; la referencia constante evita modificarlo mediante ese parámetro y no transfiere su propiedad.

## Respuestas de autoevaluación

1. **¿Qué distingue argumento y parámetro?** El argumento es la entrada concreta de la llamada; el parámetro es el nombre en la definición.
2. **¿void devuelve una cantidad?** No; puede realizar efectos pero no entrega un valor de retorno de ese tipo.
3. **¿Qué cambia con int&?** La función puede modificar el objeto vinculado, en vez de una copia local.

## Programa completo de solución

[Fuente](solucion.cpp) · [Salida comprobada](solucion.txt)

Los tres pasos y el reto están identificados en su salida. La explicación escrita completa las tareas de interpretación y las observaciones del entorno.

```cpp
#include <iostream>
#include <string>

int minutos(int horas) { return horas * 60; }
int sumar_uno(int cantidad) { return cantidad + 1; }
void aumentar(int& cantidad) { cantidad += 1; }
std::string etiqueta(const std::string& codigo) { return "Código: " + codigo; }

int main() {
    std::cout << "Paso 1: " << minutos(3) << " minutos\n";
    int stock{5};
    const int copia{sumar_uno(stock)};
    std::cout << "Paso 2: original=" << stock << "; copia=" << copia << '\n';
    aumentar(stock);
    std::cout << "Paso 3: referencia actualiza stock=" << stock << '\n';
    const std::string codigo{"S01"};
    std::cout << "Reto: " << etiqueta(codigo) << '\n';
    return 0;
}
```

Construye esta meta desde la raíz del curso, después de configurar el entorno:

```text
cmake --build build --config Debug --target u06_sol
```

| Sistema | Ejecutar desde cursos/cpp |
|---|---|
| Linux/macOS | `./build/bin/u06_sol` |
| Windows (terminal de desarrollo) | `.\build\bin\u06_sol.exe` |

Salida esperada:

```text
Paso 1: 180 minutos
Paso 2: original=5; copia=6
Paso 3: referencia actualiza stock=6
Reto: Código: S01
```

---

### ¿Necesitas apoyo con este tema?

Puedes estudiar con el material completo a tu ritmo. Si necesitas resolver una duda o adaptar el tema a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Consultar asesoría por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20la%20Unidad%2006%20%28Funciones%2C%20par%C3%A1metros%20y%20referencias%29%20del%20curso%20C%2B%2B%20desde%20cero%20y%20necesito%20asesor%C3%ADa.%20Mi%20duda%20es%E2%80%A6)
