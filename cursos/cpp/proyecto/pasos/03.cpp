#include "inventario.hpp"
#include <iostream>
#include <algorithm>
int main() {
    auto datos{inventario::leer("datos/inventario.csv")};
    std::sort(datos.begin(), datos.end(), [](const auto& a, const auto& b) { return a.codigo < b.codigo; });
    for (const auto& p : datos) { std::cout << p.codigo << ";" << p.cantidad * p.precio_centavos << "\n"; }
    return 0;
}
