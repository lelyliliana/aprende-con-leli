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
    std::vector<std::unique_ptr<Figura>> figuras;
    figuras.push_back(std::make_unique<Rectangulo>(2, 3));
    figuras.push_back(std::make_unique<Rectangulo>(4, 2));
    for (const auto& figura : figuras) { std::cout << "Área: " << figura->area() << '\n'; }
    return 0;
}
