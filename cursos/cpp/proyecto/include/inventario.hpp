#ifndef CURSO_CPP_INVENTARIO_HPP
#define CURSO_CPP_INVENTARIO_HPP

#include <cstdint>
#include <filesystem>
#include <string>
#include <vector>

namespace inventario {
struct Producto {
    std::string codigo;
    std::int64_t cantidad;
    std::int64_t precio_centavos;
};
void validar(const std::vector<Producto>& productos);
std::vector<Producto> leer(const std::filesystem::path& entrada);
std::int64_t total(const std::vector<Producto>& productos);
void escribir(const std::filesystem::path& salida, const std::vector<Producto>& productos);
}
#endif
