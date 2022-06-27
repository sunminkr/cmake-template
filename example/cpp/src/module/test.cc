#include <iostream>

#include "gtest/gtest.h"

int function() {
	int result;
	float f = 1.00F;
	result = (int) f;
	std::cout << result << std::endl;
	return result;
}


int main () {
	function();
	return 0;
}
