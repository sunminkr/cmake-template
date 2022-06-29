#include <iostream>
#include <string>

#include "test.h"

void ClangTidy::function() {
    std::string str1 = "Testing";
    std::string str2 = std::move(str1);
    // clang-tidy will find -> str1 after a std::move()

    std::cout << str1 << str2;
}

int main() {
    ClangTidy::function();
    return 0;
}