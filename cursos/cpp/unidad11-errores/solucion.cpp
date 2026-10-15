#include <iostream>
#include <optional>
#include <string>
#include <charconv>
#include <system_error>
#include <stdexcept>

std::optional<int> entero(const std::string& texto) {
    int n{0};
    const auto r{std::from_chars(texto.data(), texto.data() + texto.size(), n)};
    if (r.ec != std::errc{} || r.ptr != texto.data() + texto.size()) { return std::nullopt; }
    return n;
}
void validar(int n) { if (n < 0 || n > 40) { throw std::invalid_argument{"Fuera de dominio"}; } }

int main() {
    const auto a{entero("0")};
    if (!a || *a != 0) { return 1; }
    std::cout << "Paso 1: cero es un valor presente\n";
    if (entero("7abc")) { return 1; }
    std::cout << "Paso 2: sufijo inválido rechazado\n";
    try { validar(41); return 1; }
    catch (const std::invalid_argument&) { std::cout << "Paso 3: 41 fuera del dominio\n"; }
    if (entero("") || entero("9999999999999999999999999")) { return 1; }
    std::cout << "Reto: vacío y entero fuera de representación rechazados\n";
    return 0;
}
