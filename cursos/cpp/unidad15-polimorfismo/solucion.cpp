#include <iostream>
#include <memory>
#include <vector>

class Figura {
public:
    virtual ~Figura() = default;
    virtual int area() const = 0;
};
class Rectangulo final : public Figura {
    int ancho_;
    int alto_;
public:
    Rectangulo(int ancho, int alto) : ancho_{ancho}, alto_{alto} {}
    int area() const override { return ancho_ * alto_; }
};

int main() {
    const Rectangulo rectangulo{2, 3};
    std::cout << "Paso 1: área concreta=" << rectangulo.area() << '\n';
    const Figura& interfaz{rectangulo};
    std::cout << "Paso 2: área por interfaz=" << interfaz.area() << '\n';
    std::vector<std::unique_ptr<Figura>> figuras;
    figuras.push_back(std::make_unique<Rectangulo>(2, 3));
    figuras.push_back(std::make_unique<Rectangulo>(4, 2));
    int total{0};
    for (const auto& f : figuras) { total += f->area(); }
    std::cout << "Paso 3: suma=" << total << '\n';
    figuras.clear();
    std::cout << "Reto: propietarios restantes=" << figuras.size() << '\n';
    return 0;
}
