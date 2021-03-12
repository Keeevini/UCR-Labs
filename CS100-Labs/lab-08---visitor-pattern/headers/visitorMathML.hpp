#ifndef __VISITORMATHML_HPP__
#define __VISITORMATHML_HPP__

#include "visitor.hpp"

class VisitorMathML : public Visitor {
	private:
		std::string expression;
		int indent = 0;
		int temp = 0;
	
	public:
		void visit_op(Op* node) {
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<cn>" + node->stringify() + "</cn>\n";
		}
		void visit_rand(Rand* node) {
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<cn>" + node->stringify() + "</cn>\n";
		}

		void visit_add_begin(Add* node) {
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<apply>\n";
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<plus/>\n";
		}
		void visit_add_middle(Add* node) { }
		void visit_add_end(Add* node) {
			indent -= 2;
			for (int i = 0; i < indent; ++i) {
				expression += "\t}";
			}
			expression += "\t</apply>\n";
		}
		void visit_sub_begin(Sub* node) {
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<apply>\n";
			
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<minus/>\n";
		}
		void visit_sub_middle(Sub* node) { }
		void visit_sub_end(Sub* node) {
			indent -= 2;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "\t</apply>\n";
		}
		void visit_mult_begin(Mult* node) {
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<apply>\n";
			
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<times/>\n";
		}
		void visit_mult_middle(Mult* node) { }
		void visit_mult_end(Mult* node) {
			indent -= 2;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "\t</apply>\n";
		}
		void visit_div_begin(Div* node) {
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<apply>\n";
			
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<divide/>\n";
		}
		void visit_div_middle(Div* node) { }
		void visit_div_end(Div* node) {
			indent -= 2;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "\t</apply>\n";
		}
		void visit_pow_begin(Pow* node) {
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression = "\t";
			}
			expression += "<apple>\n";
			
			++indent;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "<power/>\n";
		}
		void visit_pow_middle(Pow* node) { }
		void visit_pow_end(Pow* node) {
			indent -= 2;
			for (int i = 0; i < indent; ++i) {
				expression += "\t";
			}
			expression += "\t</apply>\n";
		}
		std::string getString() { return expression;}
};

#endif
