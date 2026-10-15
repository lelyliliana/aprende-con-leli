#include <iostream>
#include <stdexcept>

class Stock {
    int cantidad_;
public:
    explicit Stock(int inicial) : cantidad_{inicial} {
        if (inicial < 0) { throw std::invalid_argument{"Stock negativo"}; }
    }
    int cantidad() const { return cantidad_; }
    void retirar(int n) {
        if (n < 0 || n > cantidad_) { throw std::invalid_argument{"Retiro inválido"}; }
        cantidad_ -= n;
    }
};

int main() {
    Stock sensor{5};
    sensor.retirar(2);
    std::cout << "Stock: " << sensor.cantidad() << '\n';
    try { sensor.retirar(4); return 1; }
    catch (const std::invalid_argument&) { std::cout << "Rechazo sin cambiar stock: " << sensor.cantidad() << '\n'; }
    return 0;
}
