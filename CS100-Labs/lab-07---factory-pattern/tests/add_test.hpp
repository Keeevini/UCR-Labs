#ifndef __ADD_TEST_HPP__
#define __ADD_TEST_HPP__

#include "gtest/gtest.h"
#include "../headers/add.hpp"

TEST(AddTest, AddEvaluateNonZero) {
    Op* a = new Op(7);
    Op* b = new Op(8);
    Add* test = new Add(a,b);
    EXPECT_NEAR(test->evaluate(), 15, 0.001);
    delete test;
}

TEST(AddTest, AddEvaluateZero) {
    Op* a = new Op(7);
    Op* b = new Op(0);
    Add* test = new Add(a,b);
    EXPECT_NEAR(test->evaluate(), 7, 0.001);
    delete test;
}

TEST(AddTest, AddEvaluateDouble) {
    Op* a = new Op(2.222);
    Op* b = new Op(9.555);
    Add* test = new Add(a,b);
    EXPECT_NEAR(test->evaluate(), 11.777, 0.001);
    delete test;
}

TEST(AddTest, AddEvaluateNegative) {
    Op* a = new Op(-185);
    Op* b = new Op(178);
    Add* test = new Add(a,b);
    EXPECT_NEAR(test->evaluate(), -7, 0.001);
    delete test;
}

TEST(AddTest, AddStringifyNonZero) {
    Op* a = new Op(12);
    Op* b = new Op(77);
    Add* test = new Add(a,b);
    EXPECT_EQ(test->stringify(), "(12.000000 + 77.000000)");
    delete test;
}

TEST(AddTest, AddStringifyNegative) {
    Op* a = new Op(-412);
    Op* b = new Op(-87);
    Add* test = new Add(a,b);
    EXPECT_EQ(test->stringify(), "(-412.000000 + -87.000000)");
    delete test;
}

TEST(AddTest, AddStringifyDouble) {
    Op* a = new Op(198.34777);
    Op* b = new Op(74.0234);
    Add* test = new Add(a,b);
    EXPECT_EQ(test->stringify(), "(198.347770 + 74.023400)");
    delete test;
}

#endif
