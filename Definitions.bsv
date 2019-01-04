package Definitions;


  Bit#(1) initialWeightValue = 1'b1;//Top level definition of the initial weight value
  typedef Bit#(14) AddrSize;//address size of the memory system
  typedef Bit#(5) LetterSize;//Size of the letter information 0-32 characters or symbols
  typedef Bit#(11) StatementSize;//Most amount of words in a single statement or sentence. 2048
  typedef Bit#(6) WordSize;//Most amount of letters in a word. 64
  typedef SizeOf#(NodeInfo) Storage_Size;
  typedef enum {Input,Output} NodeOp deriving(Eq, Bits, FShow);

  typedef struct {
    Bit#(7) weight;//7 bits to hold the probability of values 0-100
    AddrSize current_addr;
    Maybe#(AddrSize) conn_addr;//Perhaps later have a maybe type to see if the current connection is valid
    Bit#(7) current_energy;//7 bits to see how much until it reaches 100
    Bit#(7) activation_energy;//7 bits used to set how much probability until the node is 'activated'
    LetterSize info;
  } NodeReq deriving(Eq, Bits);

  typedef struct {
    Bit#(7) current_energy;
    Bit#(7) activation_energy;
    Maybe#(AddrSize) conn_addr;//Current address is already known
    LetterSize info;
  } NodeInfo deriving(Eq, Bits);//The maybe bit goes at the end of the conn_addr variable when packed into a Bits

  typedef enum {
    A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,EscapeWord,EscapeState,EscapeMem
  } Letters deriving(Eq, Bits, FShow);
  
  //Note that EscapeWord is similar to a space
  typedef enum {
    Dump, Norm, Count, DirectInitConn, StartProbAnalysis
  } State deriving(Eq, Bits);

  typedef enum {
    DumpComplete, DumpIncomplete
  } CompletionState deriving(Eq, Bits);

endpackage: Definitions

