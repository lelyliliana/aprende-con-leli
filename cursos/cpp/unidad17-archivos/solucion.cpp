#include <iostream>
#include <fstream>
#include <filesystem>
#include <string>

int main() {
    std::ifstream entrada{"datos/lectura.txt"};
    if (!entrada) { return 2; }
    std::string linea;
    int filas{0};
    while (std::getline(entrada, linea)) { ++filas; }
    if (!entrada.eof()) { return 2; }
    std::cout << "Paso 1: líneas=" << filas << '\n';
    std::filesystem::create_directories("salidas");
    const std::filesystem::path ruta{"salidas/practica17.txt"};
    std::ofstream salida{ruta};
    if (!salida) { return 2; }
    salida << filas << '\n';
    salida.close();
    if (!salida) { return 2; }
    std::cout << "Paso 2: resultado escrito\n";
    std::ifstream copia{ruta};
    int recuperado{0};
    if (!(copia >> recuperado) || recuperado != filas) { return 2; }
    std::cout << "Paso 3: resultado releído=" << recuperado << '\n';
    const std::filesystem::path parte{"salidas"};
    const auto compuesta{parte / "practica17.txt"};
    std::cout << std::boolalpha << "Reto: ruta compuesta coincide=" << (compuesta == ruta) << '\n';
    return 0;
}
