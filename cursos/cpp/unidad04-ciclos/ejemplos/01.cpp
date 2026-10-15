#include <iostream>

int main() {
    int suma{0};
    for (int valor{1}; valor <= 4; ++valor) {
        suma += valor;
        std::cout << "valor=" << valor << "; suma=" << suma << '\n';
    }
    return 0;
}
