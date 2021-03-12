#ifndef __MULT_TEST_HPP__
#define __MULT_TEST_HPP__

#include "gtest/gtest.h"
#include "../headers/mult.hpp"

TEST(MultTest, MultEvaluateNonZero) {
    Op* a = new Op(10);
    Op* b = new Op(2);
    Mult* test = new Mult(a,b);
    EXPECT_NEAR(test->evaluate(), 20, 0.001);
    delete test;
}

TEST(MultTest, MultEvaluateDouble) {
    Op* a = new Op(5.5);
    Op* b = new Op(2.5);
    Mult* test = new Mult(a,b);
    EXPECT_NEAR(test->evaluate(), 13.75, 0.001);   
    delete test;
}

TEST(MultTest, MultEvaluateMultZero) {
    Op* a = new Op(5.5);
    Op* b = new Op(0);
    Mult* test = new Mult(a,b);
    EXPECT_EQ(test->evaluate(), 0);
    delete test;
}

TEST(MultTest, MultEvaluateMultNegative) {
    Op* a = new Op(5);
    Op* b = new Op(-10);
    Mult* test = new Mult(a,b);
    EXPECT_NEAR(test->evaluate(), -50, 0.001);
    delete test;
}

TEST(MultTest, MultEvaluateMultTwoNegative) {
    Op* a = new Op(-5);
    Op* b = new Op(-10);
    Mult* test = new Mult(a,b);
    EXPECT_NEAR(test->evaluate(), 50, 0.001);
    delete test;
}

TEST(MultTest, MultStringifyNonZero) {
    Op* a = new Op(5);
    Op* b = new Op(10);
    Mult* test = new Mult(a,b);
    EXPECT_EQ(test->stringify(), "(5.000000 * 10.000000)");
    delete test;
}

TEST(MultTest, MultStringifyDouble) {
    Op* a = new Op(5.234);
    Op* b = new Op(10.123);
    Mult* test = new Mult(a,b);
    EXPECT_EQ(test->stringify(), "(5.234000 * 10.123000)");
    delete test;
}

TEST(MultTest, MultStringifyNegatives) {
    Op* a = new Op(-5);
    Op* b = new Op(-10);
    Mult* test = new Mult(a,b);
    EXPECT_EQ(test->stringify(), "(-5.000000 * -10.000000)");
    delete test;
}



#endif
