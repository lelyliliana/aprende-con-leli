#include "inventario.hpp"
#include <exception>
#include <stdexcept>
#include <system_error>
#include <filesystem>
#include <iostream>

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Uso: inventario entrada.csv salida.csv\n";
        return 2;
    }
    try {
        const std::filesystem::path entrada{argv[1]};
        const std::filesystem::path salida{argv[2]};
        const auto productos{inventario::leer(entrada)};
        const auto valor{inventario::total(productos)};
        std::error_code error;
        const bool mismo_archivo{std::filesystem::equivalent(entrada, salida, error)};
        if (mismo_archivo || std::filesystem::weakly_canonical(entrada) == std::filesystem::weakly_canonical(salida)) {
            throw std::runtime_error{"Entrada y salida deben ser archivos distintos"};
        }
        // La entrada se validó antes de crear carpetas o abrir productos de salida.
        if (!salida.parent_path().empty()) { std::filesystem::create_directories(salida.parent_path()); }
        inventario::escribir(salida, productos);
        std::cout << "Registros: " << productos.size() << '\n';
        std::cout << "Total: " << valor << " centavos\n";
        std::cout << "Reporte generado sin modificar la entrada\n";
        return 0;
    } catch (const std::exception& error) {
        std::cerr << "Error: " << error.what() << '\n';
        return 2;
    }
}
