#include <iostream>

int main() {
    int suma{0};
    for (int n{1}; n <= 5; ++n) { suma += n; }
    std::cout << "Paso 1: suma de 1 a 5=" << suma << '\n';
    int contador{3};
    while (contador > 0) { --contador; }
    std::cout << "Paso 2: contador final=" << contador << '\n';
    int cantidad{0};
    for (int n{0}; n < 5; ++n) { ++cantidad; }
    std::cout << "Paso 3: [0,5) tiene " << cantidad << " iteraciones\n";
    int suma_pares{0};
    for (int n{1}; n <= 10; ++n) {
        if (n % 2 == 0) { suma_pares += n; }
    }
    std::cout << "Reto: pares entre 1 y 10 suman " << suma_pares << '\n';
    return 0;
}
