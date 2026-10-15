#include <cstddef>
#include <iostream>
#include <array>
#include <stdexcept>

int doble(int n) { return n * 2; }
void exigir(bool condicion) { if (!condicion) { throw std::runtime_error{"No se cumple"}; } }

int main() {
    exigir(doble(3) == 6);
    std::cout << "Paso 1: caso normal comprobado\n";
    exigir(doble(0) == 0);
    std::cout << "Paso 2: límite cero comprobado\n";
    const std::array<int, 3> entradas{-2, 1, 4};
    const std::array<int, 3> esperados{-4, 2, 8};
    for (std::size_t i{0}; i < entradas.size(); ++i) { exigir(doble(entradas.at(i)) == esperados.at(i)); }
    std::cout << "Paso 3: tres casos adicionales comprobados\n";
    try { exigir(false); return 1; }
    catch (const std::runtime_error&) { std::cout << "Reto: una comprobación falsa produce fallo\n"; }
    return 0;
}
