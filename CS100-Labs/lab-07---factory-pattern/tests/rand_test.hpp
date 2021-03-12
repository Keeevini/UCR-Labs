#ifndef __RAND_TEST_HPP___
#define __RAND_TEST_HPP__

#include "gtest/gtest.h"
#include "../headers/rand.hpp"
#include <string>

TEST(RandTest, RandEvaluateLT100) {
	Rand* test = new Rand();
	EXPECT_LT(test->evaluate(), 100);
	delete test;
}

TEST(RandTest, RandEvaluateGT0) {
	Rand* test = new Rand();
	EXPECT_GT(test->evaluate(), 0);
        delete test;
}

TEST(RandTest, RandStringLT100) {
	Rand* test = new Rand();
	EXPECT_LT(stoi(test->stringify()), 100);
	delete test;
}

TEST(RandTest, RnadStringGT0) {
	Rand* test = new Rand();
	EXPECT_GT(stoi(test->stringify()), 0);
        delete test;
}


#endif
