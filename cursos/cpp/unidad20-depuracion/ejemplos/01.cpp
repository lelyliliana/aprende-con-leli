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
    const std::vector<int> ordenados{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    const auto a{lineal(ordenados, 14)};
    const auto b{binaria(ordenados, 14)};
    if (!a.encontrado || !b.encontrado) { return 1; }
    std::cout << "Lineal: " << a.comparaciones << " posiciones examinadas\n";
    std::cout << "Binaria: " << b.comparaciones << " posiciones examinadas\n";
    return 0;
}
