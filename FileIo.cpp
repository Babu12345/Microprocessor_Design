#include <stdio.h>

extern "C" {

unsigned char fileCreate_C(){

FILE *fptr;

fptr=fopen("Output.txt","w");
if(fptr==NULL){

  return 0;
}else{

  fprintf(fptr,"@0\n");//Starts at address 0
  fclose(fptr);
  return 1;

}
}

unsigned char fileAppend_C(unsigned int data){
FILE *fptr;
fptr=fopen("Output.txt","a");

if(fptr==NULL){

  return 0;
}else{
  fprintf(fptr,"%X\n",data);
  fclose(fptr);
  return 1;
}

}

}
