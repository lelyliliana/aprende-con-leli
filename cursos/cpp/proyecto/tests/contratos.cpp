#include "inventario.hpp"
#include <filesystem>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

namespace {
int comprobaciones{0};
void exigir(bool condicion) {
    if (!condicion) { throw std::runtime_error{"Contrato no satisfecho"}; }
    ++comprobaciones;
}
template<class Funcion>
void rechaza(Funcion f) {
    bool fallo{false};
    try { f(); }
    catch (const std::invalid_argument&) { fallo = true; }
    exigir(fallo);
}
void escribir_entrada(const std::filesystem::path& ruta, const std::string& contenido) {
    std::ofstream archivo{ruta, std::ios::binary};
    archivo << contenido;
    archivo.close();
    if (!archivo) { throw std::runtime_error{"No se pudo preparar el caso"}; }
}
}
int main() {
    const auto datos{inventario::leer("datos/inventario.csv")};
    exigir(datos.size() == 6);
    exigir(inventario::total(datos) == 55000);
    exigir(datos.at(0).codigo == "SENSOR");
    std::vector<inventario::Producto> copia{datos};
    copia.at(0).cantidad = -1;
    rechaza([&copia] { inventario::validar(copia); });
    copia = datos; copia.at(0).cantidad = 100001;
    rechaza([&copia] { inventario::validar(copia); });
    copia = datos; copia.at(0).precio_centavos = -1;
    rechaza([&copia] { inventario::validar(copia); });
    copia = datos; copia.at(0).precio_centavos = 100000001;
    rechaza([&copia] { inventario::validar(copia); });
    copia = datos; copia.at(1).codigo = copia.at(0).codigo;
    rechaza([&copia] { inventario::validar(copia); });
    copia = datos; copia.at(0).codigo = "sensor";
    rechaza([&copia] { inventario::validar(copia); });
    copia = datos; copia.at(0).codigo = "";
    rechaza([&copia] { inventario::validar(copia); });
    copia = datos; copia.at(0).codigo = std::string(21, 'A');
    rechaza([&copia] { inventario::validar(copia); });
    const std::vector<inventario::Producto> vacia;
    rechaza([&vacia] { inventario::validar(vacia); });
    const std::vector<inventario::Producto> demasiados(10001, {"A", 0, 0});
    rechaza([&demasiados] { inventario::validar(demasiados); });
    const std::vector<inventario::Producto> limites{ {"A", 100000, 100000000}, {"B", 0, 0}};
    exigir(inventario::total(limites) == 10000000000000LL);

    std::filesystem::create_directories("salidas/contratos");
    const std::filesystem::path caso{"salidas/contratos/entrada.csv"};
    const std::string encabezado{"codigo;cantidad;precio_centavos\n"};
    const std::vector<std::string> invalidos{
        "", "otro;encabezado;valor\nA;1;2\n", encabezado,
        encabezado + "A;;2\n", encabezado + "A;1;2;\n", encabezado + "\n",
        encabezado + "A;7abc;2\n", encabezado + "A;999999999999999999999999;2\n",
        encabezado + "A; 7;2\n", encabezado + "A;1;2\nA;2;2\n"
    };
    for (const auto& contenido : invalidos) {
        escribir_entrada(caso, contenido);
        rechaza([&caso] { (void)inventario::leer(caso); });
    }
    escribir_entrada(caso, "\xEF\xBB\xBF" "codigo;cantidad;precio_centavos\r\nA;0;0\r\n");
    const auto crlf{inventario::leer(caso)};
    exigir(crlf.size() == 1 && inventario::total(crlf) == 0);
    const std::filesystem::path reporte{"salidas/contratos/reporte.csv"};
    inventario::escribir(reporte, datos);
    std::ifstream salida{reporte};
    std::string linea;
    exigir(static_cast<bool>(std::getline(salida, linea)));
    exigir(linea == "codigo;cantidad;precio_centavos;subtotal_centavos");
    exigir(static_cast<bool>(std::getline(salida, linea)));
    exigir(linea == "CABLE;3;2000;6000");
    const auto releidos{inventario::leer("datos/inventario.csv")};
    exigir(releidos.at(0).codigo == "SENSOR" && inventario::total(releidos) == 55000);
    std::cout << "Contratos comprobados: " << comprobaciones << '\n';
    return 0;
}
