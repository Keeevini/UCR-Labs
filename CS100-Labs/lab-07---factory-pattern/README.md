# Factory Pattern

> Author: Brian Crites ([@brrcrites](https://github.com/brrcrites))

**You *must* work in a group of two for this lab**

In this lab you will create a factory which can take in user input and generate a correct expression tree, represented by a `Base*` root node which will be returned to the caller. Your factory should have a single public method `Base* parse(char** input, int length)`. You will need to parse the inputs to generate the corresponding expression tree, and can assume there are no parenthesies and spaces between each number and operator. You also do not need to consider precedence for the operations and can assume they should be executed from left to right. For example, the input `3 + 2 * 6` would result in `(3 + 2) * 6 = 30` rather than the normal `3 + (2 * 6) = 15` In the case that the input is invalid you should print an error and return back a `nullptr` to the caller.


## Main

For this lab you should have both a main executable and a test executable. Your main executable should be named `calculator` and should take the `char** argv` and the `int argc` input to main and pass it to the factory. The factory should then convert it to an expression tree, and then you should print the `stringify()` and `evaluate()` values of the generated expression tree back to the user.

> Note: When you run something like `./calculator 4 * 3` or `./calculator 4 ** 3`, Bash will see the `*` and treat it as a [wildcard operator](https://tldp.org/LDP/GNU-Linux-Tools-Summary/html/x11655.htm). To avoid this issue, just prepend the `*` character with `\` on the command line. So, you should run `./calculator 4 \* 3` or `./calculator 4 \*\* 3` instead of the commands above.

## Unit Testing

When creating unit tests for the factory you can generate mock user input similar to the way it was created in the unit testing lab. Make sure to test that all combinations of operators are being parsed correctly and that it can generate trees with various numbers of operators and operands. You should also test that your factory correctly returns a `nullptr` when invalid input is provided.

## Submission

To receive credit for this lab you must show an example program to your TA that demonstrates the full functionality of this pattern, including any interactions with other patterns. You must also show your TA the tests that you have created for validating that your classes are functioning correctly.
