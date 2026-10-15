#include <iostream>
#include <stdexcept>

class Stock {
    int cantidad_;
public:
    explicit Stock(int n) : cantidad_{n} { if (n < 0) { throw std::invalid_argument{"Negativo"}; } }
    int cantidad() const { return cantidad_; }
    void retirar(int n) {
        if (n < 0 || n > cantidad_) { throw std::invalid_argument{"Retiro inválido"}; }
        cantidad_ -= n;
    }
};

int main() {
    Stock stock{5};
    std::cout << "Paso 1: inicial=" << stock.cantidad() << '\n';
    stock.retirar(2);
    std::cout << "Paso 2: tras retirar 2=" << stock.cantidad() << '\n';
    try { stock.retirar(4); return 1; }
    catch (const std::invalid_argument&) { std::cout << "Paso 3: rechazo conserva=" << stock.cantidad() << '\n'; }
    stock.retirar(3);
    std::cout << "Reto: retirar exactamente lo disponible deja=" << stock.cantidad() << '\n';
    return 0;
}
