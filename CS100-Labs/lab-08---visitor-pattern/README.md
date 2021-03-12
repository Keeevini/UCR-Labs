# Visitor Pattern

> Author: Brian Crites ([@brrcrites](https://github.com/brrcrites))

**You *must* work in a group of two for this lab**

## Iterator Class

You've been provided with an iterator classes `Iterator` which can be created by the user to traverse an entire expression tree.  This iterator is special in that it visits each node of the tree multiple times.  Nodes with no children are visited once.  Nodes with one child are visited twice (before and after visiting the child).  Nodes with two children are visited three times (before visiting the first child, after visiting the first child but before visiting the second, and then again after visiting the second child).  The iterator points to the first node to visit upon construction.  Calling `next()` advances the iterator to the next node to be visited.  `current_op()` returns a pointer to the current node being visited, and `current_index()` tells you which visit to that node is being made (0, 1, or 2 for binary operators).  When `is_done()` returns true, iteration has finished, and you must not call any other functions on the iterator.

To support simple iteration of nodes, two virtual methods `number_of_children()` and `get_child(int i)` have been added to the `Base` class.  You will need to add suitable definitions for these methods to your own derived classes.  You may assume that `get_child(int i)` will only be called with `i < number_of_children()`.  It particular, it will never be called on nodes with no children.

Before moving on to the visitor portion of this lab, make sure to create a number of unit tests to test your new functions.

## The Visitor Class

Now you will set up a visitor pattern which, when paired with the `Iterator` class from the previous section will allow you to implement a fairly diverse set of operations on the expression tree.  In the next section, we will use this to print out the expression tree in two different ways.  The `Visitor` base class is shown below (in visitor.hpp) will be used as our interface for visiting the expression tree.

```c++
class Visitor{
    public:
        virtual ~Visitor() = default;

        // Nodes with no children are visited only once (index = 0)
        virtual void visit_op(Op* node) = 0;
        virtual void visit_rand(Rand* node) = 0;

        // Nodes with two children are visited three times.
        // index = 0 -> begin
        // index = 1 -> middle
        // index = 2 -> end
        virtual void visit_add_begin(Add* node) = 0;
        virtual void visit_add_middle(Add* node) = 0;
        virtual void visit_add_end(Add* node) = 0;
        virtual void visit_sub_begin(Sub* node) = 0;
        virtual void visit_sub_middle(Sub* node) = 0;
        virtual void visit_sub_end(Sub* node) = 0;
        virtual void visit_mult_begin(Mult* node) = 0;
        virtual void visit_mult_middle(Mult* node) = 0;
        virtual void visit_mult_end(Mult* node) = 0;
        virtual void visit_div_begin(Div* node) = 0;
        virtual void visit_div_middle(Div* node) = 0;
        virtual void visit_div_end(Div* node) = 0;
        virtual void visit_pow_begin(Pow* node) = 0;
        virtual void visit_pow_middle(Pow* node) = 0;
        virtual void visit_pow_end(Pow* node) = 0;
};
```

## Modifying the Expression Tree Elements

You will need to modify all the classes that can exist in an expression tree to allow for the `Visitor` to visit them. You should add the function `void accept(Visitor* visitor, int index)` to the necessary classes which will then call the appropriate function within the `Visitor`.  Note that nodes with no children have one function in the visitor (`visit_op`) and nodes with two children have three functions in the visitor (`visit_add_begin`, `visit_add_middle`, and `visit_add_end`).  Your `accept` function should call the appropriate function based on its `index` input.

## Using the visitor to print LaTeX

In this section, we will implement a function `std::string PrintLaTeX(Base* ptr)` to print our expression tree in LaTeX syntax.  We will implement this function by creating a new Visitor derived class VisitorLaTeX and using the `Iterator` to traverse the tree.  You should not need to change `Base` or any of its derived classes while completing this section.  To keep the logic simple, we will put grouping symbols {} around everything (operations and numbers).  In addition, we will put parenthesis around all operators other than division.  Note that LaTeX math begins and ends with a `$`.  Examples of suitable output are shown below.  Use +, -, \cdot, and ^ for addition, subtraction, multiplication, and power.  Use \frac{numerator}{denominator} for division.

1+(5-0) => ${({1}+{({5}-{0})})}$

5^2 => ${({5}^{2})}$

2*5 => ${({2}\cdot{5})}$

2/3 => ${\frac{2}{3}}$

(2*5)/(5^2) => ${\frac{({2}\cdot{5})}{({5}^{2})}}$

## Using the visitor to print MathML

In this section, we will create another function `std::string PrintMathML(Base* ptr)` and a corresponding visitor class VisitMathML to print out our expression trees in Content MathML syntax, with indentation for readibility.  You should not need to change `Base` or any of its derived classes while completing this section.  The five examples in the previous section should produce the following outputs:

```xml
<math>
  <apply>
    <plus/>
    <cn>1</cn>
    <apply>
      <minus/>
      <cn>5</cn>
      <cn>0</cn>
    </apply>
  </apply>
</math>
```

```xml
<math>
  <apply>
    <power/>
    <cn>5</cn>
    <cn>2</cn>
  </apply>
</math>
```

```xml
<math>
  <apply>
    <times/>
    <cn>2</cn>
    <cn>5</cn>
  </apply>
</math>
```

```xml
<math>
  <apply>
    <divide/>
    <cn>2</cn>
    <cn>3</cn>
  </apply>
</math>
```

```xml
<math>
  <apply>
    <divide/>
    <apply>
      <times/>
      <cn>2</cn>
      <cn>5</cn>
    </apply>
    <apply>
      <power/>
      <cn>5</cn>
      <cn>2</cn>
    </apply>
  </apply>
</math>
```

## Submission

To receive credit for this lab you must show an example program to your TA that demonstrates the full functionality of this pattern, including any interactions with other patterns. You must also show your TA the tests that you have created for validating that your classes are functioning correctly.

