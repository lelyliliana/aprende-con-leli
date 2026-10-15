#include <iostream>
#include <string>
#include <cstdint>

int main() {
    const double horas{1.75};
    const double minutos{horas * 60};
    std::cout << "Paso 1: " << minutos << " minutos\n";
    const std::string codigo{"007"};
    std::cout << "Paso 2: ID=" << codigo << '\n';
    std::cout << "Paso 3: 7/2=" << 7 / 2 << "; 7.0/2=" << 7.0 / 2 << '\n';
    const std::int64_t precio{1999};
    const std::int64_t cantidad{3};
    std::cout << "Reto: total=" << precio * cantidad << " centavos\n";
    return 0;
}
