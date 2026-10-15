#include <iostream>

int main() {
    const int minutos_por_hora{60};
    double horas{1.5};
    const double minutos{horas * minutos_por_hora};
    horas = 2.0;
    std::cout << "Minutos calculados: " << minutos << '\n';
    std::cout << "Horas actuales: " << horas << '\n';
    return 0;
}
