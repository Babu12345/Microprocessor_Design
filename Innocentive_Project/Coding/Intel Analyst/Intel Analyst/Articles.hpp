//
//  Articles.hpp
//  ABSTRACTION
//
//  Created by Babu Wanyeki on 7/14/17.
//  Copyright © 2017 Babu Wanyeki. All rights reserved.
//

#ifndef Articles_hpp
#define Articles_hpp

#include <stdio.h>

#include <iostream>
#include <fstream>
#include <math.h>
#include <vector>

using namespace std;


string getx(int a, int b,string s);
int findx(vector <string>x,string s, int skip);

string parse(string dir, int num,int &number_of_brackets);
string word(string info, int num);
int word_num(string info);
void text(string file, int type, vector <string>&s, int &number_of_brackets);
void bracket_number(string file,int &number_of_brackets);
string getx2(int a, int b, int size, char *s);
void storage(string loc, int number);
string read(string file, int loc_y, int loc_x);//loc_x goes from 1 to 7; loc_y is >1
void modify(string NEW_DATA,string file, int loc_y, int loc_x);//loc_y and loc_x are used to represent x and y positions
string find_info(string data, int loc_x);
#endif /* Articles_hpp */
