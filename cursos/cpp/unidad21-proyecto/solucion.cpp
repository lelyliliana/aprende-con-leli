#include "inventario.hpp"
#include <iostream>
#include <stdexcept>
#include <vector>

int main() {
    const auto productos{inventario::leer("datos/inventario.csv")};
    std::cout << "Paso 1: registros=" << productos.size() << '\n';
    const auto valor{inventario::total(productos)};
    std::cout << "Paso 2: total=" << valor << " centavos\n";
    auto copia{productos};
    copia.at(0).cantidad = -1;
    try { inventario::validar(copia); return 1; }
    catch (const std::invalid_argument&) { std::cout << "Paso 3: cantidad negativa rechazada\n"; }
    const auto de_nuevo{inventario::leer("datos/inventario.csv")};
    if (inventario::total(de_nuevo) != valor) { return 1; }
    std::cout << "Reto: fuente conservada y cálculo repetible\n";
    return 0;
}
