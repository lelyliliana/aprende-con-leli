#include <iostream>
#include <string>
#include <sstream>

int main() {
    const std::string linea{"7"};
    std::istringstream lector{linea};
    int horas{0};
    if (!(lector >> horas)) { return 1; }
    lector >> std::ws;
    if (!lector.eof() || horas < 0 || horas > 40) { return 1; }
    std::cout << "Paso 1: la línea conservada es " << linea << '\n';
    std::cout << "Paso 2: entero interpretado=" << horas << '\n';
    std::cout << "Paso 3: minutos=" << horas * 60 << '\n';
    std::istringstream con_sufijo{"7abc"};
    int candidato{0};
    if (!(con_sufijo >> candidato)) { return 1; }
    con_sufijo >> std::ws;
    if (!con_sufijo.eof()) {
        std::cout << "Reto: 7abc se rechaza porque sobran caracteres\n";
    } else { return 1; }
    return 0;
}
