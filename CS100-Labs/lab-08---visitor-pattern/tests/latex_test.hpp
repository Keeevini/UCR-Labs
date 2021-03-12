#ifndef __LATEX_TEST_HPP__
#define __LATEX_TEST_HPP__

#include "gtest/gtest.h"
#include "../headers/add.hpp"
#include "../headers/div.hpp"
#include "../headers/mult.hpp"
#include "../headers/sub.hpp"
#include "../headers/rand.hpp"
#include "../headers/pow.hpp"
#include "../headers/print.hpp"

TEST(LatexTest, Sub10and6)
{
	Base* add1 = new Sub(new Op(10),new Op(6));
	EXPECT_EQ(print_latex(add1),"${({10.000000}-{6.000000})}$" ); 
	delete add1;
}

TEST(LatexTest, Mult7and8)
{
        Base* add1 = new Mult(new Op(7),new Op(8));
        EXPECT_EQ(print_latex(add1),"${({7.000000}\\cdot{8.000000})}$" );
        delete add1;
}

TEST(LatexTest, Add3and4)
{
        Base* add1 = new Add(new Op(3),new Op(4));
        EXPECT_EQ(print_latex(add1),"${({3.000000}+{4.000000})}$" );
        delete add1;
}

TEST(LatexTest, Div4and1)
{
        Base* add1 = new Div(new Op(4),new Op(1));
        EXPECT_EQ(print_latex(add1),"${\\frac{4.000000}{1.000000}}$" );
        delete add1;
}


TEST(LatexTest, Add1andSub5and1)
{
        Base* add1 = new Add(new Op(1),new Sub(new Op(5), new Op(1)));	
        EXPECT_EQ(print_latex(add1),"${({1.000000}+{({5.000000}-{1.000000})})}$" );
        delete add1;
}

TEST(LatexTest, Pow5and2)
{
        Base* add1 = new Pow(new Op(5),new Op(2));
        EXPECT_EQ(print_latex(add1),"${({5.000000}^{2.000000})}$" );
        delete add1;
}

TEST(LatexTest, DivMultPow)
{
        Base* add1 = new Div(new Mult(new Op(2),new Op(5)),new Pow(new Op(5), new Op(2)));
        EXPECT_EQ(print_latex(add1),"${\\frac{({2.000000}\\cdot{5.000000})}{({5.000000}^{2.000000})}}$" );
        delete add1;
}

#endif
