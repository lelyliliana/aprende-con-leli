#include <iostream>

int main() {
    const int puntaje{60};
    if (puntaje >= 0 && puntaje <= 100) {
        std::cout << "Paso 1: puntaje dentro del dominio\n";
    }
    if (puntaje >= 60) {
        std::cout << "Paso 2: el límite 60 se aprueba\n";
    }
    const int fuera{101};
    if (fuera < 0 || fuera > 100) {
        std::cout << "Paso 3: 101 se rechaza antes de clasificar\n";
    }
    const char opcion{'Z'};
    switch (opcion) {
        case 'A': std::cout << "Consultar\n"; break;
        case 'B': std::cout << "Registrar\n"; break;
        default: std::cout << "Reto: Z no es una opción admitida\n"; break;
    }
    return 0;
}
