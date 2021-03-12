#include <iostream>

#include "../headers/parse.hpp"


int main(int argv, char** argc) {
	Factory* factory = new Parse();
	Base* calc = factory->parse(argc, argv);
	if (calc) {
		std::cout << calc->stringify() << " = " << calc->evaluate() << std::endl;
	}
	else {
		std::cout << "Invalid input!" << std::endl;
	}
	
	delete factory;
	delete calc;

	//std::cout << minus->stringify() << " = " << minus->evaluate() << std::endl;
	return 0;
}
