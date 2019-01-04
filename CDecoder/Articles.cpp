//
//  Articles.cpp
//  ABSTRACTION
//
//  Created by Babu Wanyeki on 7/14/17.
//  Copyright © 2017 Babu Wanyeki. All rights reserved.
//

#include "Articles.hpp"


//This file is used to parse and split apart data from any other the intelligence articles

string getx(int a, int b,string s){

    string s3;

    for(int x=a;x<b;x++){

        s3=s3+s[x];
          
    }

    return s3;
}

string getx2(int a, int b, int size, char *s){

    string s3;
    int init=0;
    for(int x=a;x<b;x++){

        s3.push_back(s[x]);
        init++;
    }
    return s3;
    //delete [] s3;

}
int findx(vector <string>x,string s, int skip){
    int y=0;

    for(y=0;y<x.size();y++){



        if(x[y]==s){
            if(skip>0){
                skip--;

            }else{
                break;
            }
        }


    }

    return y;
}

string parse(string dir, int num, int &number_of_brackets){
    //This example program is meant to extract the type data from the intelligence .xml files
    int a=0,b=0,c=0,d=0,e=0,f=0,g=0, h=0;
    string info;
    string info2;
    vector <string>v;
    vector <int>v1;//This is the beginning bracket
    vector <int>v2;//This is the end bracket
    vector <string>v3;
    vector <int>v4;
    vector <string>v5;
    vector <string>info1;

    ifstream f0(dir);

    while(getline(f0,dir)){
        v.push_back(dir);
        //cout<<dir<<endl;
    }
    for(a=0;a<v.size();a++){

        for(b=0;b<v[a].size();b++){
            if(v[a][b]=='<'){
                v1.push_back(b);
                h++;
                c=1;
            }
            if(v[a][b]=='>'){

                v2.push_back(b);
                d=1;
                h++;
            }

            if((c==1)&&(d==1)){
                v4.push_back(a);
                v3.push_back(getx(v1[v1.size()-1]+1,v2[v2.size()-1],v[a]));
                ;

                c=0;
                d=0;
            }

        }

    }
    //v4[y] is the line of the bracket word
    //v2[y] is the end bracket postition
    //v[y] is the entire line
    //Vector v is the entire lines
    //v3 is the bracket word vector



    number_of_brackets =(int)(v3.size()/2) ;
    for(int y=0;y<v3.size();y++){
        if(v3[y][0]!='/'){
            v5.push_back(v3[y]);
        }
    }
    for(int y=0;y<v3.size();y++){

        if(v3[y][0]!='/'){


            //This 'if' statement controlls whether the program can parse similar bracketted
            //words if they are in different sentences or just consecutive
            if(y!=0) {

                if(v3[y]==v3[y-2]){

                    g++;
                }else{
                    g=0;
                }

            }

            for(c=v4[y];c<v.size();c++){
                //c is the line position
                //d is the character position
                //cout<<v[c]<<endl;
                if(c==v4[y]){
                    e=v2[y]+1;
                }
                else{
                    e=0;
                }
                for(d=e;d<v[c].size();d++){
                    //cout<<v[c][d];
                    info=info+v[c][d];
                    if((c==v4[findx(v3,"/"+v3[y],g)])&&(d==v1[findx(v3,"/"+v3[y],g)])){

                        info.pop_back();
                        f=1;
                        break;
                    }

                }
                if(f==1){
                    info1.push_back(info);
                    info.clear();
                    c=0;
                    d=0;
                    e=0;
                    f=0;
                    break;
                }

            }


        }


    }


    f0.close();

    info2=info1[num];
    //This part is optional and is only for viewing
    //info2=v5[num]+": "+info2;

    return info2;

}

//This 'word_num' function outputs the number of words in the info string

int word_num(string info){
    int c=0,d=0,x=0;

    for(x=0;x<info.size();x++){

        if(info[x]==' '){

            if(c==1){

                c=0;
                d++;
            }

        }

        if(c==0){

            if(info[x]!=' '){

                if(x==0){
                    d++;
                }
                c=1;

            }
        }

    }
    if(info[0]==' '){
        d++;
    }
    if(info[x-1]==' '){
        d--;
    }
    return d;


}
string word(string info, int num){
    //The info input should be the return of the parse function

    string word1;

    int c=0,d=0;

    for(int x=0;x<info.size();x++){

        if(info[x]==' '){

            if(c==1){

                c=0;

                if(d!=num){

                    word1.clear();
                }else{
                    break;
                }
                d++;
            }



        }

        if(c==0){
            if(info[x]!=' '){
                c=1;
                word1=word1+info[x];

            }
        }else{
            if(info[x-1]!=' '){
                word1=word1+info[x];

            }

        }


    }

    return word1;
}



