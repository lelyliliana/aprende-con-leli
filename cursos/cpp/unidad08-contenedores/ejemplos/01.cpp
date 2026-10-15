#include <iostream>
#include <array>
#include <vector>

int main() {
    const std::array<int, 3> fijas{2, 4, 6};
    std::vector<int> horas{2, 4};
    horas.push_back(6);
    int suma{0};
    for (const int valor : horas) { suma += valor; }
    std::cout << "Tamaño fijo: " << fijas.size() << '\n';
    std::cout << "Vector: " << horas.size() << "; suma=" << suma << '\n';
    return 0;
}
