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
