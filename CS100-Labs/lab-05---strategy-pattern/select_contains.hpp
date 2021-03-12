#ifndef __SELECT_CONTAINS_HPP__
#define __SELECT_CONTAINS_HPP__

#include <cstring>

class Select_Contains: public Select_Column
{
protected:
	std::string key;
	
public:

	Select_Contains(const Spreadsheet* sheet, const std::string& name, const std::string& key):
	Select_Column(sheet,name),key(key)
	{
	}
	
	bool select(const Spreadsheet* sheet, int row) const
	{
		if(sheet->cell_data(row, column).find(key) !=  std::string::npos)
		{
			return true;
		}
		return false;
	}
	
	bool select(const std::string& s) const
	{
		return true;
	}
};

#endif //__SELECT_CONTAINS_HPP__
