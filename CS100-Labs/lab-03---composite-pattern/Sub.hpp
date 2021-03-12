#ifndef __SUB_HPP__
#define __SUB_HPP__

#include "base.hpp"
#include <string>

class Sub : public Base {
	private:
		Base* value1;
		Base* value2;
	public:
		Sub(Base* val1, Base* val2) : Base() { value1 = val1; value2 = val2;}

		virtual double evaluate() { return value1->evaluate() - value2->evaluate(); }
		virtual std::string stringify() { return "(" + value1->stringify() + "-" + value2->stringify() + ")"; }
};

#endif //__SUB_HPP__
