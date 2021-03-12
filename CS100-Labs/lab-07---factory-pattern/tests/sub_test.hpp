#ifndef __SUB_TEST_HPP__
#define __SUB_TEST_HPP__

#include "gtest/gtest.h"
#include "../headers/sub.hpp"
using namespace std;

TEST(SubTest, SubEvaluateNonZero) {
	Op* a = new Op(5);
	Op* b = new Op(2);
	Sub* test = new Sub(a,b);
	EXPECT_NEAR(test->evaluate(), 3, 0.001);
        delete test;
}


TEST(SubTest, SubEvaluateDouble) {
	Op* a = new Op(7.777);
	Op* b = new Op(4.444);
	Sub* test = new Sub(a, b);
	EXPECT_NEAR(test->evaluate(), 3.333, 0.001);
        delete test;
}

TEST(SubTest, SubEvaluateSub0) {
	Op* a = new Op(5);
	Op* b = new Op(0);
	Sub* test = new Sub(a,b);
	EXPECT_NEAR(test->evaluate(), 5, 0.00001);
        delete test;
}

TEST(SubTest, SubEvaluateSubFrom0){
	Op* a = new Op(0);
	Op* b = new Op(3);
	Sub* test = new Sub(a,b);
	EXPECT_NEAR(test->evaluate(), -3, 0.0001);
        delete test;
}

TEST(SubTest, SubStringNonZero){
	Op* a = new Op(5);
	Op* b = new Op(2);
	Sub* test = new Sub(a,b);
	EXPECT_EQ(test->stringify(), "(5.000000 - 2.000000)");
        delete test;
}

TEST(SubTest, SubStringZero){
	Op* a = new Op(3);
	Op* b = new Op(3);
	Sub* test = new Sub(a,b);
	EXPECT_EQ(test->stringify(), "(3.000000 - 3.000000)");
        delete test;
}

TEST(SubTest, SubStringNegative){
	Op* a = new Op(4);
	Op* b = new Op(6);
	Sub* test = new Sub(a,b);
	EXPECT_EQ(test->stringify(), "(4.000000 - 6.000000)");
        delete test;
}

TEST(SubTest, SubStringDouble){
	Op* a = new Op(7.7777);
	Op* b = new Op(2.2222);
	Sub* test = new Sub(a,b);
	EXPECT_EQ(test->stringify(), "(7.777700 - 2.222200)");
        delete test;
}

#endif
