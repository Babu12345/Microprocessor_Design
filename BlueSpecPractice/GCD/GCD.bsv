

typedef Bit#(32) Word;
interface GCD;
  method Action start(Word a, Word b);
  method ActionValue#(Word) getResult;
  method Bool busy;
  method Bool ready;
endinterface

module mkGCD(GCD);

  Reg#(Word) x<-mkReg(0);
  Reg#(Word) y <-mkReg(0);
  Reg#(Bool) busy_flag <-mkReg(False);

  rule gcd(x!=0 && busy_flag==True);
    if(x>=y)begin
      x<=x-y;
    end else if(x!=0) begin
      x<=y;
      y<=x;
    end

  endrule

  method Action start(Word a, Word b) if(busy_flag==False);
    x<=a;
    y<=b;
    busy_flag<=True;
  endmethod

  method ActionValue#(Word) getResult if(x==0 &&busy_flag==True);
    busy_flag<=False;
    return y;
  endmethod

  method Bool busy();
    return busy_flag;
  endmethod

  method Bool ready();
    return (busy_flag&&(x==0));
  endmethod

endmodule
