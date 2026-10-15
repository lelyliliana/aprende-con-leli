#include "inventario.hpp"
#include <iostream>
#include <filesystem>
int main() {
    const auto datos{inventario::leer("datos/inventario.csv")};
    std::filesystem::create_directories("salidas/construccion");
    inventario::escribir("salidas/construccion/reporte.csv", datos);
    std::cout << "Etapa 4: reporte generado sin cambiar la entrada\n";
    return 0;
}
