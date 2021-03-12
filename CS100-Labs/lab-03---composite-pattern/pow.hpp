#ifndef __POW_HPP__
#define __POW_HPP__

#include "base.hpp"
#include<cmath>

class Pow : public Base {
	private:
		Base* val;
		Base* exp;	
	public:
        	Pow(Base* val, Base* exp) : Base() {this->val = val; this->exp = exp; }
        	virtual double evaluate() { return pow(val->evaluate(), exp->evaluate()); }
        	virtual std::string stringify() { return "(" + val->stringify() + ")**(" + exp->stringify() + ")"; }
};

#endif //__POW_HPP__
