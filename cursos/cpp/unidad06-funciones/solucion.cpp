#include <iostream>
#include <string>

int minutos(int horas) { return horas * 60; }
int sumar_uno(int cantidad) { return cantidad + 1; }
void aumentar(int& cantidad) { cantidad += 1; }
std::string etiqueta(const std::string& codigo) { return "Código: " + codigo; }

int main() {
    std::cout << "Paso 1: " << minutos(3) << " minutos\n";
    int stock{5};
    const int copia{sumar_uno(stock)};
    std::cout << "Paso 2: original=" << stock << "; copia=" << copia << '\n';
    aumentar(stock);
    std::cout << "Paso 3: referencia actualiza stock=" << stock << '\n';
    const std::string codigo{"S01"};
    std::cout << "Reto: " << etiqueta(codigo) << '\n';
    return 0;
}
