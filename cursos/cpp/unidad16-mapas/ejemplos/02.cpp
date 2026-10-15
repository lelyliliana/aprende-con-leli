#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

int main() {
    const std::vector<std::string> grupos{"A", "B", "A"};
    std::map<std::string, int> frecuencias;
    std::set<std::string> vistos;
    for (const auto& grupo : grupos) { ++frecuencias[grupo]; vistos.insert(grupo); }
    for (const auto& [grupo, n] : frecuencias) { std::cout << grupo << ": " << n << '\n'; }
    std::cout << "Etiquetas distintas: " << vistos.size() << '\n';
    return 0;
}
