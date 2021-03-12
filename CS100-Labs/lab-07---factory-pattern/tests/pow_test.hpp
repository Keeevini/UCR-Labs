#ifndef __POW_TEST_HPP__
#define __POW_TEST_HPP__

#include "gtest/gtest.h"
#include "../headers/pow.hpp"

TEST(PowTest, PowEvaluateNonZero) {
	Op* a = new Op(2);
	Op* b = new Op(3);
	Pow* test = new Pow(a,b);
	EXPECT_NEAR(test->evaluate(), 8, 0.0001);
	delete test;
}

TEST(PowTest, PowEvaluateZeroPower){
	Op* a = new Op(5);
	Op* b = new Op(0);
	Pow* test = new Pow(a,b);
	EXPECT_NEAR(test->evaluate(), 1, 0.00001);
        delete test;
}

TEST(PowTest, PowEvaluateZeroBase){
	Op* a = new Op(0);
	Op* b = new Op(2);
	Pow* test = new Pow(a,b);
	EXPECT_NEAR(test->evaluate(), 0, 0.00001);
        delete test;
}

TEST(PowTest, PowEvaluateNegativeExpo){
	Op* a = new Op(16);
	Op* b = new Op(-2);
	Pow* test = new Pow(a,b); //0.00390625
	EXPECT_NEAR(test->evaluate(), 0.0039, 0.0001);
        delete test;
}

TEST(PowTest, PowEvaluateNegativeBase){
	Op* a = new Op(-3);
	Op* b = new Op(3);
	Pow* test = new Pow(a,b);
	EXPECT_NEAR(test->evaluate(), -27, 0.0001);
        delete test;
}

TEST(PowTest, PowEvaluateDoubleExpo){
	Op* a = new Op(2);
	Op* b = new Op(2.5);
	Pow* test = new Pow(a,b);//5.65685424949
	EXPECT_NEAR(test->evaluate(), 5.6568, 0.0001);
        delete test;
}

TEST(PowTest, PowEvaluateDoubleBase){
	Op* a = new Op(3.2);
	Op* b = new Op(2);
	Pow* test = new Pow(a,b); //10.24
	EXPECT_NEAR(test->evaluate(), 10.24, 0.01);
        delete test;
}

TEST(PowTest, PowStringNonZero){
	Op* a = new Op(2);
	Op* b = new Op(5);
	Pow* test = new Pow(a,b);
	EXPECT_EQ(test->stringify(), "(2.000000 ** 5.000000)");
        delete test;
}

TEST(PowTest, PowStringNegative){
	Op* a = new Op(-5);
	Op* b = new Op(3);
	Pow* test = new Pow(a,b);
	EXPECT_EQ(test->stringify(), "(-5.000000 ** 3.000000)");
        delete test;
}

TEST(PowTest, PowStringDouble){
	Op* a = new Op(0.333);
	Op* b = new Op(2.222);
	Pow* test = new Pow(a,b);
	EXPECT_EQ(test->stringify(), "(0.333000 ** 2.222000)");
        delete test;
}



#endif
