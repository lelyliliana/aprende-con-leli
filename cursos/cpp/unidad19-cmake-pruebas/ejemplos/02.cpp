#include <iostream>
#include <array>
#include <stdexcept>

struct Caso { int entrada; bool esperado; };

int main() {
    const std::array<Caso, 4> casos{{{0, true}, {40, true}, {-1, false}, {41, false}}};
    for (const auto& caso : casos) {
        const bool admitido{caso.entrada >= 0 && caso.entrada <= 40};
        if (admitido != caso.esperado) { throw std::runtime_error{"Caso no coincide"}; }
    }
    std::cout << "Cuatro casos: dos límites admitidos y dos rechazos\n";
    return 0;
}
