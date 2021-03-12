#ifndef __ADD_HPP__
#define __ADD_HPP__

#include "op.hpp"
#include "visitor.hpp"

class Add : public Base {
    private:
	Base* lhs;
	Base* rhs;
    public:
	Add(Base* lhs, Base* rhs) : Base(){
	    this->lhs = lhs;
	    this->rhs = rhs;
	}
	~Add() {
		delete lhs;
		delete rhs;
	}
	virtual double evaluate() {return lhs->evaluate() + rhs->evaluate();}
	virtual std::string stringify()  {return "(" + lhs->stringify() + " + " + rhs->stringify() +  ")";}
	virtual void accept(Visitor* visitor, int index) {
		if (index == 0)
			visitor->visit_add_begin(this);
		else if (index == 1)
			visitor->visit_add_middle(this);
		else if (index == 2)
			visitor-> visit_add_end(this);
	}
	virtual int number_of_children() {return 2;}
	virtual Base* get_child(int i) {
		if (i == 0)
			return lhs;
		if( i == 1)
			return rhs;
	}

};

#endif
