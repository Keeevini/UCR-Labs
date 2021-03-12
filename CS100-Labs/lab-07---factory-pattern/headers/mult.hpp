#ifndef _MULT_HPP_
#define _MULT_HPP_

#include <string>
#include "base.hpp"

class Mult : public Base {
	private:
		Base* lhs;
		Base* rhs;
	public:
		// constructor
		Mult(Base* lhs, Base* rhs) : Base() {
			this->lhs = lhs;
			this->rhs = rhs;
		}
		~Mult() {
			delete lhs;
			delete rhs;
		}
	
		// member functions
		virtual double evaluate() {return lhs->evaluate() * rhs->evaluate(); };
		virtual std::string stringify() {return "(" + lhs->stringify() +  " * "  + rhs->stringify() + ")";}

};

#endif
