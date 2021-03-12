#ifndef __RAND_HPP__
#define __RAND_HPP__

#include "op.hpp"
#include "visitor.hpp"
#include <string>

class Rand : public Base {
	private:
		double value;
	public:
		Rand() {
			this->value = rand() % 100;
		}

		virtual double evaluate() { return value; }
		virtual string stringify() { return to_string(value); }
		virtual void accept(Visitor* visitor, int index) { visitor->visit_rand(this); }
		virtual int number_of_children() { return 0; }
		virtual Base* get_child(int i) { return nullptr; }

};

#endif
