#include "person.h"
#include <iostream>
#include <string>
#include <string.h>

using std::cout;
using std::endl;
using std::string;

Person::Person(const char *name_, Person* father_, Person* mother_){
	//Need to make name bigger for terminating char
    this->name = new char[strlen(name_)+1];
    strcpy(name, name_);
    this->father = father_;
    this->mother = mother_;
    capacity = 1;
    numChildren = 0;
    children = new Person*[capacity];
}

Person::~Person(){
	
	//delete the children
    delete[] children;
	
	//delete the name
	delete[] name;
}

void Person::addChild(Person *newChild){
	
	//manually fixed the expand func implementation
    if(numChildren == capacity)
		expand(children, capacity);

	//add in to index numChildren, then increase numChildren
    children[numChildren] = newChild;
	++numChildren;
}

void Person::printAncestors(){
    cout << endl << "Ancestors of " << name << endl;
    printLineage('u', 0);
}

void Person::printDecendents(){
    cout << endl << "Decendents of " << name << endl;
    printLineage('d', 0);
}

void Person::printLineage(char dir, int level){
    char *temp = compute_relation(level);

	//if printing descendents
    if(dir == 'd'){
        for(int i = 0; i < numChildren; i++){
            cout << temp << "child: " << children[i]->getName() << endl;
            children[i]->printLineage(dir, level + 1);
        }
    }
	
	//if printing ancestors
	if (dir == 'u') {
        if(mother != nullptr){
            cout << temp << "mother: " << mother->getName() << endl;
            mother->printLineage(dir, level + 1);
        }
        if(father != nullptr){
            cout << temp << "father: " << father->getName() << endl;
            father->printLineage(dir, level + 1);
        }
    }
	delete[] temp;
}

/* helper function to compute the lineage
* if level = 0 then returns the empty string
* if level >= 1 then returns ("great ")^(level - 1) + "grand "
*/

//There seems to be no need for any new allocation since we are returning
//Changed to using string builder, then converting to char*
char* Person::compute_relation(int level){
	if(level == 0) return strcpy(new char[1], "");

    char *temp = strcpy(new char[strlen("grand ") + 1], "grand ");;
    
    for(int i = 2; i <= level; i++){
        char *temp2 = new char[strlen("great ") + strlen(temp) + 1];
        strcat(strcpy(temp2, "great "), temp);
	delete[] temp;
        temp = temp2;
    }
    return temp;
}

/* non-member function which doubles the size of t
 * NOTE: t's type will be a pointer to an array of pointers
 */
 
//Changed it so that whenever you call this function, you pass by reference
void expand(Person** &t, int &capacity){

	//make new array to store double capacity
	Person **array = new Person*[capacity*2];
	
	//fill in new array elements with the correct pointers
	for(int a = 0; a < capacity; a++) {
		if(t[a] != nullptr) {
			array[a] = t[a];
		}
	}
	
	//delete the array t had
	delete[] t;
	
	//double capacity and set t to new array
	capacity = capacity*2;
	t = array;
}
