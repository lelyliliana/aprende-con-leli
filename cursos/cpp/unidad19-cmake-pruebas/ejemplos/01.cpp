#include <iostream>
#include <stdexcept>

int doble(int n) { return n * 2; }
void exigir(bool condicion, const char* mensaje) {
    if (!condicion) { throw std::runtime_error{mensaje}; }
}

int main() {
    exigir(doble(3) == 6, "Caso normal");
    exigir(doble(0) == 0, "Caso cero");
    exigir(doble(-2) == -4, "Caso negativo");
    std::cout << "Tres comprobaciones activas también en Release\n";
    return 0;
}
