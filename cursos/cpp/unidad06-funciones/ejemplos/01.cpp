#include <iostream>

int minutos(int horas) {
    return horas * 60;
}

int main() {
    const int resultado{minutos(2)};
    std::cout << "Minutos: " << resultado << '\n';
    return 0;
}
