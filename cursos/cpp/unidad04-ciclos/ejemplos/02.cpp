#include <iostream>

int main() {
    int pendientes{3};
    while (pendientes > 0) {
        std::cout << "Pendientes: " << pendientes << '\n';
        --pendientes;
    }
    int suma_pares{0};
    for (int n{1}; n <= 6; ++n) {
        if (n % 2 != 0) { continue; }
        suma_pares += n;
    }
    std::cout << "Suma de pares: " << suma_pares << '\n';
    return 0;
}
