#include "iterator.hpp"

#include <iostream>
        
Iterator::Iterator(Base* ptr)
{
    node_stack.push(base_iterator(ptr));
}

Iterator::base_iterator::base_iterator(Base* ptr)
    :ptr(ptr),index(0),number_children(ptr->number_of_children())
{
}

void Iterator::next()
{
    base_iterator& it=node_stack.top();
    int old_index=it.index++;
    if(old_index<it.number_children)
    {
        Base* child = it.ptr->get_child(old_index);
        node_stack.push(base_iterator(child));
    }
    else
    {
        node_stack.pop();
    }
}

bool Iterator::is_done()
{
    return node_stack.empty();
}

Base* Iterator::current_node()
{
    return node_stack.top().ptr;
}

int Iterator::current_index()
{
    return node_stack.top().index;
}
