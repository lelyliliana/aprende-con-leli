#include <iostream>
#include <string>

int main() {
    const std::string codigo{"S01-A"};
    bool valido{!codigo.empty()};
    for (const char c : codigo) {
        const bool permitido{(c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '-'};
        if (!permitido) { valido = false; }
    }
    std::cout << std::boolalpha << "Código ASCII admitido: " << valido << '\n';
    std::cout << "Mayúsculas y minúsculas son distintas: " << (std::string{"A"} != "a") << '\n';
    return 0;
}
