#include "personList.h"
#include <iostream>
#include <string.h>

using std::cout;
using std::endl;

PersonList::PersonList(){
    capacity = 2;
    numPeople = 0;
    theList = new Person*[capacity];
}

PersonList::~PersonList(){
	
	//delete all the elements in theList
	for(int a = 0; a < numPeople; a++) {
		delete theList[a];
	}
	
	//delete the array safely now
    delete[] theList;
}

void PersonList::addPerson(const char* child_name, const char* father_name, const char* mother_name){
    Person *father = nullptr;
    Person *mother = nullptr;
    
    // try to find the three names in the theList
    for(int i = 0; i < numPeople; i++){
		//if child we are adding is in the list already, then stop adding
        if(!strcmp(theList[i]->getName(), child_name)){
            cout << "ERROR: " << child_name << " already has parents!!!";
            return;
		//if we found the father
        } else if(!strcmp(theList[i]->getName(), father_name)) {
            father = theList[i];
		//if we found the mother
        } else if(!strcmp(theList[i]->getName(), mother_name)) {
            mother = theList[i];
        }
    }
   
    if(father == nullptr){
		// father_name is not in the theList so create a new person
		father = new Person(father_name, nullptr, nullptr);
		insertIntoList(father);
    }
    if(mother == nullptr){
		// mother_name is not in the theList so create a new person
		mother = new Person(mother_name, nullptr, nullptr);
		insertIntoList(mother);
    }
	
	//creating new child, adding into the list
    Person *newChild = new Person(child_name, father, mother);
    insertIntoList(newChild);
    father->addChild(newChild);
    mother->addChild(newChild);
}

void PersonList::insertIntoList(Person *newPerson){
    if(numPeople == capacity)
		expand(theList, capacity);
	
	//add in to index numPeople, then increase numPeople
    theList[numPeople] = newPerson;
	++numPeople;
}

//good function
void PersonList::printLineage(const char* person){
    for(int i = 0; i < numPeople; i++) {
        if(!strcmp(theList[i]->getName(), person)){
            theList[i]->printAncestors();
            theList[i]->printDecendents();
            return;
        }
    }
    cout << endl << person << " is not in the list!" << endl;
}
