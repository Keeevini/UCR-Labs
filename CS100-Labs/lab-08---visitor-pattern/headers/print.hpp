#ifndef __PRINT_HPP__
#define __PRINT_HPP__

#include "visitorLaTeX.hpp"
#include "visitorMathML.hpp"
#include "iterator.hpp"
#include <string>

// functions

std::string print_latex(Base* ptr) {
	VisitorLaTeX* visitor = new VisitorLaTeX();
	Iterator jorge(ptr);
	
	while(!jorge.is_done()) {
		jorge.current_node()->accept(visitor, jorge.current_index());
		jorge.next();
	}
	
	std::string result;
	result += "$" + visitor->getString() + "$";
	delete visitor;
	return result;
}

std::string print_mathML(Base* ptr) {
	VisitorMathML* visitor = new VisitorMathML();
	Iterator jorge(ptr);
	
	while(!jorge.is_done()) {
		jorge.current_node()->accept(visitor, jorge.current_index());
		jorge.next();
	}

	std::string result;
	result += "<math>\n" + visitor->getString() + "</math>";
	delete visitor;
	return result;
}

#endif
