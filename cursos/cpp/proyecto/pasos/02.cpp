#include "inventario.hpp"
#include <iostream>
int main() {
    const auto datos{inventario::leer("datos/inventario.csv")};
    const auto valor{inventario::total(datos)};
    std::cout << "Etapa 2: " << valor << " centavos\n";
    return 0;
}
