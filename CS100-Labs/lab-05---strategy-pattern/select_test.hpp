#ifndef __SELECT_TEST_HPP__
#define __SELECT_TEST_HPP__

#include "gtest/gtest.h"

#include <sstream>
#include "spreadsheet.hpp"
#include "spreadsheet.cpp"
#include "select.hpp"
#include "select_contains.hpp"
#include "select_and.hpp"
#include "select_not.hpp"
#include "select_or.hpp"

TEST(PrintTest, Nothing) {
	Spreadsheet input;
	input.set_column_names({});
	input.add_row({});	
	
	Spreadsheet output;
	output.set_column_names({});
	output.add_row({});
	
	std::stringstream in;
	std::stringstream out;
	input.print_selection(in);
	output.print_selection(out);
	EXPECT_EQ(in.str(), out.str());
}

TEST(PrintTest, SameColumns) {
	Spreadsheet input;
	input.set_column_names({"first","first","last"});
	input.add_row({"Adam","Smith","Sophomore"});
	
	Spreadsheet output;
	output.set_column_names({"first","last","grade"});
        output.add_row({"Adam","Smith","Sophomore"});

        std::stringstream in;
        std::stringstream out;
        input.print_selection(in);
        output.print_selection(out);
        EXPECT_EQ(in.str(), out.str());
}
/*
TEST(SelectNotTest, WrongColumn) {
	Spreadsheet input;
        input.set_column_names({"first","first","last"});
        input.add_row({"Adam","Smith","Sophomore"});
	input.set_selection(new Select_Not(new Select_Contains(&input, "second", "Adam")));

        Spreadsheet output;
	output.set_column_names({});
        output.add_row({});

        std::stringstream in;
        std::stringstream out;
        input.print_selection(in);
        output.print_selection(out);
        EXPECT_EQ(in.str() + "\n", out.str());
}
*/
TEST(SelectContainsTest, ContainsWord) {
	Spreadsheet input;
	input.set_column_names({"first", "last", "grade"});
 	input.add_row({"Adam", "Smith", "Sophomore"});
        input.set_selection(new Select_Contains(&input, "first", "Adam"));
    
        Spreadsheet output;
        output.set_column_names({"first", "last", "grade"});
        output.add_row({"Adam", "Smith", "Sophomore"});
    
        std::stringstream in;
        std::stringstream out;
        input.print_selection(in);
        output.print_selection(out);
        EXPECT_EQ(in.str(), out.str());
}

TEST(SelectContainsTest, ContainsPartofWord) {
	Spreadsheet input;
        input.set_column_names({"first", "last", "grade"});
        input.add_row({"Adam", "Smith", "Sophomore"});
        input.set_selection(new Select_Contains(&input, "first", "da"));

        Spreadsheet output;
        output.set_column_names({"first", "last", "grade"});
        output.add_row({"Adam", "Smith", "Sophomore"});

        std::stringstream in;
        std::stringstream out;
        input.print_selection(in);
        output.print_selection(out);
        EXPECT_EQ(in.str(), out.str());
}

TEST(SelectContainsTest, ContainsEmpty) {
        Spreadsheet input;
        input.set_column_names({"last"});
        input.add_row({"Smith"});
        input.set_selection(new Select_Contains(&input, "last", ""));

        Spreadsheet output;
        output.set_column_names({"last"});
        output.add_row({"Smith"});

        std::stringstream in;
        std::stringstream out;
        input.print_selection(in);
        output.print_selection(out);
        EXPECT_EQ(in.str(), out.str());
}


TEST(SelectContainsTest, DoesNotMatchWords) {
        Spreadsheet input;
        input.set_column_names({"last"});
        input.add_row({"Smith"});
        input.set_selection(new Select_Contains(&input, "last", "smi"));

        Spreadsheet output;
        output.set_column_names({});
        output.add_row({});

        std::stringstream in;
        std::stringstream out;
        input.print_selection(in);
        output.print_selection(out);
        EXPECT_EQ(in.str() + "\n", out.str());
}

TEST(SelectAndTest, Accuracy) {
        Spreadsheet input;
        input.set_column_names({"first", "last", "grade"});
        input.add_row({"Adam", "Smith", "Sophomore"});
        input.set_selection(new Select_And(new Select_Contains(&input, "first", "Adam"), new Select_Contains(&input, "last", "Smith")));

        Spreadsheet output;
        output.set_column_names({"first", "last", "grade"});
        output.add_row({"Adam", "Smith", "Sophomore"});

        std::stringstream in;
        std::stringstream out;
        input.print_selection(in);
        output.print_selection(out);
        EXPECT_EQ(in.str(), out.str());
}

TEST(SelectOrTest, Accuracy) {
        Spreadsheet input;
        input.set_column_names({"first", "last", "grade"});
        input.add_row({"Adam", "Smith", "Sophomore"});
        input.set_selection(new Select_Or(new Select_Contains(&input, "first", "Adam"), new Select_Contains(&input, "last", "Smith")));

        Spreadsheet output;
        output.set_column_names({"first", "last", "grade"});
        output.add_row({"Adam", "Smith", "Sophomore"});

        std::stringstream in;
        std::stringstream out;
        input.print_selection(in);
        output.print_selection(out);
        EXPECT_EQ(in.str(), out.str());
}

TEST(SelectNotTest, Accuracy) {
        Spreadsheet input;
        input.set_column_names({"first", "last", "grade"});
        input.add_row({"Adam", "Smith", "Sophomore"});
        input.set_selection(new Select_Not(new Select_Contains(&input, "first", "Adam")));

        Spreadsheet output;
        output.set_column_names({"first", "last", "grade"});
        output.add_row({"Adam", "Smith", "Sophomore"});
	output.set_selection(new Select_Not(new Select_Contains(&input, "last", "Smith")));

        std::stringstream in;
        std::stringstream out;
        input.print_selection(in);
        output.print_selection(out);
        EXPECT_EQ(in.str(), out.str());
}


#endif //__SELECT_TEST_HPP__
