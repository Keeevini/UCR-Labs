#ifndef __ITERATOR_HPP__
#define __ITERATOR_HPP__

#include <stack>
#include <utility>

#include "base.hpp"

class Iterator {
    protected:
        struct base_iterator
        {
            base_iterator(Base* ptr);
            Base* ptr;
            int index;
            int number_children;
        };
        std::stack<base_iterator> node_stack;

    public:
        Iterator(Base* ptr);

        void next();
        bool is_done();
        Base* current_node();
        int current_index();
};

#endif
