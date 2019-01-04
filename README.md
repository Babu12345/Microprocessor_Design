# Microprocessor_Design
Self-learning microprocessor using Bluespec HDL

Building a microprocessor that can take information and process it in an intelligence manner in order to respond to human beings. Version 1.0

The basics of this project is to be able to collect already inputted data based on the probability of relevance for a particular topic. This should be done by automatically sorting and connecting incoming data streams(via hardware) based on the words and what context they're used in. Then extracting the data based off the least lengthiest/most efficient path required to reach the data, the idea being that this will cross information that seems to be the most relevant.

The end goal of the project is to be able to communicate with a human being by taking Event and Context data and being able to respond to any input using the english language.

A more detailed description of the different files will be uploaded later on.

## Extra (Personal) Notes:
 - Learn how to return interfaces. Look at the examples provided in past 6.S084 labs. I found this example to be in the lab3 folder and it allows me to be able to create the modules seperately then at the end merge them all together so that I wont have any repeating modules to have to worry about. This is also beneficial because then I also wont have to instantiate them in the seperate files but only once in some top level file.
 - I created a Graphics.py file that processes the data inputted by the Adding_info.py file, or later on by a C or python file that breaks down the data from a collection of articles, and then processed by the BlueSpec processor to create connections. Once completed the graph should display on a Plotly account provided that it has been install on the host computer and the login + APIKEY have been saved onto the configuration file.
 - One important step that I need to do in order to compare multiple nodes in parallel is to have a seperate register file that can compare data with the original register file and then initiate a NodeReq input by putting it into a buffer. The size of this new register file is still kind of uncertain, ie. whether or not it will be the size of the original register file. 

By: Babuabel Wanyeki
