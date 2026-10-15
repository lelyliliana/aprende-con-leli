#include <iostream>
#include <string>

int main() {
    const std::string codigo{"007"};
    const std::string linea{"S01;5"};
    const auto posicion{linea.find(';')};
    if (posicion == std::string::npos) { return 1; }
    std::cout << "ID: " << codigo << "; bytes: " << codigo.size() << '\n';
    std::cout << "Antes: " << linea.substr(0, posicion) << '\n';
    std::cout << "Después: " << linea.substr(posicion + 1) << '\n';
    return 0;
}
