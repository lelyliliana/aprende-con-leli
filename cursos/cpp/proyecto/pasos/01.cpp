#include "inventario.hpp"
#include <iostream>
int main() {
    const auto datos{inventario::leer("datos/inventario.csv")};
    std::cout << "Etapa 1: " << datos.size() << " productos validados\n";
    return 0;
}
