#include <iostream>
#include <concepts>

template<std::integral T>
T mayor(T a, T b) { return a < b ? b : a; }

int main() {
    std::cout << "Mayor entero: " << mayor(3, 7) << '\n';
    static_assert(std::integral<int>);
    static_assert(!std::integral<double>);
    return 0;
}
