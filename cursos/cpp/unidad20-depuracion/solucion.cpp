#include <iostream>
#include <vector>
#include <cstddef>

struct Resultado { bool encontrado; std::size_t comparaciones; };
Resultado lineal(const std::vector<int>& valores, int objetivo) {
    std::size_t comparaciones{0};
    for (const int valor : valores) {
        ++comparaciones;
        if (valor == objetivo) { return {true, comparaciones}; }
    }
    return {false, comparaciones};
}
Resultado binaria(const std::vector<int>& valores, int objetivo) {
    std::size_t inicio{0};
    std::size_t fin{valores.size()};
    std::size_t comparaciones{0};
    while (inicio < fin) {
        const auto medio{inicio + (fin - inicio) / 2};
        ++comparaciones;
        if (valores.at(medio) == objetivo) { return {true, comparaciones}; }
        if (valores.at(medio) < objetivo) { inicio = medio + 1; }
        else { fin = medio; }
    }
    return {false, comparaciones};
}

int main() {
    const std::vector<int> datos{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    const auto a{lineal(datos, 14)};
    const auto b{binaria(datos, 14)};
    std::cout << "Paso 1: lineal=" << a.comparaciones << '\n';
    std::cout << "Paso 2: binaria=" << b.comparaciones << '\n';
    if (a.encontrado != b.encontrado) { return 1; }
    std::cout << "Paso 3: ambas encuentran el objetivo\n";
    const auto ausente{binaria(datos, 20)};
    std::cout << std::boolalpha << "Reto: objetivo ausente encontrado=" << ausente.encontrado << '\n';
    return ausente.encontrado ? 1 : 0;
}
