

typedef enum {
State1,State2,State3,State4

} State deriving(Eq, Bits, FShow);
interface CounterTest;

  method Action setValue (Bit#(10) val);
  method Action increment(Bit#(10) inc);
  method Bit#(10)  readVal();

endinterface

(*synthesize*)
module mkCounterTest(CounterTest);

  Reg#(Bit#(10)) counter <- mkReg(0);

  method Action setValue(Bit#(10) val);
    counter<=val;
  endmethod

  method Action increment(Bit#(10) inc);
    counter<=counter+zeroExtend(inc);
  endmethod

  method Bit#(10) readVal();
    return counter;
  endmethod


endmodule

(*synthesize*)
module mktbCounterTest();
  CounterTest counter <-mkCounterTest;
  Reg#(State) state <-mkReg(State1);
  rule state1(state==State1);
    counter.setValue(20);
    state<=State2;
  endrule

  rule state2(state==State2);
    $display("The value of the Counter is: ",counter.readVal);
    counter.increment(10);
    state<=State3;
  endrule

  rule state3(state==State3);
    $display("The value of the Counter is: ",counter.readVal);
    state<=State4;
  endrule

  rule state4(state==State4);
    counter.increment(10);
  endrule





endmodule
