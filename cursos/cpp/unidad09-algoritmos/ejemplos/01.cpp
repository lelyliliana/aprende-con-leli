#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    const std::vector<int> original{8, 2, 6, 4};
    auto ordenada{original};
    std::sort(ordenada.begin(), ordenada.end());
    for (const int valor : ordenada) { std::cout << valor << ' '; }
    std::cout << '\n';
    const auto encontrado{std::find(ordenada.begin(), ordenada.end(), 6)};
    if (encontrado != ordenada.end()) { std::cout << "Encontrado: " << *encontrado << '\n'; }
    std::cout << "Original primero: " << original.at(0) << '\n';
    return 0;
}
