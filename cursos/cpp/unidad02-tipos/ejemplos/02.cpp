#include <iostream>
#include <iomanip>
#include <cstdint>

int main() {
    const int total{7};
    const int personas{2};
    const std::int64_t precio_centavos{1250};
    std::cout << "División entera: " << total / personas << '\n';
    std::cout << std::fixed << std::setprecision(1);
    std::cout << "División decimal: " << static_cast<double>(total) / personas << '\n';
    std::cout << "Tres unidades en centavos: " << precio_centavos * 3 << '\n';
    return 0;
}
