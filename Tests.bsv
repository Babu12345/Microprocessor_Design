import ProbabilityAnalysis::*;
import CommunicationInterface::*;
import ConnectionSynthesis::*;
import Definitions::*;
import StmtFSM::*;
import MagicMemory::*;
import Vector::*;
//Program test module. Kind of like a test bench file

//Simply states that direct to memory connections are more important than going down the nodes to change the activation energy. This is for convienience in some sense because they will also never occur together. 
(* descending_urgency = "connection_directMemConnections,probTb_movingDown" *)
module mkTest(Empty);


  MagicMemory mem <-mkMagicMemory;
  CommInterface external_comms <-mkInterface(mem);
  ConnSynthesis connection <- mkConnections(external_comms);
  ProbAnalysis probTb <- mkAnalysis(external_comms);
  //Counter#(UInt#(32)) count<-mkCounter(2);

  mkAutoFSM(seq
    connection.initDirectConnections();
    await(mem.dumpCompletion == 1'b1);
    probTb.start();
    delay(190);//Use 190 as a reference
  endseq);


endmodule: mkTest


/*
//Counter module for counting sections of the memory. Note: Not currently needed
USED ONLY AS A BLUESPEC PROGRAMMING REFERENCE 
*/
interface Counter#(type type_a);

  method ActionValue#(type_a) inc1(type_a add1);
  method ActionValue#(type_a) inc2(type_a add1);

endinterface

module mkCounter#(Integer numPorts)(Counter#(type_a))
  provisos(Bits#(type_a,sz), Arith#(type_a));

  Reg#(type_a) reg1[numPorts] <-mkCReg(numPorts,0);

  function ActionValue#(type_a) count(Integer ports , type_a add);
    actionvalue
      type_a ret = 0;
      reg1[ports] <= reg1[ports]+add;
      ret = reg1[ports];
      return ret;
    endactionvalue
  endfunction

  method ActionValue#(type_a) inc1(type_a add1)=count(0,add1);
  method ActionValue#(type_a) inc2(type_a add1)=count(1,add1);

endmodule
