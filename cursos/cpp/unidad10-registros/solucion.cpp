#include <iostream>
#include <string>
#include <vector>

struct Producto { std::string codigo; int cantidad; int precio_centavos; };
enum class Estado { disponible, prestado };

int main() {
    const Producto sensor{"S01", 2, 1500};
    std::cout << "Paso 1: ID=" << sensor.codigo << '\n';
    std::cout << "Paso 2: subtotal=" << sensor.cantidad * sensor.precio_centavos << '\n';
    const Estado estado{Estado::disponible};
    std::cout << std::boolalpha << "Paso 3: disponible=" << (estado == Estado::disponible) << '\n';
    const std::vector<Producto> todos{sensor, {"S02", 3, 2000}};
    int total{0};
    for (const auto& p : todos) { total += p.cantidad * p.precio_centavos; }
    std::cout << "Reto: total=" << total << " centavos\n";
    return 0;
}
