#include <cstddef>
#include "inventario.hpp"
#include <algorithm>
#include <charconv>
#include <fstream>
#include <limits>
#include <set>
#include <stdexcept>
#include <system_error>

namespace {
std::int64_t entero(const std::string& texto) {
    if (texto.empty()) { throw std::invalid_argument{"Campo entero vacío"}; }
    std::int64_t valor{0};
    const auto r{std::from_chars(texto.data(), texto.data() + texto.size(), valor)};
    if (r.ec != std::errc{} || r.ptr != texto.data() + texto.size()) {
        throw std::invalid_argument{"Campo entero incompleto o no representable"};
    }
    return valor;
}
std::vector<std::string> campos(const std::string& linea) {
    std::vector<std::string> resultado;
    std::size_t inicio{0};
    while (true) {
        const auto p{linea.find(';', inicio)};
        if (p == std::string::npos) { resultado.push_back(linea.substr(inicio)); break; }
        resultado.push_back(linea.substr(inicio, p - inicio));
        inicio = p + 1;
    }
    if (resultado.size() != 3) { throw std::invalid_argument{"Se requieren tres campos por registro"}; }
    return resultado;
}
void quitar_cr(std::string& linea) {
    if (!linea.empty() && linea.back() == '\r') { linea.pop_back(); }
}
}

namespace inventario {
void validar(const std::vector<Producto>& productos) {
    if (productos.empty() || productos.size() > 10000) {
        throw std::invalid_argument{"Se requieren entre 1 y 10000 productos"};
    }
    std::set<std::string> ids;
    for (const auto& p : productos) {
        if (p.codigo.empty() || p.codigo.size() > 20) { throw std::invalid_argument{"Longitud de código inválida"}; }
        for (const char c : p.codigo) {
            if (!((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '-' || c == '_')) {
                throw std::invalid_argument{"Código fuera del formato ASCII declarado"};
            }
        }
        if (!ids.insert(p.codigo).second) { throw std::invalid_argument{"Código duplicado"}; }
        if (p.cantidad < 0 || p.cantidad > 100000) { throw std::invalid_argument{"Cantidad fuera de 0 a 100000"}; }
        if (p.precio_centavos < 0 || p.precio_centavos > 100000000) {
            throw std::invalid_argument{"Precio fuera de 0 a 100000000 centavos"};
        }
    }
}

std::vector<Producto> leer(const std::filesystem::path& entrada) {
    std::ifstream archivo{entrada};
    if (!archivo) { throw std::runtime_error{"No se pudo abrir la entrada"}; }
    std::string linea;
    if (!std::getline(archivo, linea)) { throw std::invalid_argument{"Falta encabezado"}; }
    quitar_cr(linea);
    if (linea.starts_with("\xEF\xBB\xBF")) { linea.erase(0, 3); }
    if (linea != "codigo;cantidad;precio_centavos") { throw std::invalid_argument{"Encabezado inesperado"}; }
    std::vector<Producto> productos;
    while (std::getline(archivo, linea)) {
        quitar_cr(linea);
        if (linea.empty()) { throw std::invalid_argument{"Fila vacía no admitida"}; }
        const auto c{campos(linea)};
        productos.push_back({c.at(0), entero(c.at(1)), entero(c.at(2))});
        if (productos.size() > 10000) { throw std::invalid_argument{"Demasiados productos"}; }
    }
    if (!archivo.eof()) { throw std::runtime_error{"Lectura interrumpida"}; }
    validar(productos);
    return productos;
}

std::int64_t total(const std::vector<Producto>& productos) {
    validar(productos);
    std::int64_t acumulado{0};
    for (const auto& p : productos) {
        const auto subtotal{p.cantidad * p.precio_centavos};
        if (acumulado > std::numeric_limits<std::int64_t>::max() - subtotal) {
            throw std::overflow_error{"Total no representable"};
        }
        acumulado += subtotal;
    }
    return acumulado;
}

void escribir(const std::filesystem::path& salida, const std::vector<Producto>& productos) {
    validar(productos);
    const auto valor{total(productos)};
    (void)valor;
    if (std::filesystem::exists(salida)) { throw std::runtime_error{"La salida ya existe; elige otra ruta"}; }
    auto ordenados{productos};
    std::sort(ordenados.begin(), ordenados.end(), [](const Producto& a, const Producto& b) { return a.codigo < b.codigo; });
    std::ofstream archivo{salida};
    if (!archivo) { throw std::runtime_error{"No se pudo abrir la salida"}; }
    archivo << "codigo;cantidad;precio_centavos;subtotal_centavos\n";
    for (const auto& p : ordenados) {
        archivo << p.codigo << ';' << p.cantidad << ';' << p.precio_centavos << ';' << p.cantidad * p.precio_centavos << '\n';
    }
    archivo.close();
    if (!archivo) { throw std::runtime_error{"Escritura incompleta"}; }
}
}
