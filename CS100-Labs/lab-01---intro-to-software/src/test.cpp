#include "../header/c-echo.h"

#include "gtest/gtest.h"

TEST(EchoTest, Helloworld) {
	char* test_val[3]; test_val[0] = "./c-echo"; test_val[1] = "hello"; test_val[2] = "world";
	EXPECT_EQ("hello world", echo(3, test_val));
}

TEST(EchoTest, EmptyString) {
	char* test_val[1]; test_val[0] = "./c-echo";
	EXPECT_EQ("", echo(1, test_val));
}


TEST(EchoTest, Numbers) {
	char* test_val[2]; test_val[0] = "./c-echo"; test_val[1] = "0123456789";
	EXPECT_EQ("0123456789", echo(2, test_val));
}

TEST(EchoTest, Letters) {
	char* test_val[2]; test_val[0] = "./c-echo"; test_val[1] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	EXPECT_EQ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", echo(2, test_val));
}


TEST(EchoTest, MultipleBlanks) {
	char* test_val[3]; test_val[0] = "./c-echo"; test_val[1] = ""; test_val[2] = "";
	EXPECT_EQ(" ", echo(3, test_val));
}

int main(int argc, char **argv) {
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}
