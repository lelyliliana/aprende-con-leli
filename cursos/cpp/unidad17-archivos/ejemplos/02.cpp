#include <iostream>
#include <fstream>
#include <filesystem>
#include <string>

int main() {
    std::filesystem::create_directories("salidas");
    const std::filesystem::path ruta{"salidas/unidad17.txt"};
    {
        std::ofstream salida{ruta};
        if (!salida) { return 2; }
        salida << "Resumen de práctica\n";
        salida.close();
        if (!salida) { return 2; }
    }
    std::ifstream entrada{ruta};
    std::string linea;
    if (!std::getline(entrada, linea)) { return 2; }
    std::cout << "Leído de la salida: " << linea << '\n';
    return 0;
}
