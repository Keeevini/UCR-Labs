#ifndef __ADD_HPP__
#define __ADD_HPP__

#include "op.hpp"

class Add : public Base {
    private:
	Base* lhs;
	Base* rhs;
    public:
	Add(Base* lhs, Base* rhs) : Base(){
	    this->lhs = lhs;
	    this->rhs = rhs;
	}
	~Add(){
		delete lhs;
		delete rhs;
	}
	virtual double evaluate() {return lhs->evaluate() + rhs->evaluate();}
	virtual std::string stringify()  {return "(" + lhs->stringify() + " + " + rhs->stringify() +  ")";};

};

#endif
