#ifndef __POW_HPP__
#define __POW_HPP__

#include "op.hpp"
#include <string>
#include <cmath>

class Pow : public Base {
	private:
		Base* lhs;
		Base* rhs;
	public:
		Pow(Base* lhs, Base* rhs) : Base(){
			this->lhs = lhs;
			this->rhs = rhs;
		}
		~Pow() {
			delete lhs;
			delete rhs;
		}
		virtual double evaluate() { //posi expo
			return pow(lhs->evaluate(), rhs->evaluate());
		}
		virtual std::string stringify() {
			return "(" + lhs->stringify() + " ** " + rhs->stringify() + ")";
		}
};


#endif
