#ifndef __PARSE_TEST_HPP__
#define __PARSE_TEST_HPP__

#include "../headers/parse.hpp"
#include "gtest/gtest.h"
#include <string>

TEST(ParseTest, OneNum){
	char* test_val[2];
	test_val[0] = strdup("./calculator");
	test_val[1] = strdup("3");
	Factory* factory = new Parse();
	Base* calc = factory->parse(test_val, 2);
	EXPECT_EQ("3.000000", calc->stringify());
	delete factory;
	delete calc;
	for(int i = 0; i < 2; i++){
		free(test_val[i]);
	}
}

TEST(ParseTest, TwoDigitNum){
	char* test_val[2];
	test_val[0] = strdup("./calculator");
	test_val[1] = strdup("12");
	Factory* factory = new Parse();
	Base* calc = factory-> parse(test_val, 2);
	EXPECT_EQ("12.000000",calc->stringify());
        delete factory;
        delete calc;
        for(int i = 0; i < 2; i++){
                free(test_val[i]);
        }
}

TEST(ParseTest, Addition){
	char* test_val[4];
	test_val[0] = strdup("./calculator");
	test_val[1] = strdup("14");
	test_val[2] = strdup("+");
	test_val[3] = strdup("7");
	Factory* f = new Parse();
	Base* calc = f-> parse(test_val, 4);
	EXPECT_EQ("(14.000000 + 7.000000)", calc->stringify());
        delete f;
        delete calc;
        for(int i = 0; i < 4; i++){
                free(test_val[i]);
        }
}

TEST(InvalidTest, OneOperand) {
	char* test_val[3];
	test_val[0] = strdup("./calculator");
	test_val[1] = strdup("1");
	test_val[2] = strdup("+");
	Factory* factory = new Parse();
	Base* test = factory->parse(test_val, 3);
	EXPECT_EQ(test, nullptr);
        delete factory;
        delete test;
        for(int i = 0; i < 3; i++){
                free(test_val[i]);
        }	
}

TEST(InvalidTest, NoOperand) {
        char* test_val[3];
        test_val[0] = strdup("./calculator");
        test_val[1] = strdup("-");
        test_val[2] = strdup("+");
        Factory* factory = new Parse();
        Base* test = factory->parse(test_val, 3);
        EXPECT_EQ(test, nullptr);
        delete factory;
        delete test;
        for(int i = 0; i < 3; i++){
                free(test_val[i]);
        }
}

TEST(InvalidTest, TwoOperand) {
        char* test_val[5];
        test_val[0] = strdup("./calculator");
        test_val[1] = strdup("1");
        test_val[2] = strdup("+");
	test_val[3] = strdup("2");
	test_val[4] = strdup("/");
        Factory* factory = new Parse();
        Base* test = factory->parse(test_val, 5);
        EXPECT_EQ(test, nullptr);
        delete factory;
        delete test;
        for(int i = 0; i < 5; i++){
                free(test_val[i]);
        }
}

TEST(InvalidTest, MultAddSubDivMultInv) {
        char* test_val[10];
        test_val[0] = strdup("./calculator");
        test_val[1] = strdup("200");
        test_val[2] = strdup("*");
        test_val[3] = strdup("5");
        test_val[4] = strdup("+");
        test_val[5] = strdup("10");
        test_val[6] = strdup("-");
        test_val[7] = strdup("2");
        test_val[8] = strdup("/");
        test_val[9] = strdup("*");
        Factory* factory = new Parse();
        Base* test = factory->parse(test_val, 10);
        EXPECT_EQ(nullptr, test);
        delete factory;
        delete test;
        for(int i = 0; i < 10; i++){
                free(test_val[i]);
        }
}

