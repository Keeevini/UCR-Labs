#ifndef __VISITORLATEX_HPP__
#define __VISITORLATEX_HPP__

#include "visitor.hpp"

class VisitorLaTeX : public Visitor {
	private:
		std::string expression;
	
	public:
		void visit_op(Op* node) { expression += "{" + node->stringify() + "}"; }
		void visit_rand(Rand* node) { expression += "{" + node->stringify() + "}"; }

		void visit_add_begin(Add* node) { expression += "{("; }
		void visit_add_middle(Add* node) { expression += "+"; }
		void visit_add_end(Add* node) { expression += ")}"; }
		void visit_sub_begin(Sub* node) { expression += "{("; }
		void visit_sub_middle(Sub* node) { expression += "-"; }
		void visit_sub_end(Sub* node) { expression += ")}"; }
		void visit_mult_begin(Mult* node) { expression += "{("; }
		void visit_mult_middle(Mult* node) { expression += "\\cdot"; }
		void visit_mult_end(Mult* node) { expression += ")}"; }
		void visit_div_begin(Div* node) { expression += "{\\frac"; }
		void visit_div_middle(Div* node) { }
		void visit_div_end(Div* node) { expression += "}"; }
		void visit_pow_begin(Pow* node) { expression += "{("; }
		void visit_pow_middle(Pow* node) { expression += "^"; }
		void visit_pow_end(Pow* node) {expression += ")}"; }

		std::string getString() { return expression; }
};

#endif
