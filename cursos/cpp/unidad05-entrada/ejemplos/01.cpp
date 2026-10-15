#include <iostream>
#include <string>

int main() {
    std::string nombre;
    if (!std::getline(std::cin, nombre)) {
        std::cerr << "No se recibió una línea\n";
        return 2;
    }
    std::cout << "Hola, " << nombre << '\n';
    return 0;
}
