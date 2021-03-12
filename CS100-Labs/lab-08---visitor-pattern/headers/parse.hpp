#ifndef __PARSE_HPP__
#define __PARSE_HPP__

#include <iostream>
#include "factory.hpp"
#include <queue>
#include <stack>
#include <string>

class Parse : public Factory {
	public:
		 Base* parse(char** input, int length) {
			std::queue<Base*> nums;
			std::stack<char*> operation; 
			
			for(int i = 1; i < length; ++i){
				std::string tmp = input[i];

                		if((tmp == "**") || (tmp == "*") || (tmp == "/") || (tmp == "+") || (tmp == "-") ){
					operation.push(input[i]);
//					std::cout << "operation pushed: " << operation.top() << std::endl;
               			}
				else {
            				Base* op = new Op(atof(input[i]));
                			nums.push(op);
//					std::cout << "number pushed: " << nums.back()->stringify() << std::endl;
                		}
				if(nums.size() == 2){
					std::string tmp2 = operation.top();	
        	   			if(tmp2 == "**"){
//						std::cout << "processing op" << std::endl;
              				 	Base* exp = new Pow(nums.front(), nums.back());
                				nums.pop();
						nums.pop();
                				operation.pop();
                				nums.push(exp);
            				}
            				else if(tmp2 == "*"){
               					Base* mult = new Mult(nums.front(), nums.back());
                				nums.pop();
                				nums.pop();
                				operation.pop();
                				nums.push(mult);
            				}
           				else if(tmp2 == "/"){
                				Base* div = new Div(nums.front(), nums.back());
                				nums.pop();
                				nums.pop();
                				operation.pop();
                				nums.push(div);
            				}
      		      			else if(tmp2 == "+"){
                				Base* add = new Add(nums.front(), nums.back());
                				nums.pop();
                				nums.pop();
                				operation.pop();
                				nums.push(add);
            				}
       		     			else if(tmp2 == "-"){
                				Base* sub = new Sub(nums.front(), nums.back());
                				nums.pop();
                				nums.pop();
                				operation.pop();
               		 			nums.push(sub);
            				}
        			}
           	 	}
			if(!operation.empty()){
				if(!nums.empty())
					delete nums.front();
				return nullptr;
        		}   
			return nums.front();
        	}
};
#endif //__PARSE_HPP__
