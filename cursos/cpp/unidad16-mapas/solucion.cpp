#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

int main() {
    std::map<std::string, int> stock{ {"S01", 5}, {"S02", 0}};
    std::cout << "Paso 1: claves=" << stock.size() << '\n';
    const auto cero{stock.find("S02")};
    if (cero == stock.end()) { return 1; }
    std::cout << "Paso 2: S02 tiene cero=" << cero->second << '\n';
    const auto ausente{stock.find("S03")};
    std::cout << std::boolalpha << "Paso 3: S03 ausente=" << (ausente == stock.end()) << "; claves=" << stock.size() << '\n';
    std::set<std::string> ids;
    const std::vector<std::string> entrada{"S01", "S02", "S01"};
    int duplicados{0};
    for (const auto& id : entrada) { if (!ids.insert(id).second) { ++duplicados; } }
    std::cout << "Reto: repeticiones detectadas=" << duplicados << '\n';
    return 0;
}
