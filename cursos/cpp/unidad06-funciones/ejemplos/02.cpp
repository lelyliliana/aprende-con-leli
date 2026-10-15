#include <iostream>
#include <string>

void intentar_cambiar(int copia) {
    copia += 1;
    std::cout << "Copia local: " << copia << '\n';
}
void aumentar(int& cantidad) { cantidad += 1; }
void mostrar(const std::string& codigo) { std::cout << "ID: " << codigo << '\n'; }

int main() {
    int cantidad{4};
    intentar_cambiar(cantidad);
    std::cout << "Tras pasar por valor: " << cantidad << '\n';
    aumentar(cantidad);
    std::cout << "Tras referencia: " << cantidad << '\n';
    const std::string codigo{"S01"};
    mostrar(codigo);
    return 0;
}
