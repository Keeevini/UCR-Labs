#ifndef __DIV_HPP__
#define __DIV_HPP__

#include "base.hpp"
#include <string>

class Div : public Base {
	private:
		Base* value1;
		Base* value2;
	public:
		Div(Base* val1, Base* val2) : Base() { value1 = val1; value2 = val2;}
		
		virtual double evaluate() { return value1->evaluate() / value2->evaluate(); }
		virtual std::string stringify() { return "(" + value1->stringify() + "/" + value2->stringify() + ")"; }
};

#endif //__DIV_HPP__
