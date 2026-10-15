#include <iostream>

int main() {
    const char opcion{'B'};
    switch (opcion) {
        case 'A': std::cout << "Consultar\n"; break;
        case 'B': std::cout << "Registrar\n"; break;
        default: std::cout << "Opción desconocida\n"; break;
    }
    const int horas{5};
    const bool dentro{horas >= 0 && horas <= 40};
    std::cout << std::boolalpha << "Horas válidas: " << dentro << '\n';
    return 0;
}
