#include <iostream>
#include <vector>

int main() {
    int cantidad{5};
    int& alias{cantidad};
    alias = 6;
    std::cout << "Paso 1: referencia=" << cantidad << '\n';
    int* p{&cantidad};
    if (p != nullptr) { *p = 7; }
    std::cout << "Paso 2: observador=" << cantidad << '\n';
    p = nullptr;
    std::cout << std::boolalpha << "Paso 3: puntero vacío=" << (p == nullptr) << '\n';
    std::vector<int> valores{1, 2};
    valores.push_back(3);
    const int* actual{&valores.at(0)};
    std::cout << "Reto: observador obtenido después de modificar vector=" << *actual << '\n';
    return 0;
}