void text(string file, int type, vector <string>&s, int &number_of_brackets){


    string x=parse(file,type,number_of_brackets);
    int y=word_num(x);
    s.clear();
    for(int x1=0;x1<y;x1++){


        s.push_back(word(x,x1));

    }


}
void bracket_number(string file,int &number_of_brackets){
    parse(file,0,number_of_brackets);
}


void modify(string NEW_DATA, string file, int loc_y, int loc_x){

    string file_store;
    vector<int> comma_num;//Contains the location of all the commas which seprate data
    vector<string> line_storage;;
    string input="";
    string data="";//The whole line that we're looking at
    string buffer_front;
    string buffer_back;
    string gen_buffer;
    string current_data;
    int ERROR=0;
    int offset=0;
    int length;
    int stopper=0;
    file="/Users/babu_wanyeki/Desktop/XPRESS Challenge/Storage/"+file+".txt";

    fstream doc(file, ios::out| ios::in);

    doc.seekg(0, doc.end);
    length=(int)doc.tellg();
    doc.seekg (0, doc.beg);
    //Try to turn this into a string!!
    string data_holder;
    while(getline(doc, gen_buffer)){
        if(stopper>=loc_y){
            data_holder=data_holder+gen_buffer+"\n";
        }
        stopper++;
    }

    //cout<<length<<endl;
    //cout<<data_holder<<endl;

    doc.clear();
    doc.seekg (0);

    for(int pos=0;pos<loc_y;pos++){

        if(pos>0){
            offset=offset+(int)data.length();
            offset++;
        }
        if(!getline(doc,data)){
            ERROR=1;
            break;
        }


    }



    if(ERROR==0 and loc_y>0){

        for(int x=0;x<data.size();x++){
            if(data[x]==','){
                comma_num.push_back(x);
                if(comma_num.size()==6){
                    break;
                }
            }
        }

        current_data=find_info(data, loc_x);//current word size in the file.

        switch (loc_x) {
            case 1:

                doc.seekg(2+offset);
                buffer_back=getx(0,2,data);
                buffer_front=getx(2+(int)current_data.size(),(int)data.size(),data);

                break;
            case 2:

                doc.seekg(comma_num[loc_x-2]+offset+1);
                buffer_back=getx(0,comma_num[loc_x-2]+1,data);
                buffer_front=getx(comma_num[loc_x-2]+1+(int)current_data.size(),(int)data.size(),data);

                break;
            case 3:
                doc.seekg(comma_num[loc_x-2]+offset+1);
                buffer_back=getx(0,comma_num[loc_x-2]+1,data);
                buffer_front=getx(comma_num[loc_x-2]+1+(int)current_data.size(),(int)data.size(),data);

                break;
            case 4:
                doc.seekg(comma_num[loc_x-2]+offset+1);
                buffer_back=getx(0,comma_num[loc_x-2]+1,data);
                buffer_front=getx(comma_num[loc_x-2]+1+(int)current_data.size(),(int)data.size(),data);

                break;
            case 5:
                doc.seekg(comma_num[loc_x-2]+offset+1);
                buffer_back=getx(0,comma_num[loc_x-2]+1,data);
                buffer_front=getx(comma_num[loc_x-2]+1+(int)current_data.size(),(int)data.size(),data);

                break;
            case 6:
                doc.seekg(comma_num[loc_x-2]+offset+1);
                buffer_back=getx(0,comma_num[loc_x-2]+1,data);
                buffer_front=getx(comma_num[loc_x-2]+1+(int)current_data.size(),(int)data.size(),data);

                break;
            case 7:
                doc.seekg(comma_num[loc_x-2]+offset+1);
                buffer_back=getx(0,comma_num[loc_x-2]+1,data);
                buffer_front=getx(comma_num[loc_x-2]+1+(int)current_data.size(),(int)data.size(),data);

                break;

        }

        for(int x=0;x<length;x++){
            input.push_back(' ');
        }
        doc.write(input.c_str(),length);
        doc.seekg(offset);
        doc.write(buffer_back.c_str(),buffer_back.size());
        doc.write(NEW_DATA.c_str(),NEW_DATA.size());
        doc.write(buffer_front.c_str(),buffer_front.size());
        doc<<endl;
        doc<<data_holder;

    }
    else{
        cout<<"ERROR: Incorrect loc_y call!!"<<endl;
    }
    doc.close();


}







string find_info(string data, int loc_x){
    vector<int> comma_num;//Contains the location of all the commas which seprate data
    for(int x=0;x<data.size();x++){
        if(data[x]==','){
            comma_num.push_back(x);
            if(comma_num.size()==6){
                break;
            }
        }
    }

    switch (loc_x) {
        case 1:
            return getx(2,comma_num[0],data);
        case 2:
            return getx(comma_num[0]+1,comma_num[1],data);
        case 3:
            return getx(comma_num[1]+1,comma_num[2],data);
        case 4:
            return getx(comma_num[2]+1,comma_num[3],data);
        case 5:
            return getx(comma_num[3]+1,comma_num[4],data);
        case 6:
            return getx(comma_num[4]+1,comma_num[5],data);
        case 7:
            return getx(comma_num[5]+1,(int)(data.size()-2),data);
        default:
            return "ERROR: Incorrect loc_x call!!";
    }

}

