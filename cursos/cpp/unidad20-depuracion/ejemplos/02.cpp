#include <iostream>

int main() {
    const int precio{100};
    const int cantidad{3};
    const int descuento_por_unidad{10};
    const int incorrecto{precio * cantidad - descuento_por_unidad};
    const int esperado{270};
    if (incorrecto != esperado) {
        std::cout << "Caso que detecta el error: esperado=" << esperado << "; calculado=" << incorrecto << '\n';
    }
    const int corregido{(precio - descuento_por_unidad) * cantidad};
    if (corregido != esperado) { return 1; }
    std::cout << "Corrección: " << corregido << '\n';
    return 0;
}
