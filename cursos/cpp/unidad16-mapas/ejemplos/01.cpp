#include <iostream>
#include <map>
#include <string>

int main() {
    std::map<std::string, int> stock{ {"S01", 5}, {"S02", 0}};
    const auto encontrado{stock.find("S02")};
    if (encontrado != stock.end()) { std::cout << "S02 presente con cantidad=" << encontrado->second << '\n'; }
    std::cout << std::boolalpha << "S03 presente: " << stock.contains("S03") << '\n';
    std::cout << "Claves: " << stock.size() << '\n';
    return 0;
}
