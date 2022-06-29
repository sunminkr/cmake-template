#include <iostream>
#include <fstream>

#include "test.h"

bool testArrow::function() {
	std::ifstream file("../arrow-example/result/test.arrow");
	if(file.is_open()) {
		std::cout << "file exists" << std::endl;
		return true;
	}
	std::cout << "file not found" << std::endl;
	return false;
}

int main () {
	testArrow::function();
	return 0;
}
