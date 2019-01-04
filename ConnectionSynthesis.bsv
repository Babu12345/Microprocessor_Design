package ConnectionSynthesis;

import CommunicationInterface::*;
import Definitions::*;



//This module will essentially be what connects all of the nodes in order to ease organizational flow
interface ConnSynthesis;
  //This method should return a word to a external FIFO buffer that Communicates with the extraction module
  //method Action connectNode(AddrSize current_addr, AddrSize conn_addr);
  method Action initDirectConnections;
  method Action connectNode(AddrSize addr, AddrSize conn_addr);

endinterface

//(*synthesize*)
module mkConnections#(CommInterface external_comms)(ConnSynthesis);

  Reg#(Bit#(SizeOf#(AddrSize))) letter_counter <-mkReg(0);
  Reg#(StatementSize) word_counter <-mkReg(0);//Need the word counter to be able to see which one is the title or main part of the statement.(The statement type is usually the first word)
  Reg#(State) state <-mkReg(Norm);
  Reg#(Bit#(SizeOf#(AddrSize))) wordTypeAddr <-mkReg(0);
  Reg#(WordSize) letterOffset <-mkReg(0);// Used to go back to the beginning letter address of the wordTypeAddr.

  //rule connectionRequests;
    //Connect to the mkInterface and one by one connect the data
    //Send a data get request of addresses starting @0 from there read through and conmpare the hex of the file to the type definitions of the letters in the definitions file.
  //endrule

  rule directMemConnections(state==DirectInitConn);
    //The first part of this module should be to initiate direct memory connections right off the bat
    //Also the memory addresses are sequential so we can just have a counter to increment through the memory locations
    Letters letterCurrent = external_comms.outputNode0(letter_counter);//Converts the node to a letter type


    if(letterCurrent!=EscapeWord && letterCurrent!=EscapeState && letterCurrent != EscapeMem)begin
      //Connet the data to the next value. Also check if the conn is valid because we dont want to overwrite by accident
      Letters letterNext   = external_comms.outputNode1(letter_counter+1);
      case (letterNext)
        EscapeWord: begin
                      $display("Data output from End of Word: ",fshow(letterCurrent));
                      if(word_counter==0) wordTypeAddr<=letter_counter;
                      else begin
                        NodeReq inputConn=NodeReq{
                              weight:?,current_addr:letter_counter,
                              conn_addr:tagged Valid (wordTypeAddr-zeroExtend(letterOffset))
                              ,current_energy:zeroExtend(initialWeightValue),activation_energy:0,
                              info:pack(letterCurrent)
                          };
                          let dummy <- external_comms.inputNode(inputConn);
                      end
                      word_counter<=word_counter+1;

                    end //If the next one is escape word then the last data word should connect to the beginning of the next word

        EscapeState: begin
                      //state<=Norm;

                      if(word_counter!=0)begin
                        NodeReq inputConn=NodeReq{
                              weight:?,current_addr:letter_counter,
                              conn_addr:tagged Valid (wordTypeAddr-zeroExtend(letterOffset)),
                              current_energy:zeroExtend(initialWeightValue),activation_energy:0,
                              info:pack(letterCurrent)
                        };
                        let dummy <- external_comms.inputNode(inputConn);
                      end
                      word_counter<=0;
                      letterOffset<=0;
                      $display("Data Output from End of sentence: ",fshow(letterCurrent));
                      //$finish(0);
                     end
        default: begin
                  $display("Data Output: ",fshow(letterCurrent));

                  if(word_counter==0)letterOffset<=letterOffset+1;

                  NodeReq inputConn =NodeReq{
                        weight:?,current_addr:letter_counter,
                        conn_addr:tagged Valid (letter_counter+1),current_energy:zeroExtend(initialWeightValue)
                        ,activation_energy:0,
                        info:pack(letterCurrent)
                      };

                  let dummy <- external_comms.inputNode(inputConn);

                 end

      endcase
      letter_counter<=letter_counter+1;
    end else begin

      if(letterCurrent==EscapeMem)begin
  
        state<=Dump;//Dumps the memory contents at the EscapeMem
        word_counter<=0;
        letterOffset<=0;
        $display("Finished Connections");
        //$finish(0);
      end
      letter_counter<=letter_counter+1;
    end


  endrule

  rule dumpMem(state==Dump);
    external_comms.dumpMem;
    state<=Norm;
  endrule




  method Action connectNode(AddrSize current_addr, AddrSize conn_addr) if(state==Norm);//This method controls from the outside what nodes will be connected
    NodeInfo temp = external_comms.outputNodeData(current_addr);
    NodeReq inputConn = NodeReq{weight: ?,current_addr:current_addr,conn_addr:tagged Valid(conn_addr)
                                ,current_energy:temp.current_energy,activation_energy:temp.activation_energy
                                ,info:temp.info

                        };
    let dummy <-external_comms.inputNode(inputConn);
  endmethod

  method Action initDirectConnections if(state==Norm);
    state<=DirectInitConn;
  endmethod



endmodule
 
endpackage: ConnectionSynthesis
