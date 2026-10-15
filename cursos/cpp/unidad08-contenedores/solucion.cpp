#include <iostream>
#include <vector>
#include <array>

int main() {
    std::vector<int> x{2, 4, 6, 8};
    int suma{0};
    for (const int valor : x) { suma += valor; }
    std::cout << "Paso 1: tamaño=" << x.size() << "; suma=" << suma << '\n';
    std::vector<int> seleccion;
    for (const int valor : x) { if (valor >= 6) { seleccion.push_back(valor); } }
    std::cout << "Paso 2: seleccionados=" << seleccion.at(0) << ',' << seleccion.at(1) << '\n';
    for (int& valor : seleccion) { valor *= 2; }
    std::cout << "Paso 3: copia=" << seleccion.at(0) << ',' << seleccion.at(1) << "; original=" << x.at(2) << ',' << x.at(3) << '\n';
    const std::array<int, 2> limites{0, 40};
    std::cout << "Reto: intervalo fijo=" << limites.at(0) << ',' << limites.at(1) << '\n';
    return 0;
}
