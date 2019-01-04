
#This file will be used to process the node graphics for the Bluespec project
#In essence it will take the Output.txt file and render all of the connection
#into a readable file format


#plotting libraries
import igraph as ig
import plotly.plotly as py
from plotly.graph_objs import Scatter3d,Marker,Layout,Line,Annotations,Figure,Data,XAxis,YAxis,ZAxis,Scene,Margin,Annotation,Font

#This first linesection of the code is to convert the inputted connection information, which is in hexidecimal notation into 
#a format that can be graphed. Otherwise to put it into nodes and links. This entails unpacking the bit data into actual letters
outputFile="/Users/babu_wanyeki/Documents/MIT_GITHUB/Microprocessor_Design/Output.txt"

letters={'A':0,'B':1,'C':2,'D':3,
         'E':4,'F':5,'G':6,'H':7,
         'I':8,'J':9,'K':10,'L':11,
         'M':12,'N':13,'O':14,'P':15,
         'Q':16,'R':17,'S':18,'T':19,'U':20
         ,'V':21,'W':22,'X':23,'Y':24,'Z':25,' ':26
         ,'EscapeState':27,'EscapeMem':28}

unpacked_letters= {y:x for x,y in letters.items()}

#This section should open up the output.txt file and parse it

file=open(outputFile,"r")
data=file.readlines()#reads all of the lines
file.close()

data=list(map(lambda s:s.strip(),data))#removes the /n character

decimal_data=[int(x,16) for x in data if(x[0]!='@')]
#The hex_data variable just displays the data in hex notation
#hex_data=[hex(int(x,16)) for x in data if(x[0]!='@')]
data_new={'links':[],'nodes':[]}
last_valid_bit=0
last_letter_target=0
word=""
dictionary=dict(list(enumerate(decimal_data)))
norm_dictionary={}

#create a new dictionary of a lists composed of needed data to be extracted
for elements in dictionary:
    store_element=dictionary[elements]
    #some values like the escape variables wont have any useful information
    #current energy, activation energy,maybe bit for the connection address, connection address, info
    dictionary[elements]=[(store_element>>27) & 0b1111111,(store_element>>20)&0b1111111,(store_element>>19) & 0b1,(store_element>>5) & int('0x3FFF',16),(store_element) & 0b11111]

#normalize letters to search for words. Meaning combine the letters into words and enable a search for them instead of letters.
i=0
for elements in dictionary:
    norm_dictionary[elements]=i
    if(unpacked_letters[dictionary[elements][4]]==" " or unpacked_letters[dictionary[elements][4]]=="EscapeState"):
        i=i+1
    else:
        pass


i=0
for elements in dictionary:
    if(unpacked_letters[dictionary[elements][4]]==" " or unpacked_letters[dictionary[elements][4]]=="EscapeState"):
        data_new['nodes'].append({'name':word})
        #check to see if the valid connection bit is set
        if(last_valid_bit==0b01):
            data_new['links'].append({'source':i,'target':norm_dictionary[last_letter_target]})
        i=i+1
        word=""
    else:
        last_valid_bit=dictionary[elements][2]
        last_letter_target=dictionary[elements][3]
        word+=unpacked_letters[dictionary[elements][4]]
    
#print the unpacked data values if needed
print(data_new['nodes'])

#Old testing data
"""data={'links':[
  {'source': 1, 'target': 0},
  {'source': 2, 'target': 0},
  {'source': 3, 'target': 0},
  {'source': 3, 'target': 2}], 
   'nodes':[
  {'name': 'Myriel'},#0
  {'name': 'Napoleon'},#1
  {'name': 'Mlle.Baptistine'},#2
  {'name': 'Mme.Magloire'}]}#3"""

N=len(data_new['nodes'])
L=len(data_new['links'])

Edges=[(data_new['links'][k]['source'], data_new['links'][k]['target']) for k in range(L)]

G=ig.Graph(Edges, directed=False)

labels=[]
group=[]
connections=[]
node_connections=[]
i=0

#for empty in range(len(Edges)):
#    node_connections.append("")

for node in data_new['nodes']:
    labels.append(node['name'])
    node_connections.append("<b>"+node['name']+"</b><br>Connections:<br>")
    
for edges in Edges:
    connections.append("<i>{0} -> {1}</i>".format(labels[edges[0]],labels[edges[1]]))#Combine if similar source
    node_connections[edges[0]]=node_connections[edges[0]]+connections[i]+"<br>"
    i=i+1

#for combine in range(len(Edges)):
#    connections[combine]=(labels[combine]+"<br>"+connections[combine])
    
     
layt=G.layout('kk', dim=3)

Xn=[layt[k][0] for k in range(N)]# x-coordinates of nodes
Yn=[layt[k][1] for k in range(N)]# y-coordinates
Zn=[layt[k][2] for k in range(N)]# z-coordinates
Xe=[]
Ye=[]
Ze=[]
for e in Edges:
    Xe+=[layt[e[0]][0],layt[e[1]][0], None]# x-coordinates of edge ends. 2 ends so 2 points
    Ye+=[layt[e[0]][1],layt[e[1]][1], None]
    Ze+=[layt[e[0]][2],layt[e[1]][2], None]
    

trace1=Scatter3d(x=Xe,
               y=Ye,
               z=Ze,
               mode='lines',
               line=Line(color='rgb(125,125,125)', width=2,dash="solid"),
               hoverinfo='none'
               )


trace2=Scatter3d(x=Xn,
               y=Yn,
               z=Zn,
               mode='markers',
               name='information nodes',
               marker=Marker(symbol='circle',
                             size=12,
                             colorscale='Viridis',
                             color='green',
                             line=Line(color='rgb(50,50,50)', width=1.5)
                             ),
               text=node_connections,
               hoverinfo='text'
               )
               

axis=dict(showbackground=False,
          showline=False,
          zeroline=False,
          showgrid=False,
          showticklabels=False,
          title=''
          )

layout = Layout(
         title="Network of information causation nodes (3D visualization)",
         width=1000,
         height=1000,
         showlegend=False,
         scene=Scene(
         xaxis=XAxis(axis),
         yaxis=YAxis(axis),
         zaxis=ZAxis(axis),
        ),
     margin=Margin(
        t=100
    ),
    hovermode='closest',
    annotations=Annotations([
           Annotation(
           showarrow=False,
            text="Data source: Bluespec Processor",
            xref='paper',
            yref='paper',
            x=0,
            y=0.1,
            xanchor='left',
            yanchor='bottom',
            font=Font(
            size=14
            )
            )
        ]),    )

data=Data([trace1,trace2])
fig=Figure(data=data, layout=layout)

py.iplot(fig, filename='3d node visualization v1.0')
print("\nFinished Graphing Plot\nTo see look inside your plotly account.")





