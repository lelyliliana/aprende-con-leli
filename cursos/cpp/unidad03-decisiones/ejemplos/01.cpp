#include <iostream>

int main() {
    const int puntaje{80};
    if (puntaje < 0 || puntaje > 100) {
        std::cout << "Fuera del dominio\n";
    } else if (puntaje >= 60) {
        std::cout << "Aprobado\n";
    } else {
        std::cout << "Por mejorar\n";
    }
    return 0;
}
