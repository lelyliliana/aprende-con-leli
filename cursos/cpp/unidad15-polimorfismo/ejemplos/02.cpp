#include <iostream>

class ReglaPrecio {
public:
    virtual ~ReglaPrecio() = default;
    virtual int aplicar(int base) const = 0;
};
class PrecioNormal final : public ReglaPrecio {
public: int aplicar(int base) const override { return base; }
};
class PrecioReducido final : public ReglaPrecio {
public: int aplicar(int base) const override { return base * 9 / 10; }
};
int calcular(const ReglaPrecio& regla, int base) { return regla.aplicar(base); }

int main() {
    const PrecioNormal normal;
    const PrecioReducido reducido;
    std::cout << "Normal: " << calcular(normal, 100) << '\n';
    std::cout << "Reducido: " << calcular(reducido, 100) << '\n';
    return 0;
}
