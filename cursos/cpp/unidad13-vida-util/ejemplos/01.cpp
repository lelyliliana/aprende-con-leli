#include <iostream>

int main() {
    int cantidad{5};
    int* observador{&cantidad};
    if (observador != nullptr) { *observador = 7; }
    std::cout << "Cantidad: " << cantidad << '\n';
    observador = nullptr;
    std::cout << std::boolalpha << "Sin objeto observado: " << (observador == nullptr) << '\n';
    return 0;
}
