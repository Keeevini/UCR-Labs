#ifndef __ITERATOR_TEST_HPP__
#define __ITERATOR_TEST_HPP__

#include "gtest/gtest.h"
#include "../headers/add.hpp"
#include "../headers/div.hpp"
#include "../headers/mult.hpp"
#include "../headers/sub.hpp"
#include "../headers/rand.hpp"
#include "../headers/pow.hpp"

TEST(FunctionTest, AddGetChild)
{
        Base *one = new Op(1);
        Base *three = new Op(3);
        Base *add = new Add(one,three);

        EXPECT_EQ("1.000000", add->get_child(0)->stringify());
        EXPECT_EQ("3.000000", add->get_child(1)->stringify());
        EXPECT_EQ(1.000000, add->get_child(0)->evaluate());
        EXPECT_EQ(3.000000, add->get_child(1)->evaluate());

        delete add;
}

TEST(FunctionTest, AddNumberOfChildren)
{
        Base *one = new Op(1);
        Base *three = new Op(3);
        Base *add = new Add(one,three);

        EXPECT_EQ(2, add->number_of_children());

        delete add;
}

TEST(FunctionTest, SubGetChild_LeftOperandAdd)
{
        Base *left = new Add(new Op(10.125), new Op(5.125));
        Base *right = new Op(3);
        Base *sub = new Sub(left, right);

        EXPECT_EQ("(10.125000 + 5.125000)", sub->get_child(0)->stringify());
        EXPECT_EQ("3.000000", sub->get_child(1)->stringify());
        EXPECT_EQ(15.250000, sub->get_child(0)->evaluate());
        EXPECT_EQ(3.000000, sub->get_child(1)->evaluate());

        delete sub;
}
TEST(FunctionTest, SubNumberOfChildren)
{
        Base *left = new Add(new Op(10.125), new Op(5.125));
        Base *right = new Op(3);
        Base *sub = new Sub(left, right);

        EXPECT_EQ(2, sub->number_of_children());

        delete sub;
}

TEST(FunctionTest, MultGetChild_RightOperandSub)
{
        Base *left = new Add(new Op(10.125), new Op(5.125));
        Base *right = new Sub(new Op(2.25), new Op(-25));
        Base *mult = new Mult(left, right);

        EXPECT_EQ("(10.125000 + 5.125000)", mult->get_child(0)->stringify());
        EXPECT_EQ("(2.250000 - -25.000000)", mult->get_child(1)->stringify());
        EXPECT_EQ(15.250000, mult->get_child(0)->evaluate());
        EXPECT_EQ(27.25, mult->get_child(1)->evaluate());

        delete mult;
}

TEST(FunctionTest, MultNumberOfChildren)
{
        Base *left = new Add(new Op(10.125), new Op(5.125));
        Base *right = new Sub(new Op(2.25), new Op(-25));
        Base *mult = new Mult(left, right);

        EXPECT_EQ(2, mult->number_of_children());

        delete mult;
}

TEST(FunctionTest, DivGetChild)
{
        Base *left = new Mult(new Op(10.125), new Op(5.125));
        Base *right = new Mult(new Op(2.25), new Op(-25));
        Base *div = new Div(left, right);

        EXPECT_EQ("(10.125000 * 5.125000)", div->get_child(0)->stringify());
        EXPECT_EQ("(2.250000 * -25.000000)", div->get_child(1)->stringify());
        EXPECT_EQ(51.890625, div->get_child(0)->evaluate());
        EXPECT_EQ(-56.25, div->get_child(1)->evaluate());

        delete div;
}
TEST(FunctionTest, DivNumberOfChildren)
{
        Base *left = new Mult(new Op(10.125), new Op(5.125));
        Base *right = new Mult(new Op(2.25), new Op(-25));
        Base *div = new Div(left, right);

        EXPECT_EQ(2, div->number_of_children());

        delete div;
}

TEST(FunctionTest, PowGetChild)
{
        Base *left = new Sub(new Op(10.125), new Op(5.125));
        Base *right = new Add(new Op(2.25), new Op(-2.25));
        Base *pow = new Pow(left, right);

        EXPECT_EQ("(10.125000 - 5.125000)", pow->get_child(0)->stringify());
        EXPECT_EQ("(2.250000 + -2.250000)", pow->get_child(1)->stringify());
        EXPECT_EQ(5.000000, pow->get_child(0)->evaluate());
        EXPECT_EQ(0, pow->get_child(1)->evaluate());

        delete pow;
}

TEST(FunctionTest, PowNumberOfChildren)
{
        Base *left = new Sub(new Op(10.125), new Op(5.125));
        Base *right = new Add(new Op(2.25), new Op(-2.25));
        Base *pow = new Pow(left, right);

        EXPECT_EQ(2, pow->number_of_children());

        delete pow;
}

TEST(FunctionTest, OpGetChild)
{
        Base *op = new Op(9999999.999999);
        EXPECT_EQ(nullptr, op->get_child(0));

        delete op;
}

TEST(FunctionTest, OpNumberOfChildren)
{
        Base *op = new Op(9999999.999999);

        EXPECT_EQ(0, op->number_of_children());

        delete op;
}

TEST(FunctionTest, RandGetChild)
{
        Base *rand = new Rand();
        EXPECT_EQ(nullptr, rand->get_child(0));

        delete rand;
}

TEST(FunctionTest, RandNumberOfChildren)
{
        Base *rand = new Rand();

        EXPECT_EQ(0, rand->number_of_children());

        delete rand;
}

#endif
