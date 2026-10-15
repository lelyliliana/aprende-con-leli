#include <iostream>

enum class Estado { disponible, prestado, mantenimiento };

int main() {
    const Estado estado{Estado::prestado};
    switch (estado) {
        case Estado::disponible: std::cout << "Disponible\n"; break;
        case Estado::prestado: std::cout << "Prestado\n"; break;
        case Estado::mantenimiento: std::cout << "En mantenimiento\n"; break;
    }
    return 0;
}
