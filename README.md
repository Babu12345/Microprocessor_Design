# Microprocessor_Design
Self-learning microprocessor using Bluespec HDL

Building a microprocessor that can take information and process it in an intelligence manner in order to respond to human beings. Version 1.0

The basics of this project is to be able to collect already inputted data based on the probability of relevance for a particular topic. This should be done by automatically sorting and connecting incoming data streams(via hardware) based on the words and what context they're used in. Then extracting the data based off the least lengthiest/most efficient path required to reach the data, the idea being that this will cross information that seems to be the most relevant.

The end goal of the project is to be able to communicate with a human being by taking Event and Context data and being able to respond to any input using the english language.



## Operation of the Project(Summary):
  1. The first step is to be able to get the data that needs to be analyzed. In the testing process this data will be available
  in a .xml file format that will be broken into sections that include article, title, author, date, departments, tags, abstract,
  text, and imgalttext. This will make it easy to have a simple C program that can decode those files into there respective sections to be fed into the FPGA. In later versions there will be a python files that takes in typed inputs and converts that into a coded message, in hexadecimal, which will be stored in mem.vmh. Afterwords, the input will be stored inside a file called input.txt and this is where the program will get the data to respond to.
  2. The second step is to input that data into an FPGA that will be able to decode the data, break it down, and process it, by factoring in the input.txt file,to output an intelligent document. This step will be the most complex and it involves breaking the data down into nodes
  then using probability analysis to find the most relevant and useful data and be able to use that to create an end product document that will be the response of input.txt.
  3. The structure of how new data is inputted and stored will be the most important part of how information is acquired later on to make the intelligence document. My idea is to sort information based off Events and the different Contexts(causes) that surround it. The notation used will be E_1 <-- C_1 & C_2 & C_N to show that Context 1, Context 2, and Context N have some sort of causality relationship to Event 1.
  4. Now that I know how information should be stored on a basic level, with multiple Contexts being connected to one event, the next important part is how other connections should be established as a whole in order to create more complexity and be utilized to be able to see deeper causality relationships.
  5. There are logically 5 different types of Causality Connections based on the following model. Let's consider two events to find out which one there are: E_1 <-- C_1 & C_2 and E_2 <--C_3 & C_4.
      1. The First one is connections of Contexts of the same Events.
      2. The Second is connections of Events to different Events.
      3. The third is Contexts and Events that aren't directly connected
      4. The fourth(and most often used) is Contexts and Events that are directly connected
      5. The fifth are Contexts of different and non-connected events.
  6. These 5 types of connections and what conditions are needed to in each type will form a basis for how data is stored in the FPGA system/Memory. In addition, as a note, a lot of this data processing and connection making might need to happen during a "sleep mode" due to the high reorganization of data.
  7. The next step, once data is connected enough to be able to draw some simple causality inferences, is to be able to get that data out in a way that will help to create an intelligence response of the system to any new inputs. This step could involve just probing the memory system with keywords or new statements/sentences in order to see the response that it elicits out of the system. This module could search the memory database with connections already presence and stream through the connections of the keywords one by one and see what pops up. Another possible method is to try and analyze the nodes in the opposite way and see what data Contexts "cause" the particular keyword and draw some inference off of that. What is also important to note is that when you do probe the system you are also technically inputting new information into it and storing new data to be connected later on.


## Details about step 5 above(Documentation from personal notes):
1. Explanation of connections of Contexts of the same Events. How does someone know that a particular Context wasn't caused by another one. One possible way is to search for similar Events-Context connection/pairs in memory then extrapolate based on a particular probability model the likelihood of causation. Then you may strength the connection(increase the probability) depending on how many of those Events-Context pairs that you encounter.
Another possible method is that if the "weight", or chance of causation is so large meaning that it most likely caused the event we could possibly remove the other Contexts because the might be irrelevant. Or one could connect the "primary Context" to say the "secondary Context" meaning that the primary Context as a side effect produced the secondary context.
2. Explanations of connections between distinct Events. Before analyzing this lets first analyze the causality between Contexts of non-directly connected Events.
3. Explanation of connections of Contexts of non-directly connected Events. For now there seems to be no logical reason to assume causality between the the contexts of non-directly connected events. However, if two events are similar then there is a possibility of there being a combination of the Events and merging of both of their Contexts into one Event. Then any similar Context will be combined into one with a higher weight.
4. Explanation of connections between Contexts with directly connected Events. This step is the most used out of any of the other probability connections as all it does is take two similar events and combine them. Once combined, some of the contexts might be similar to each other, if this is the case then merge the however number of similar contexts there are into one and increase the weight of this new and bigger context. 
5. Causality between Contexts and Events that aren't directly connected. To analyze this lets assume C_1 -->E_2 and
C_3 --> E_4 also let C_1 = C_3 and E_2 !=E_4. Does this imply that E_2 and E_4 are in some way related? This is an interesting question because this could imply that C_1/C_3 are general enough and that their Context can't be used to explain E_4 and E_2. It could also show that E_4 and E_2 are close enough that they can be explained by the context of C_1/C_3 because they might essentially be the same thing. Perhaps it can even show that E_1 -->E_2 or E_2 -->E_2 justifying #2.
Additionally for the general Contexts this could either mean that C_1 and C_3 are both random events or side effects of a primary Context that is large in each of the respective events. This large primary context "might" be in some way connected in both systems/connection pairs which can be used to combine contexts in different events somewhat justifying #3 but this needs more thought.

## Details about step 7 above:






## Extra Notes:
 - Learn how to return interfaces. Look at the examples provided in past 6.S084 labs. I found this example to be in the lab3 folder and it allows me to be able to create the modules seperately then at the end merge them all together so that I wont have any repeating modules to have to worry about. This is also beneficial because then I also wont have to instantiate them in the seperate files but only once in some top level file.
 - I created a Graphics.py file that processes the data inputted by the Adding_info.py file, or later on by a C or python file that breaks down the data from a collection of articles, and then processed by the BlueSpec processor to create connections. Once completed the graph should display on a Plotly account provided that it has been install on the host computer and the login + APIKEY have been saved onto the configuration file.
 - One important step that I need to do in order to compare multiple nodes in parallel is to have a seperate register file that can compare data with the original register file and then initiate a NodeReq input by putting it into a buffer. The size of this new register file is still kind of uncertain,ie. whether or not it will be the size of the original register file. 

By: Babu-Abel Wanyeki
