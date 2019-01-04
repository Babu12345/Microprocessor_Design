package CommunicationInterface;

import Definitions::*;
import LFSR::*;
import Real::*;
import MagicMemory::*;

interface SearchInterface;
  method ActionValue#(AddrSize) giveAddr(Bool set,AddrSize setValue);
endinterface

interface CommInterface;

  //Returns the Letter
  method Letters outputNode0(AddrSize current_addr);
  method Letters outputNode1(AddrSize current_addr);
  method Letters outputNode2(AddrSize current_addr);

  //Returns the structure NodeInfo
  method NodeInfo outputNodeData(AddrSize current_addr);
  method Action  dumpMem();
  method ActionValue#(LetterSize) inputNode(NodeReq data);

endinterface

module mkInterface#(MagicMemory mem)(CommInterface);
  
  method Letters outputNode0(AddrSize current_addr);
    NodeInfo outputInfo= mem.get0(current_addr);
    LetterSize ret =outputInfo.info;
    Letters out = unpack(ret);
    return out;
  endmethod

  method Letters outputNode1(AddrSize current_addr);
    NodeInfo outputInfo= mem.get1(current_addr);
    LetterSize ret =outputInfo.info;
    Letters out = unpack(ret);
    return out;
  endmethod

  method Letters outputNode2(AddrSize current_addr);
    NodeInfo outputInfo= mem.get2(current_addr);
    LetterSize ret =outputInfo.info;
    Letters out = unpack(ret);
    return out;
  endmethod

  method NodeInfo outputNodeData(AddrSize current_addr);
    NodeInfo outputInfo = mem.get3(current_addr);
    return outputInfo;
  endmethod

  method ActionValue#(LetterSize) inputNode(NodeReq data);

    NodeInfo info <- mem.put(data);
    LetterSize ret =info.info;//Returns the information in bits
    return ret;

  endmethod

  method Action dumpMem() = mem.nodeDump;


endmodule

//This module returns a node from a random address
module mkRandom(SearchInterface);
  LFSR#(Bit#(32)) lfsr <- mkFeedLFSR('h11111111);//Initialize the randomization module

  //Perhaps the set and setValue parameters could be used to set impossible values that cannot be attained by randomization
  method ActionValue#(AddrSize) giveAddr(Bool set, AddrSize setValue);
    lfsr.next;
    return lfsr.value[valueOf(SizeOf#(AddrSize))-1:0] ;
    //Returns the address ie. Counter value and updates the counter for the next time. May need to reduce this size for testing because a lot of these nodes are empty
  endmethod: giveAddr

endmodule: mkRandom

//Returns a node starting from address 0
module mkSequential#(AddrSize initAddr)(SearchInterface);
  Reg#(AddrSize) counter <-mkReg(initAddr+1);//The plus one is because the initial value is already accounted first. Without the need of the module.
  
  method ActionValue#(AddrSize) giveAddr(Bool set, AddrSize setValue);

    if(set==False)begin
      if(counter==fromInteger((2 ** (valueOf(SizeOf#(AddrSize))))- 1)) begin
        counter<=0;
        return counter;//Returns the address ie. Counter value and updates the counter for the next time
      end else begin 
        counter<=counter+1;
        return counter;
      end
    end else begin
      counter <=setValue;
      return setValue;//This is so the method returns the real time value
    end

    
  endmethod: giveAddr

endmodule: mkSequential

endpackage: CommunicationInterface

