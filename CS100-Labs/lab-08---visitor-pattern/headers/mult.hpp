#ifndef _MULT_HPP_
#define _MULT_HPP_

#include <string>
#include "op.hpp"

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
		virtual void accept(Visitor* visitor, int index) {
			if (index == 0)
				visitor->visit_mult_begin(this);
			else if (index == 1)
				visitor->visit_mult_middle(this);
			else if (index == 2)
				visitor->visit_mult_end(this);
		}
		virtual int number_of_children() {return 2;}
		virtual Base* get_child(int i) {
			if (i == 0)
				return lhs;
			if (i == 1)
				return rhs;
		}
};

#endif
