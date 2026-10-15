#include <iostream>
#include <string>
#include <utility>

class Recurso {
    std::string nombre_;
public:
    explicit Recurso(std::string nombre) : nombre_{nombre} { std::cout << "Adquirir: " << nombre_ << '\n'; }
    ~Recurso() { std::cout << "Liberar: " << nombre_ << '\n'; }
};

int main() {
    std::cout << "Antes del bloque\n";
    {
        const Recurso recurso{"archivo de práctica"};
        std::cout << "Dentro del bloque\n";
    }
    std::cout << "Después del bloque\n";
    return 0;
}
