#ifndef __SELECT_NOT_HPP__
#define __SELECT_NOT_HPP__

class Select_Not : public Select
{
protected:
	Select* base;
public:
	Select_Not(Select* base)
	{
		this->base = base;
	}

	~Select_Not() {
		delete base;
	}	
	bool select(const Spreadsheet* sheet, int row) const
	{
		return !(this->base->select(sheet, row));
	}
};

#endif //__SELECT_NOT_HPP__
