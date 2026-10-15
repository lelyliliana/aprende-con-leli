#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

int main() {
    const std::vector<int> original{8, 2, 6, 4};
    auto ordenada{original};
    std::sort(ordenada.begin(), ordenada.end());
    std::cout << "Paso 1: orden=";
    for (const int x : ordenada) { std::cout << x << ' '; }
    std::cout << '\n';
    const auto p{std::find(ordenada.begin(), ordenada.end(), 6)};
    if (p == ordenada.end()) { return 1; }
    std::cout << "Paso 2: encontrado=" << *p << '\n';
    const auto cantidad{std::count_if(ordenada.begin(), ordenada.end(), [](int x) { return x >= 6; })};
    std::cout << "Paso 3: cumplen=" << cantidad << '\n';
    std::cout << "Reto: suma=" << std::accumulate(ordenada.begin(), ordenada.end(), 0) << "; original primero=" << original.at(0) << '\n';
    return 0;
}
