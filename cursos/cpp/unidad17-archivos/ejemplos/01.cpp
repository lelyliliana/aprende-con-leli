#include <iostream>
#include <fstream>
#include <string>

int main() {
    std::ifstream entrada{"datos/lectura.txt"};
    if (!entrada) { std::cerr << "No se pudo abrir datos/lectura.txt\n"; return 2; }
    std::string linea;
    int filas{0};
    while (std::getline(entrada, linea)) {
        if (!linea.empty() && linea.back() == '\r') { linea.pop_back(); }
        ++filas;
        std::cout << filas << ": " << linea << '\n';
    }
    if (!entrada.eof()) { std::cerr << "Lectura interrumpida\n"; return 2; }
    return 0;
}
