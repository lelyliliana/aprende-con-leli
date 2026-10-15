#include <iostream>
#include <memory>
#include <vector>

int main() {
    std::vector<std::unique_ptr<int>> valores;
    valores.push_back(std::make_unique<int>(3));
    valores.push_back(std::make_unique<int>(5));
    int suma{0};
    for (const auto& propietario : valores) { suma += *propietario; }
    std::cout << "Propietarios: " << valores.size() << "; suma=" << suma << '\n';
    return 0;
}
