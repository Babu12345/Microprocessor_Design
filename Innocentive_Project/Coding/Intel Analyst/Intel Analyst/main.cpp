//
//  main.cpp
//  Intel Analyst
//
//  Created by Babu Wanyeki on 2/8/18.
//  Copyright © 2018 Babu-ABel Wanyeki. All rights reserved.
//

#include <iostream>
#include <vector>
#include <time.h>
#include <fstream>
#include "Articles.hpp"
#include <dirent.h>

int number_in_file(string file){
    file="/Users/babu_wanyeki/Desktop/XPRESS Challenge/Storage/"+file+".txt";
    ifstream doc(file);
    string buffer;
    int x=0;
    for(x=0;getline(doc,buffer);x++){
        if(buffer[0]==' '){
            break;
        }
       
    }
    
    
    doc.clear();
    doc.close();
    return x;
}

int PART1(void){
    
    int break_marker=0;
    string file_location="/Users/babu_wanyeki/Desktop/XPRESS Challenge/Storage/";
    int average=0;
    
    for (int current_file=10;current_file<20;current_file++){
        //storage(to_string(current_file),2);
        
        for(int current_loc=1;current_loc<=number_in_file(to_string(current_file));current_loc++){
            
        for (int search_file=current_file-1;search_file>=9;search_file--){
            
            
            for(int search_loc=1;search_loc<=number_in_file(to_string(search_file));search_loc++){
        
            
            if(read(to_string(search_file),search_loc,7) == "\""+read(to_string(current_file),current_loc,2)+"\""){
                cout<<"connection found"<<endl;
                //cout<<read(to_string(search_file),search_loc,2)<<endl;
                modify(file_location+to_string(search_file)+".txt",to_string(current_file),current_loc,2);
                
                break_marker=1;
                break;
            }
            
            }
            if(break_marker) {break_marker=0;break;}
            
            
            
        }
        
        }
        
    }
    
    
    
    
    return 0;
}
int main(int argc, const char * argv[]) {
    PART1();
    
    //read("11",1,6);
    //modify("self","10",2,2);
    
    //Finds and averages all of the information numbers
    //string average;
    //for(int file=10;file<21;file++){
    //storage(to_string(file),2);
    //for(int x=1;x<=number_in_file(to_string(file));x++){
        
    //average= to_string(1.0/(number_in_file(to_string(file))));
    //modify(average,to_string(file),x,1);
    //}
        
    //read(to_string(file),1,1);
        
    //}
    cout<<"Complete"<<endl;
    
    return 0;
    
    
    
    
}




