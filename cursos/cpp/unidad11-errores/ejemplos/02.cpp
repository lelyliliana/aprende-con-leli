#include <iostream>
#include <stdexcept>

int validar_horas(int horas) {
    if (horas < 0 || horas > 40) { throw std::invalid_argument{"Horas fuera de 0 a 40"}; }
    return horas;
}

int main() {
    std::cout << "Válido: " << validar_horas(0) << '\n';
    try {
        const int resultado{validar_horas(-1)};
        std::cout << resultado << '\n';
        return 1;
    } catch (const std::invalid_argument& error) {
        std::cout << "Rechazo: " << error.what() << '\n';
    }
    return 0;
}
