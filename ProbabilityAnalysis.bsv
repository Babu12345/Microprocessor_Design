//This file will be the basis for all of the connections(after the initial direct memory connections) of the nodes.
//By analyzing different probabilities as well as causational patterns, the program will be able to form a pattern that allows for easy and accessable extraction.

package ProbabilityAnalysis;

import Definitions::*;
import ConnectionSynthesis::*;
import CommunicationInterface::*;

interface ProbAnalysis;
    method Action start();
endinterface

module mkAnalysis#(CommInterface external_comms)(ProbAnalysis);

    //Start from a node then move into its connections
    //The SearchInterface Interface will most likely only be used in this module so no need to seperately create it.
    //You might need to change the initial value of the nodeSearch.
    //SearchInterface nodeSearch <- mkSequential(0);
    Reg#(AddrSize) nextAddr <- mkReg(0);
    Reg#(State) state <- mkReg(Norm);
    Reg#(Maybe#(AddrSize)) resetAddr <-mkReg(tagged Invalid);
    Reg#(Maybe#(AddrSize)) nextAddrOffset <- mkReg(tagged Invalid);
    Reg#(Letters) previousLetter <- mkReg(A);//This is used to see if the previous letter was an EscapeWord then from that you can modify the activation energy of the connection node. The initial value is just the letter A.


    function Action alterActivation(AddrSize address, NodeInfo out, Bit#(7) incActivation, Bool inc);
        //Read the node
        //Copy the data into a new struct
        //Modify the activation energy by incrementing or decrementing by some amount depending on the inc parameter
        //put the data back
        action
            let addition_or_subtraction = (inc) ? (out.activation_energy + incActivation) : (out.activation_energy - incActivation);
            let dummy <- external_comms.inputNode(NodeReq{
            weight: zeroExtend(initialWeightValue), current_addr: address, conn_addr: out.conn_addr, 
            current_energy: out.current_energy, activation_energy: addition_or_subtraction, info: out.info
            });
        endaction
    endfunction: alterActivation

    rule movingDown(state==StartProbAnalysis);
        NodeInfo nodeBranch = external_comms.outputNodeData(nextAddr);
        Letters nodeNext   = external_comms.outputNode2(nextAddr+1);

        Maybe#(AddrSize) conn_addr = nodeBranch.conn_addr;
        Letters letter = unpack(nodeBranch.info);
        
        $display("The letter is ",fshow(letter));
         
        if(!isValid(conn_addr))begin
            $display("No connection");
            //state <= Norm;
            if (isValid(nextAddrOffset)) begin
                nextAddr <= validValue(nextAddrOffset);
                nextAddrOffset <= tagged Invalid;
            end else if(!isValid(resetAddr) && !isValid(nextAddrOffset)) begin
                nextAddr <= nextAddr+2;
            end else begin
                nextAddr <= validValue(resetAddr);
            end
 
        end else begin
            if(previousLetter==EscapeWord || previousLetter==EscapeState)begin
                //This is where you modify the first letter of the new connection by changing its activation energy.
                $display("Changed Activation Energy");
                alterActivation(nextAddr,nodeBranch,1,True);//Adds one to the activation energy.
            end
            //$display("Connection Detected");
            if(nodeNext==EscapeWord)begin
                $display("New Word Detected");//Set a new starting location after the word
                resetAddr <= tagged Valid (nextAddr+2);

            end
            if(nodeNext==EscapeMem || nodeNext==EscapeState)begin
                $display("New statement detected");//Set the reset address to Invalid when switching to a new statement.
                resetAddr <= tagged Invalid;
                nextAddrOffset <= tagged Valid (nextAddr + 2);
            end
            previousLetter <= nodeNext;
            nextAddr <= validValue(conn_addr); 
        end

    endrule: movingDown

    method Action start() if(state!=StartProbAnalysis);
        state<=StartProbAnalysis;
    endmethod: start



    
endmodule: mkAnalysis

endpackage: ProbabilityAnalysis

