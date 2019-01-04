`include "GCD.bsv"



(*synthesize*)
module mkGCDtb();

  GCD gcd <- mkGCD;

  Reg#(Bit#(2)) state <-mkReg(0);

  rule start(state==0);
    gcd.start(10,15);
    state<=1;
  endrule

  rule answer(state==1);
    $display("The answer is: ",gcd.getResult());
    state<=2;
  endrule

  rule finished(state==2);
    $finish(0);
  endrule


endmodule
