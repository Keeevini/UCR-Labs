#ifndef __SELECT_OR_HPP__
#define __SELECT_OR_HPP__

class Select_Or : public Select
{
protected:
	Select* pos1;
	Select* pos2;
	
public:

	Select_Or(Select* pos1, Select* pos2)
	{
		this->pos1 = pos1;
		this->pos2 = pos2;
	}

	~Select_Or() {
		delete pos1;
		delete pos2;
	}	
	bool select(const Spreadsheet* sheet, int row) const
	{
		return (this->pos1->select(sheet, row) || this->pos2->select(sheet, row));
	}
};

#endif //__SELECT_OR_HPP__
