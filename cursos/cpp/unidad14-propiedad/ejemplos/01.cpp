#include <iostream>
#include <memory>
#include <utility>

int main() {
    auto primero{std::make_unique<int>(7)};
    auto segundo{std::move(primero)};
    std::cout << std::boolalpha << "Origen vacío: " << (!primero) << '\n';
    std::cout << "Destino: " << *segundo << '\n';
    return 0;
}
