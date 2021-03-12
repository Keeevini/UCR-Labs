CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

SET(CMAKE_CXX_STANDARD 11)

ADD_SUBDIRECTORY(googletest)

ADD_EXECUTABLE(area_calculator
	src/main.cpp
	src/rectangle.cpp
)

ADD_EXECUTABLE(bigger_area_calculator
	src/main_2.cpp
	src/rectangle.cpp
)

ADD_EXECUTABLE(e-echo
	src/main_3.cpp
)

ADD_EXECUTABLE(test
	src/test.cpp
)

TARGET_LINK_LIBRARIES(test gtest)
TARGET_COMPILE_DEFINITIONS(test PRIVATE gtest_disable_pthreads=ON)
