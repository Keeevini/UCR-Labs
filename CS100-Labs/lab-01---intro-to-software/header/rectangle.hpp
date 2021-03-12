#ifndef RECTANGLE_HPP
#define RECTANGLE_HPP

class Rectangle {
	private:
		int width;
		int height;
	public:
		void set_width(int w);
		void set_height(int h);
		int area();
};

#endif /* RECTANGLE_HPP */
