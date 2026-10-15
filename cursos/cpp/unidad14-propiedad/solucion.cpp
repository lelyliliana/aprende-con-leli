#include <iostream>
#include <memory>
#include <utility>
#include <vector>

int main() {
    auto a{std::make_unique<int>(9)};
    std::cout << "Paso 1: valor=" << *a << '\n';
    auto b{std::move(a)};
    std::cout << std::boolalpha << "Paso 2: origen vacío=" << (!a) << '\n';
    std::cout << "Paso 3: destino=" << *b << '\n';
    std::vector<std::unique_ptr<int>> lista;
    lista.push_back(std::move(b));
    lista.push_back(std::make_unique<int>(1));
    int suma{0};
    for (const auto& p : lista) { suma += *p; }
    std::cout << "Reto: propietarios=" << lista.size() << "; suma=" << suma << '\n';
    return 0;
}
