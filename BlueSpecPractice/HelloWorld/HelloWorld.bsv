package HelloWorld;
  import StmtFSM::*;

  String s="Hello new world";

  (*synthesize*)
  module mkAttempt(Empty);

    Reg#(UInt#(3)) ctr <-mkReg(0);
    rule say_hello;
      ctr<=ctr+1;
      $display(ctr);
      if(ctr==4) $finish(0);
    endrule

  endmodule

  interface Counter#(type size_t);
    method Bit#(size_t) read();
    method Action load(Bit#(size_t) newval);
    method Action increment(Bit#(size_t) amount);
    method Action decrement(Bit#(size_t) amount);
  endinterface

  //(*synthesize*) Cant synthesize because it's polymorphic
  module mkCounter(Counter#(size_t));
    Reg#(Bit#(size_t)) value <-mkReg(0);
    //PulseWire increment_called <-mkPulseWire();
    //PulseWire decrement_called <-mkPulseWire();
    RWire#(Bit#(size_t)) increment_value <-mkRWire;
    RWire#(Bit#(size_t)) decrement_value <-mkRWire;

    rule do_increment(isValid(increment_value.wget()) && !isValid(decrement_value.wget()));
      value<=value+fromMaybe(?,increment_value.wget());
    endrule

    rule do_decrement(isValid(decrement_value.wget()) && !isValid(increment_value.wget()));
      value<=value-fromMaybe(?,decrement_value.wget());
    endrule

    method Bit#(size_t) read();
      return value;
    endmethod

    method Action load(Bit#(size_t) newval) if(!isValid(decrement_value.wget()) && !isValid(increment_value.wget()));
      value<=newval;
    endmethod

    method Action increment(Bit#(size_t) amount);
      //increment_called.send();
      increment_value.wset(amount);

    endmethod

    method Action decrement(Bit#(size_t) amount);
      //decrement_called.send();
      decrement_value.wset(amount);
    endmethod

  endmodule

  (*synthesize*)
  module mktbCounter();
    Counter#(8) counter <- mkCounter;
    Reg#(Bit#(16)) state <-mkReg(0);

    rule state0(state==0);
      counter.load(10);
      state<=1;
    endrule

    rule state1(state==1);
      $display("The number is %0d",counter.read());
      state<=2;
    endrule

    rule state2(state==2);
      $display("Finished Simulations");
      $finish(0);
    endrule

  endmodule

  (*synthesize*)
  module mktbCounter2();
    Counter#(8) counter<-mkCounter;
    function test(val);
      action
        if(counter.read()==val)
          $display("The number is %0d",counter.read());
        else
          $display("Test Failed");
      endaction
    endfunction

    mkAutoFSM(seq
      counter.load(42);
      test(42);
      counter.decrement(1);
      counter.increment(1);
      test(42);
      $display("Finished Simulations");
    endseq);
  endmodule


endpackage
