#include "inventario.hpp"
#include <iostream>

int main() {
    const auto productos{inventario::leer("datos/inventario.csv")};
    std::cout << "Registros: " << productos.size() << '\n';
    std::cout << "Total: " << inventario::total(productos) << " centavos\n";
    return 0;
}
