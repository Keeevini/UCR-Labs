#!/bin/bash

find /usr/src/kernels/ -name "*.h" -exec grep -i "magic" {} \; | wc -1

# Reference used to install devel
# https://www.tecmint.com/install-kernel-headers-in-centos-7/

# Reference used to understand solution
# https://www.linuxquestions.org/questions/programming-9/shell-scripting-3-scripts-835722/
# Comment by GrapefruiTgirl