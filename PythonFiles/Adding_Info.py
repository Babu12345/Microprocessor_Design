#This file will be used to convert letters in to a 5 bit value representation
#Each word will be divided by the EscapeWord and each statement will be divided
#by the EscapeState

from sys import exit

file_main="/Users/babu_wanyeki/Documents/MIT_GITHUB/Microprocessor_Design/mem.vmh"
letters={'A':0,'B':1,'C':2,'D':3,
         'E':4,'F':5,'G':6,'H':7,
         'I':8,'J':9,'K':10,'L':11,
         'M':12,'N':13,'O':14,'P':15,
         'Q':16,'R':17,'S':18,'T':19,'U':20,
         'V':21,'W':22,'X':23,'Y':24,'Z':25,' ':26}

Clear_input=input("Do you wish to clear the file?(Y/N): ")
if(Clear_input.upper()=='Y'):
    file=open(file_main,"w")
    file.close()
elif(Clear_input.upper()=='N'):
    pass
else:
    print("Please have a valid argument")
    exit()

Type = input("Type in your statement type: ")
if(len(Type.split())>1):
    print("You can only have one Type")
    exit()

file=open(file_main,"a")

Type=Type.upper()
for letter in Type:
    if(letter in letters):
        #print(format(letters[letter],'02x'))
        file.write(format(letters[letter],'02x')+'\n')
#print(format(26,'02x'))#prints a space for the end of the 'Type' word
file.write(format(26,'02x')+'\n')

Statement=input("Type in your statement: ")
Statement=Statement.upper()
for letter in Statement:
    if(letter in letters):
        #print(format(letters[letter],'02x'))
        file.write(format(letters[letter],'02x')+'\n')

#end of statement letter
#print(format(27,'02x'))
file.write(format(27,'02x')+'\n')

#If you select Yes then data will no longer be able to be read after this.
End=input("Is this the end of the file(Y/N): ")

if(End.upper()=='Y'):
    file.write(format(28,'02x'))

file.close()
