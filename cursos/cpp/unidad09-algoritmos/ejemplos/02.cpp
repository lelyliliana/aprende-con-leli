#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

int main() {
    const std::vector<int> horas{2, 6, 4, 8};
    const int umbral{5};
    const auto cumple{[umbral](int valor) { return valor >= umbral; }};
    const auto cantidad{std::count_if(horas.begin(), horas.end(), cumple)};
    const int suma{std::accumulate(horas.begin(), horas.end(), 0)};
    std::cout << "Al menos 5: " << cantidad << "; suma=" << suma << '\n';
    return 0;
}
