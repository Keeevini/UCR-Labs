#ifndef __SUB_HPP__
#define __SUB_HPP__

#include "op.hpp"

class Sub : public Base {
	private:
		Base* lhs;
		Base* rhs;
	public:
		Sub(Base* lhs, Base* rhs) : Base() {
			this->lhs = lhs;
			this->rhs = rhs;
		}
		~Sub() {
			delete lhs;
			delete rhs;
		}
		virtual double evaluate() { return lhs->evaluate() -  rhs->evaluate(); }
		virtual std::string stringify() { return "(" + lhs->stringify() + " - " + rhs->stringify() + ")";}
};


#endif
