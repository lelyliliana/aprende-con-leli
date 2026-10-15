#include <iostream>
#include <string>
#include <vector>

struct Producto {
    std::string codigo;
    int cantidad;
    int precio_centavos;
};

int main() {
    const std::vector<Producto> productos{ {"S01", 2, 1500}, {"S02", 3, 2000}};
    for (const auto& p : productos) {
        std::cout << p.codigo << ": " << p.cantidad * p.precio_centavos << " centavos\n";
    }
    return 0;
}
