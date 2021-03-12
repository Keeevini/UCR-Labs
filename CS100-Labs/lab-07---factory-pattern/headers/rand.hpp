#ifndef __RAND_HPP__
#define __RAND_HPP__

#include "op.hpp"
#include <string>

class Rand : public Base{
	private:
		double value;
	public:
		Rand() : Base() {
			this->value = rand() % 100;
		}
		virtual double evaluate() { return value; }
		virtual string stringify() { return to_string(value); }
};

#endif
