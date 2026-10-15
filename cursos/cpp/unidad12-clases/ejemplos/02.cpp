#include <iostream>
#include <string>
#include <utility>

class Equipo {
    std::string codigo_;
    std::string nombre_;
public:
    Equipo(std::string codigo, std::string nombre) : codigo_{codigo}, nombre_{nombre} {}
    const std::string& codigo() const { return codigo_; }
    const std::string& nombre() const { return nombre_; }
};

int main() {
    const Equipo equipo{"S01", "Sensor"};
    std::cout << equipo.codigo() << ": " << equipo.nombre() << '\n';
    return 0;
}
