#include <iostream>
#include <optional>
#include <string>
#include <charconv>
#include <system_error>

std::optional<int> entero(const std::string& texto) {
    int valor{0};
    const auto r{std::from_chars(texto.data(), texto.data() + texto.size(), valor)};
    if (r.ec != std::errc{} || r.ptr != texto.data() + texto.size()) { return std::nullopt; }
    return valor;
}

int main() {
    const auto cero{entero("0")};
    const auto fallo{entero("7abc")};
    if (cero) { std::cout << "Cero conocido: " << *cero << '\n'; }
    std::cout << std::boolalpha << "Texto inválido tiene resultado: " << fallo.has_value() << '\n';
    return 0;
}
