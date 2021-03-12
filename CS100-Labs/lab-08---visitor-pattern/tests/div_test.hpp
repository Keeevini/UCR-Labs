#ifndef __DIV_TEST_HPP__
#define __DIV_TEST_HPP__

#include "gtest/gtest.h"
#include "../headers/div.hpp"

TEST(DivTest, DivEvaluateNonZero) {
    Op* a = new Op(10);
    Op* b = new Op(2);
    Div* test = new Div(a,b);
    EXPECT_NEAR(test->evaluate(), 5, 0.001);
    delete test;
}

TEST(DivTest, DivEvaluateZero) {
    Op* a = new Op(0);
    Op* b = new Op(2);
    Div* test = new Div(a,b);
    EXPECT_NEAR(test->evaluate(), 0, 0.001);
    delete test;
}

TEST(DivTest, DivEvaluateDouble) {
    Op* a = new Op(5.5);
    Op* b = new Op(2.23);
    Div* test = new Div(a,b);
    EXPECT_NEAR(test->evaluate(), 2.46636, 0.00001);
    delete test;
}

TEST(DivTest, DivEvaluateTwONeg) {
    Op* a = new Op(-10);
    Op* b = new Op(-2);
    Div* test = new Div(a,b);
    EXPECT_NEAR(test->evaluate(), 5, 0.001);
    delete test;
}

TEST(DivTest, DivZeroDenom) {
    Op* a = new Op(10);
    Op* b = new Op(0);
    Div* test = new Div(a,b);
    EXPECT_EQ(test->evaluate(), 0);
    delete test;
}

TEST(DivTest, DivEvaluateNegative) {
    Op* a = new Op(-100);
    Op* b = new Op(25);
    Div* test = new Div(a,b);
    EXPECT_NEAR(test->evaluate(), -4, 0.001);
    delete test;
}

TEST(DivTest, DivStingifyNonZero) {
    Op* a = new Op(10);
    Op* b = new Op(2);
    Div* test = new Div(a,b);
    EXPECT_EQ(test->stringify(), "(10.000000 / 2.000000)");
    delete test;
}

TEST(DivTest, DivStingifyNegative) {
    Op* a = new Op(-1234);
    Op* b = new Op(4);
    Div* test = new Div(a,b);
    EXPECT_EQ(test->stringify(), "(-1234.000000 / 4.000000)");
    delete test;
}

TEST(DivTest, DivStingifyDouble) {
    Op* a = new Op(574.777);
    Op* b = new Op(347.721);
    Div* test = new Div(a,b);
    EXPECT_EQ(test->stringify(), "(574.777000 / 347.721000)");
    delete test;
}



#endif
