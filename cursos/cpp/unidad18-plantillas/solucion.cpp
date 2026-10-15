#include <iostream>
#include <concepts>

template<std::integral T>
T mayor(T a, T b) { return a < b ? b : a; }

int main() {
    std::cout << "Paso 1: mayor=" << mayor(4, 9) << '\n';
    std::cout << "Paso 2: empate=" << mayor(5, 5) << '\n';
    static_assert(!std::integral<double>);
    std::cout << "Paso 3: double fuera del concepto integral\n";
    const long a{12};
    const long b{7};
    std::cout << "Reto: misma plantilla con long=" << mayor(a, b) << '\n';
    return 0;
}
