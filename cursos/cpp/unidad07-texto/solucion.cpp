#include <iostream>
#include <string>

int main() {
    const std::string codigo{"007"};
    std::cout << "Paso 1: " << codigo << " conserva " << codigo.size() << " bytes ASCII\n";
    const std::string linea{"S01;12"};
    const auto p{linea.find(';')};
    if (p == std::string::npos) { return 1; }
    std::cout << "Paso 2: " << linea.substr(0, p) << " / " << linea.substr(p + 1) << '\n';
    const std::string sin_separador{"S01"};
    std::cout << std::boolalpha << "Paso 3: separador ausente=" << (sin_separador.find(';') == std::string::npos) << '\n';
    const std::string invalido{"S 01"};
    bool valido{!invalido.empty()};
    for (const char c : invalido) {
        if (!((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '-')) { valido = false; }
    }
    std::cout << "Reto: código con espacio admitido=" << valido << '\n';
    return valido ? 1 : 0;
}
