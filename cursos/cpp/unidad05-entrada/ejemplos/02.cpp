#include <iostream>
#include <string>
#include <sstream>

int main() {
    std::string linea;
    if (!std::getline(std::cin, linea)) {
        std::cerr << "No se recibió una línea\n";
        return 2;
    }
    std::istringstream lector{linea};
    int horas{0};
    if (!(lector >> horas)) {
        std::cerr << "Se requiere un entero\n";
        return 2;
    }
    lector >> std::ws;
    if (!lector.eof() || horas < 0 || horas > 40) {
        std::cerr << "Se requiere un entero completo entre 0 y 40\n";
        return 2;
    }
    std::cout << "Minutos: " << horas * 60 << '\n';
    return 0;
}
