#ifndef __MATHML_TEST_HPP__
#define __MATHML_TEST_HPP__

#include "gtest/gtest.h"
#include "../headers/add.hpp"
#include "../headers/div.hpp"
#include "../headers/mult.hpp"
#include "../headers/sub.hpp"
#include "../headers/rand.hpp"
#include "../headers/pow.hpp"
#include "../headers/print.hpp"

TEST(MathMLTest, Sub10and6)
{
	Base* sub = new Sub(new Op(10),new Op(6));
	EXPECT_EQ("<math>\n\t<apply>\n\t\t<minus/>\n\t\t<cn>10.000000</cn>\n\t\t<cn>6.000000</cn>\n\t</apply>\n</math>", print_mathML(sub)); 
	delete sub;
}

TEST(MathMLTest, Mult7and8)
{
        Base* mult = new Mult(new Op(7),new Op(8));
        EXPECT_EQ("<math>\n\t<apply>\n\t\t<times/>\n\t\t<cn>7.000000</cn>\n\t\t<cn>8.000000</cn>\n\t</apply>\n</math>", print_mathML(mult));
        delete mult;
}

TEST(MathMLTest, Add3and4)
{
        Base* add = new Add(new Op(3),new Op(4));
	EXPECT_EQ("<math>\n\t<apply>\n\t\t<plus/>\n\t\t<cn>3.000000</cn>\n\t\t<cn>4.000000</cn>\n\t</apply>\n</math>", print_mathML(add));
        delete add;
}

TEST(MathMLTest, Div4and1)
{
        Base* div = new Div(new Op(4),new Op(1));
	EXPECT_EQ("<math>\n\t<apply>\n\t\t<divide/>\n\t\t<cn>4.000000</cn>\n\t\t<cn>1.000000</cn>\n\t</apply>\n</math>", print_mathML(div));
        delete div;
}


TEST(MathMLTest, Add1andSub5and1)
{
        Base* add1 = new Add(new Op(1),new Sub(new Op(5), new Op(1)));	
	EXPECT_EQ("<math>\n\t<apply>\n\t\t<plus/>\n\t\t<cn>1.000000</cn>\n\t\t\t<apply>\n\t\t\t\t<minus/>\n\t\t\t\t<cn>5.000000</cn>\n\t\t\t\t<cn>1.000000</cn>\n\t\t\t</apply>\n\t</apply>\n</math>",print_mathML(add1));
        delete add1;
}

TEST(MathMLTest, Pow5and2)
{
        Base* pow = new Pow(new Op(5),new Op(2));
	EXPECT_EQ("<math>\n\t<apple>\n\t\t<power/>\n\t\t<cn>5.000000</cn>\n\t\t<cn>2.000000</cn>\n\t</apply>\n</math>", print_mathML(pow));
        delete pow;
}

TEST(MathMLTest, DivMultPow)
{
        Base* divMult = new Div(new Mult(new Op(2),new Op(5)),new Pow(new Op(5), new Op(2)));
	EXPECT_EQ("<math>\n\t<apple>\n\t\t\t\t<power/>\n\t\t\t\t<cn>5.000000</cn>\n\t\t\t\t<cn>2.000000</cn>\n\t\t\t</apply>\n\t</apply>\n</math>", print_mathML(divMult));
        delete divMult;
}

#endif
