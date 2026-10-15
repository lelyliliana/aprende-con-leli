#include "inventario.hpp"
#include <iostream>
#include <stdexcept>
#include <vector>

int main() {
    const std::vector<inventario::Producto> productos{ {"S01", 2, 1500}, {"S01", 3, 1500}};
    try { inventario::validar(productos); return 1; }
    catch (const std::invalid_argument&) { std::cout << "ID duplicado rechazado antes del resumen\n"; }
    return 0;
}
