#include <filesystem>
#include <iostream>

bool function() {
	std::filesystem::path p("../arrow-example/build/test.arrow");

	if(std::boolalpha) {
		 
		return true;
	}
	else return false;

	return true;
}


int main () {
	function();
	return 0;
}