//Returns a -1 if the input positions are invalid
string read(string file, int loc_y, int loc_x){

    int ERROR =0;
    string line;
    file="/Users/babu_wanyeki/Desktop/XPRESS Challenge/Storage/"+file+".txt";
    ifstream doc(file);
    if(doc.good()){

        for(int x=0;x<loc_y;x++){
            if(!getline(doc,line)){

                ERROR=1;
                break;
            }
        }

        if((ERROR==0) and (loc_y>0)){
            doc.close();

            //cout<<find_info(line, loc_x)<<endl;
            return find_info(line, loc_x);

        }
        else{
            cout<<"ERROR: Incorrect loc_y call!!"<<endl;
            return "-1";
        }


    }
    else{
        doc.close();
        cout<<"ERROR: File does not exist!!!"<<endl;
        return "-1";
    }

}
bool file_exists(string file){
    ifstream file_check(file);
    return (bool)file_check;

}
void storage(string loc, int number){
    //If the number is -1 that means to store all of the data
    time_t rawtime;
    time(&rawtime);
    ofstream file;
    int number_of_brackets;
    string dir="/Users/babu_wanyeki/Desktop/XPRESS Challenge/articles/";
    dir=dir+loc+".xml";
    loc="/Users/babu_wanyeki/Desktop/XPRESS Challenge/Storage/"+loc+".txt";
    file.open(loc);
    vector <string>article;
    vector <string>section_names={"article","type","title","author","date","departments","tags","tag","tag","abstract","text",
        "imgalttext"};


    bracket_number(dir, number_of_brackets);//Tells the reader the number of sections in the file "dir"!!
    if(number>number_of_brackets){
        cout<<"ERROR Bound not that many brackets. No information stored"<<endl;
    }
    else if(number<0){


        for(int num=1;num<number_of_brackets-3;num++){
            text(dir,num,article,number_of_brackets);
            //Every word is broken down
            for(int y=0;y<article.size();y++){
                file<<"</"<<"0"<<","<<"0"<<","<<"0"<<","<<"0"<<","<<"0"<<","<<(localtime(&rawtime)->tm_year)+1900<<",";

                if(y!=article.size()-1)
                    file<<"\""<<article[y]<<"\""<<" ";
                else{
                    file<<"\""<<article[y]<<"\"";
                }
                file<<"/>";

                //if((y!=(article.size()-1)) or (num!=(number_of_brackets-1))){
                file<<endl;

                //}

            }

        }

    }
    else{
        text(dir,number,article,number_of_brackets);
        //cout<<number_of_brackets<<endl;
        //cout<<section_names.size()<<endl;

        //Note that this if statement will need to change in the size is not due to the tags!!
        //Note that I'll remove one of the brackets because now the file number will act as a type of time stamp.
        if(number_of_brackets<section_names.size())
        section_names.erase(section_names.begin()+7);

        for(int y=0;y<article.size();y++){

            //file<<"</"<<"0"<<","<<"0"<<","<<"0"<<","<<"0"<<","<<"0"<<","<<(localtime(&rawtime)->tm_year)+1900<<",";
            //The self keyword is to know that the information initially in the file connects to the file itself
            //Creates a new connection file. Like "title" or "abstract."
            //The "title" file will be refered to as file #9
            if(!file_exists("/Users/babu_wanyeki/Desktop/XPRESS Challenge/Storage/9.txt")){
                //cout<<"File Not Found"<<endl;
                //ofstream new_file("/Users/babu_wanyeki/Desktop/XPRESS Challenge/Storage/"+section_names[number]+".txt");
                ofstream new_file("/Users/babu_wanyeki/Desktop/XPRESS Challenge/Storage/9.txt");
                new_file<<"</"<<"0"<<","<<"0"<<","<<"0"<<","<<"0"<<","<<"0"<<","<<(localtime(&rawtime)->tm_year)+1900<<",";
                new_file<<"\""<<section_names[number]<<"\""<<"/>"<<endl;
                new_file.close();
            }
            file<<"</"<<"0"<<","<<section_names[number]<<","<<"0"<<","<<"0"<<","<<"0"<<","<<(localtime(&rawtime)->tm_year)+1900<<",";
            if(y!=article.size()-1)
                file<<"\""<<article[y]<<"\""<<" ";
            else{
                file<<"\""<<article[y]<<"\"";
            }
            file<<"/>";

            file<<endl;



        }


    }

    file.close();

}
