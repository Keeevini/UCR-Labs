#ifndef __DIV_HPP__
#define __DIV_HPP__

#include "op.hpp"

class Div : public Base {
    private:
	Base* lhs;
	Base* rhs;
    public:
	Div(Base* lhs, Base* rhs) : Base() {
	    this->lhs = lhs;
	    this->rhs = rhs;
	}
	~Div() {
		delete lhs;
		delete rhs;
	}
	virtual double evaluate() {
		if (rhs->evaluate() == 0) {
			//std::cout << "Zero in denominator" << std::endl;
			return 0;
		}
		return lhs->evaluate() / rhs->evaluate();
	}
	virtual std::string stringify() {return "(" + lhs->stringify() + " / " + rhs->stringify() + ")";}
	virtual void accept(Visitor* visitor, int index) {
		if (index == 0)
			visitor->visit_div_begin(this);
		else if (index == 1)
			visitor->visit_div_middle(this);
		else if (index == 2)
			visitor->visit_div_end(this);
	}
	virtual int number_of_children() {return 2;}
	virtual Base* get_child(int i) {
		if (i == 0)
			return this->lhs;
		if (i == 1)
			return this->rhs;
	}

};

#endif