TEST(LongerEquation, AddDiv) {
        char* test_val[6];
        test_val[0] = strdup("./calculator");
        test_val[1] = strdup("1");
        test_val[2] = strdup("+");
        test_val[3] = strdup("2");
        test_val[4] = strdup("/");
	test_val[5] = strdup("3");
        Factory* factory = new Parse();
        Base* test = factory->parse(test_val, 6);
        EXPECT_EQ(test->evaluate(), 1);
        delete factory;
        delete test;
        for(int i = 0; i < 6; i++){
                free(test_val[i]);
        }
}

TEST(LongerEquation, SubPow) {
        char* test_val[6];
        test_val[0] = strdup("./calculator");
        test_val[1] = strdup("10");
        test_val[2] = strdup("-");
        test_val[3] = strdup("2");
        test_val[4] = strdup("**");
        test_val[5] = strdup("3");
        Factory* factory = new Parse();
        Base* test = factory->parse(test_val, 6);
        EXPECT_EQ(test->evaluate(), 512);
        delete factory;
        delete test;
        for(int i = 0; i < 6; i++){
                free(test_val[i]);
        }
}

TEST(LongerEquation, MultAddSubDiv) {
        char* test_val[10];
        test_val[0] = strdup("./calculator");
        test_val[1] = strdup("200");
        test_val[2] = strdup("*");
        test_val[3] = strdup("5");
        test_val[4] = strdup("+");
        test_val[5] = strdup("10");
	test_val[6] = strdup("-");
        test_val[7] = strdup("2");
	test_val[8] = strdup("/");
	test_val[9] = strdup("10");
        Factory* factory = new Parse();
        Base* test = factory->parse(test_val, 10);
        EXPECT_EQ(test->evaluate(), 100.8);
        delete factory;
        delete test;
        for(int i = 0; i < 10; i++){
                free(test_val[i]);
        }
}

TEST(ParseTest, Subtraction){
	char* test[4];
	test[0] = strdup("./calculator"); test[1] = strdup("8"); test[2] = strdup("-"); test[3] = strdup("3");
	Factory* f = new Parse();
	Base* calc = f->parse(test, 4);
	EXPECT_EQ("(8.000000 - 3.000000)", calc->stringify());
        delete f;
        delete calc;
        for(int i = 0; i < 4; i++){
                free(test[i]);
        }
}

TEST(ParseTest, SubNegative){
	char* test[4];
	test[0]= strdup("./calculator"); test[1]= strdup("4"); test[2]= strdup("-"); test[3]= strdup("7");
	Factory* f = new Parse();
	Base* calc = f->parse(test, 4);
	EXPECT_EQ(-3, calc->evaluate());
	delete f;
        delete calc;
        for(int i = 0; i < 4; i++){
                free(test[i]);
        }
}

TEST(ParseTest, Mult){
	char* test[4];
	test[0]= strdup("./calculator"); test[1]= strdup("3"); test[2]= strdup("*"); test[3]= strdup("5");
	Factory* f = new Parse();
	Base* calc = f->parse(test, 4);
	EXPECT_EQ(15, calc->evaluate());
        delete f;
        delete calc;
        for(int i = 0; i < 4; i++){
                free(test[i]);
        }
}

TEST(ParseTest, Pow){
	char* test[4];
	test[0] = strdup("./calculator"); test[1] = strdup("2"); test[2] = strdup("**"); test[3]= strdup("5");
	Factory* f = new Parse();
	Base* calc = f->parse(test,4);
	EXPECT_EQ(32, calc->evaluate());
        delete f;
        delete calc;
        for(int i = 0; i < 4; i++){
                free(test[i]);
        }
}

TEST(ParseTest, Div){
	char* test[4];
	test[0] = strdup("./calculator"); test[1] = strdup("55"); test[2] = strdup("/"); test[3] = strdup("5");
	Factory* f = new Parse();
	Base* calc = f->parse(test, 4);
	EXPECT_EQ(11, calc->evaluate());
        delete f;
        delete calc;
        for(int i = 0; i < 4; i++){
                free(test[i]);
        }
}

#endif
