#include <iostream>

#include "../headers/parse.hpp"
#include "../headers/print.hpp"


int main(int argv, char** argc) {
	Factory* factory = new Parse();
	Base* calc = factory->parse(argc, argv);
	if (calc) {
		std::cout << calc->stringify() << " = " << calc->evaluate() << std::endl;
		std::cout << "Latex: \n" << print_latex(calc) << std::endl;
		std::cout << "MathML: \n" << print_mathML(calc) << std::endl;
	}
	else {
		std::cout << "Invalid input!" << std::endl;
	}
	
	delete factory;
	delete calc;	
	return 0;
}
