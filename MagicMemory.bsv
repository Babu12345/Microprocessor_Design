package MagicMemory;

import RegFile::*;
import Definitions::*;

//This function will need to be modified during verilog simulation and synthesis to instead include a Verilog file.
import "BDPI" function Bit#(1) fileCreate_C();
import "BDPI" function Bit#(1) fileAppend_C(Bit#(34) data);//The size of the data is 7+7+32+5+1=34. Note that this data size will have to be changed if the size of NodeInfo changes.

interface MagicMemory;
  method ActionValue#(NodeInfo) put(NodeReq memReq);
  method NodeInfo get0(AddrSize addr);
  method NodeInfo get1(AddrSize addr);
  method NodeInfo get2(AddrSize addr);
  method NodeInfo get3(AddrSize addr);


  method Action   nodeDump();
  method Bit#(1)  dumpCompletion();
endinterface

(* synthesize *)
module mkMagicMemory(MagicMemory);

    // 64 KB = 3212 words with 34 bits to store in the node info.//Update this to 34 bits to account for the Maybe bit
    RegFile#(AddrSize, NodeInfo) mem <- mkRegFileFullLoad("mem.vmh");
    
    Reg#(State) mem_state<-mkReg(Count);
    Reg#(Bit#(SizeOf#(AddrSize))) mem_counter<-mkReg(0);//Register that goes through the entire file to write.
    Reg#(Bit#(SizeOf#(AddrSize))) sizeCounter <-mkReg(0);
    Reg#(CompletionState) dumpState <- mkReg(DumpIncomplete);


    rule findMemSize(mem_state==Count);
      Bit#(5) input_data=truncate(pack(mem.sub(sizeCounter)));
      if(input_data != truncate(pack(EscapeMem)))sizeCounter<=sizeCounter+1;
      else mem_state<=Norm;
    endrule


    rule dumpData(mem_state==Dump);//In dump state, all of the memory contents are dumped and the simulation exits. This dump function wraps to a C function

        let file_response=fileAppend_C(signExtend(pack(mem.sub(mem_counter))));
        if(file_response==0) $display("Data failed to load!");
        if(mem_counter == sizeCounter)begin//when the counter is done uploading the mem it exits the state.
          $display("Memory Dump Complete!");
          dumpState <= DumpComplete;
          //$finish(0);//This controls whether the dumpData will exit or whether it will return to the normal state.
          mem_state<=Norm;
        end

        mem_counter<=mem_counter+1;
    endrule

    method ActionValue#(NodeInfo) put(NodeReq memReq) if(mem_state==Norm);//Put data into the memory

          NodeInfo information = NodeInfo{
            current_energy:memReq.current_energy, activation_energy: memReq.activation_energy
            ,conn_addr:memReq.conn_addr,info: memReq.info
          };
          //Make sure to factor in the weight into the current_energy

          mem.upd(memReq.current_addr, information);
          NodeInfo ret = mem.sub(memReq.current_addr);

        return ret;
    endmethod

    method NodeInfo get0(AddrSize addr) if(mem_state==Norm);//Get node data from the memory

      NodeInfo ret = mem.sub(addr);
      return ret;

    endmethod

    method NodeInfo get1(AddrSize addr) if(mem_state==Norm);//Get node data from the memory

      NodeInfo ret = mem.sub(addr);
      return ret;

    endmethod

    method  NodeInfo get2(AddrSize addr)if(mem_state==Norm);
      NodeInfo ret =mem.sub(addr);
      return ret;
    endmethod

    method  NodeInfo get3(AddrSize addr)if(mem_state==Norm);
      NodeInfo ret =mem.sub(addr);
      return ret;
    endmethod
 

    method Action nodeDump if(mem_state==Norm);
      let file1=fileCreate_C();

      if(file1==1) begin
        //$display("File created successfully!");
        mem_state<=Dump;
      end else begin
        //$display("File creation failed");
      end

    endmethod

    method Bit#(1) dumpCompletion();
      if(dumpState==DumpComplete) return 1'b1;
      else return 1'b0;
    endmethod: dumpCompletion

endmodule

endpackage: MagicMemory
