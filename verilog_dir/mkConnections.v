//
// Generated by Bluespec Compiler, version 2016.07.beta1 (build 34806, 2016-07-05)
//
// On Mon May 28 13:23:32 UTC 2018
//
//
// Ports:
// Name                         I/O  size props
// RDY_initDirectConnections      O     1
// RDY_connectNode                O     1
// completionTest                 O     1 const
// RDY_completionTest             O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// connectNode_addr               I    14
// connectNode_conn_addr          I    14
// EN_initDirectConnections       I     1
// EN_connectNode                 I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkConnections(CLK,
		     RST_N,

		     EN_initDirectConnections,
		     RDY_initDirectConnections,

		     connectNode_addr,
		     connectNode_conn_addr,
		     EN_connectNode,
		     RDY_connectNode,

		     completionTest,
		     RDY_completionTest);
  input  CLK;
  input  RST_N;

  // action method initDirectConnections
  input  EN_initDirectConnections;
  output RDY_initDirectConnections;

  // action method connectNode
  input  [13 : 0] connectNode_addr;
  input  [13 : 0] connectNode_conn_addr;
  input  EN_connectNode;
  output RDY_connectNode;

  // value method completionTest
  output completionTest;
  output RDY_completionTest;

  // signals for module outputs
  wire RDY_completionTest,
       RDY_connectNode,
       RDY_initDirectConnections,
       completionTest;

  // register letterOffset
  reg [5 : 0] letterOffset;
  wire [5 : 0] letterOffset$D_IN;
  wire letterOffset$EN;

  // register letter_counter
  reg [13 : 0] letter_counter;
  wire [13 : 0] letter_counter$D_IN;
  wire letter_counter$EN;

  // register state
  reg [1 : 0] state;
  reg [1 : 0] state$D_IN;
  wire state$EN;

  // register wordTypeAddr
  reg [13 : 0] wordTypeAddr;
  wire [13 : 0] wordTypeAddr$D_IN;
  wire wordTypeAddr$EN;

  // register word_counter
  reg [10 : 0] word_counter;
  wire [10 : 0] word_counter$D_IN;
  wire word_counter$EN;

  // ports of submodule external_comms
  wire [54 : 0] external_comms$inputNode_data;
  wire [33 : 0] external_comms$outputNodeData;
  wire [13 : 0] external_comms$outputNode0_current_addr,
		external_comms$outputNode1_current_addr,
		external_comms$outputNodeData_current_addr;
  wire [4 : 0] external_comms$outputNode0, external_comms$outputNode1;
  wire external_comms$EN_dumpMem,
       external_comms$EN_inputNode,
       external_comms$RDY_dumpMem,
       external_comms$RDY_inputNode,
       external_comms$RDY_outputNode0,
       external_comms$RDY_outputNode1,
       external_comms$RDY_outputNodeData,
       external_comms$dumpComplete;

  // rule scheduling signals
  wire WILL_FIRE_RL_directMemConnections, WILL_FIRE_RL_dumpMem;

  // inputs to muxes for submodule ports
  wire [54 : 0] MUX_external_comms$inputNode_1__VAL_1,
		MUX_external_comms$inputNode_1__VAL_2;
  wire MUX_external_comms$inputNode_1__SEL_1, MUX_state$write_1__SEL_1;

  // remaining internal signals
  reg [13 : 0] CASE_external_commsoutputNode1_26_wordTypeAdd_ETC__q2;
  reg CASE_external_commsoutputNode1_26_word_counte_ETC__q1;
  wire [13 : 0] wordTypeAddr_2_MINUS_0_CONCAT_letterOffset_1_3___d54,
		x__h1445;
  wire [10 : 0] x__h689;
  wire [5 : 0] x__h1148;
  wire NOT_external_comms_outputNode0_letter_counter__ETC___d51,
       external_comms_RDY_outputNode1_AND_IF_external_ETC___d20;

  // action method initDirectConnections
  assign RDY_initDirectConnections = state == 2'd1 ;

  // action method connectNode
  assign RDY_connectNode =
	     state == 2'd1 && external_comms$RDY_inputNode &&
	     external_comms$RDY_outputNodeData ;

  // value method completionTest
  assign completionTest = 1'd1 ;
  assign RDY_completionTest = external_comms$dumpComplete ;

  // submodule external_comms
  mkInterface external_comms(.CLK(CLK),
			     .RST_N(RST_N),
			     .inputNode_data(external_comms$inputNode_data),
			     .outputNode0_current_addr(external_comms$outputNode0_current_addr),
			     .outputNode1_current_addr(external_comms$outputNode1_current_addr),
			     .outputNodeData_current_addr(external_comms$outputNodeData_current_addr),
			     .EN_dumpMem(external_comms$EN_dumpMem),
			     .EN_inputNode(external_comms$EN_inputNode),
			     .outputNode0(external_comms$outputNode0),
			     .RDY_outputNode0(external_comms$RDY_outputNode0),
			     .outputNode1(external_comms$outputNode1),
			     .RDY_outputNode1(external_comms$RDY_outputNode1),
			     .outputNodeData(external_comms$outputNodeData),
			     .RDY_outputNodeData(external_comms$RDY_outputNodeData),
			     .RDY_dumpMem(external_comms$RDY_dumpMem),
			     .inputNode(),
			     .RDY_inputNode(external_comms$RDY_inputNode),
			     .dumpComplete(external_comms$dumpComplete),
			     .RDY_dumpComplete());

  // rule RL_directMemConnections
  assign WILL_FIRE_RL_directMemConnections =
	     external_comms$RDY_outputNode0 &&
	     (external_comms$outputNode0 == 5'd26 ||
	      external_comms$outputNode0 == 5'd27 ||
	      external_comms$outputNode0 == 5'd28 ||
	      external_comms_RDY_outputNode1_AND_IF_external_ETC___d20) &&
	     state == 2'd3 ;

  // rule RL_dumpMem
  assign WILL_FIRE_RL_dumpMem = external_comms$RDY_dumpMem && state == 2'd0 ;

  // inputs to muxes for submodule ports
  assign MUX_external_comms$inputNode_1__SEL_1 =
	     WILL_FIRE_RL_directMemConnections &&
	     NOT_external_comms_outputNode0_letter_counter__ETC___d51 ;
  assign MUX_state$write_1__SEL_1 =
	     WILL_FIRE_RL_directMemConnections &&
	     external_comms$outputNode0 == 5'd28 ;
  assign MUX_external_comms$inputNode_1__VAL_1 =
	     { 7'h2A,
	       letter_counter,
	       1'd1,
	       CASE_external_commsoutputNode1_26_wordTypeAdd_ETC__q2,
	       14'd0,
	       external_comms$outputNode0 } ;
  assign MUX_external_comms$inputNode_1__VAL_2 =
	     { 7'h2A,
	       connectNode_addr,
	       1'd1,
	       connectNode_conn_addr,
	       external_comms$outputNodeData[33:20],
	       external_comms$outputNodeData[4:0] } ;

  // register letterOffset
  assign letterOffset$D_IN =
	     (external_comms$outputNode0 != 5'd26 &&
	      external_comms$outputNode0 != 5'd27 &&
	      external_comms$outputNode0 != 5'd28) ?
	       ((external_comms$outputNode1 == 5'd27) ? 6'd0 : x__h1148) :
	       6'd0 ;
  assign letterOffset$EN =
	     WILL_FIRE_RL_directMemConnections &&
	     (external_comms$outputNode0 != 5'd26 &&
	      external_comms$outputNode0 != 5'd27 &&
	      external_comms$outputNode1 != 5'd26 &&
	      (external_comms$outputNode1 == 5'd27 ||
	       word_counter == 11'd0) ||
	      external_comms$outputNode0 == 5'd28) ;

  // register letter_counter
  assign letter_counter$D_IN = x__h1445 ;
  assign letter_counter$EN = WILL_FIRE_RL_directMemConnections ;

  // register state
  always@(MUX_state$write_1__SEL_1 or
	  WILL_FIRE_RL_dumpMem or EN_initDirectConnections)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_state$write_1__SEL_1: state$D_IN = 2'd0;
      WILL_FIRE_RL_dumpMem: state$D_IN = 2'd1;
      EN_initDirectConnections: state$D_IN = 2'd3;
      default: state$D_IN = 2'b10 /* unspecified value */ ;
    endcase
  end
  assign state$EN =
	     WILL_FIRE_RL_directMemConnections &&
	     external_comms$outputNode0 == 5'd28 ||
	     WILL_FIRE_RL_dumpMem ||
	     EN_initDirectConnections ;

  // register wordTypeAddr
  assign wordTypeAddr$D_IN = letter_counter ;
  assign wordTypeAddr$EN =
	     WILL_FIRE_RL_directMemConnections &&
	     external_comms$outputNode0 != 5'd26 &&
	     external_comms$outputNode0 != 5'd27 &&
	     external_comms$outputNode0 != 5'd28 &&
	     external_comms$outputNode1 == 5'd26 &&
	     word_counter == 11'd0 ;

  // register word_counter
  assign word_counter$D_IN =
	     (external_comms$outputNode0 != 5'd26 &&
	      external_comms$outputNode0 != 5'd27 &&
	      external_comms$outputNode0 != 5'd28) ?
	       ((external_comms$outputNode1 == 5'd26) ? x__h689 : 11'd0) :
	       11'd0 ;
  assign word_counter$EN =
	     WILL_FIRE_RL_directMemConnections &&
	     (external_comms$outputNode0 != 5'd26 &&
	      external_comms$outputNode0 != 5'd27 &&
	      (external_comms$outputNode1 == 5'd26 ||
	       external_comms$outputNode1 == 5'd27) ||
	      external_comms$outputNode0 == 5'd28) ;

  // submodule external_comms
  assign external_comms$inputNode_data =
	     MUX_external_comms$inputNode_1__SEL_1 ?
	       MUX_external_comms$inputNode_1__VAL_1 :
	       MUX_external_comms$inputNode_1__VAL_2 ;
  assign external_comms$outputNode0_current_addr = letter_counter ;
  assign external_comms$outputNode1_current_addr = x__h1445 ;
  assign external_comms$outputNodeData_current_addr = connectNode_addr ;
  assign external_comms$EN_dumpMem = WILL_FIRE_RL_dumpMem ;
  assign external_comms$EN_inputNode =
	     WILL_FIRE_RL_directMemConnections &&
	     NOT_external_comms_outputNode0_letter_counter__ETC___d51 ||
	     EN_connectNode ;

  // remaining internal signals
  assign NOT_external_comms_outputNode0_letter_counter__ETC___d51 =
	     external_comms$outputNode0 != 5'd26 &&
	     external_comms$outputNode0 != 5'd27 &&
	     external_comms$outputNode0 != 5'd28 &&
	     (external_comms$outputNode1 == 5'd26 && word_counter != 11'd0 ||
	      external_comms$outputNode1 != 5'd26 &&
	      (word_counter != 11'd0 ||
	       external_comms$outputNode1 != 5'd27)) ;
  assign external_comms_RDY_outputNode1_AND_IF_external_ETC___d20 =
	     external_comms$RDY_outputNode1 &&
	     CASE_external_commsoutputNode1_26_word_counte_ETC__q1 ;
  assign wordTypeAddr_2_MINUS_0_CONCAT_letterOffset_1_3___d54 =
	     wordTypeAddr - { 8'd0, letterOffset } ;
  assign x__h1148 = letterOffset + 6'd1 ;
  assign x__h1445 = letter_counter + 14'd1 ;
  assign x__h689 = word_counter + 11'd1 ;
  always@(external_comms$outputNode1 or
	  external_comms$RDY_inputNode or word_counter)
  begin
    case (external_comms$outputNode1)
      5'd26, 5'd27:
	  CASE_external_commsoutputNode1_26_word_counte_ETC__q1 =
	      word_counter == 11'd0 || external_comms$RDY_inputNode;
      default: CASE_external_commsoutputNode1_26_word_counte_ETC__q1 =
		   external_comms$RDY_inputNode;
    endcase
  end
  always@(external_comms$outputNode1 or
	  x__h1445 or wordTypeAddr_2_MINUS_0_CONCAT_letterOffset_1_3___d54)
  begin
    case (external_comms$outputNode1)
      5'd26, 5'd27:
	  CASE_external_commsoutputNode1_26_wordTypeAdd_ETC__q2 =
	      wordTypeAddr_2_MINUS_0_CONCAT_letterOffset_1_3___d54;
      default: CASE_external_commsoutputNode1_26_wordTypeAdd_ETC__q2 =
		   x__h1445;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        letterOffset <= `BSV_ASSIGNMENT_DELAY 6'd0;
	letter_counter <= `BSV_ASSIGNMENT_DELAY 14'd0;
	state <= `BSV_ASSIGNMENT_DELAY 2'd1;
	wordTypeAddr <= `BSV_ASSIGNMENT_DELAY 14'd0;
	word_counter <= `BSV_ASSIGNMENT_DELAY 11'd0;
      end
    else
      begin
        if (letterOffset$EN)
	  letterOffset <= `BSV_ASSIGNMENT_DELAY letterOffset$D_IN;
	if (letter_counter$EN)
	  letter_counter <= `BSV_ASSIGNMENT_DELAY letter_counter$D_IN;
	if (state$EN) state <= `BSV_ASSIGNMENT_DELAY state$D_IN;
	if (wordTypeAddr$EN)
	  wordTypeAddr <= `BSV_ASSIGNMENT_DELAY wordTypeAddr$D_IN;
	if (word_counter$EN)
	  word_counter <= `BSV_ASSIGNMENT_DELAY word_counter$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    letterOffset = 6'h2A;
    letter_counter = 14'h2AAA;
    state = 2'h2;
    wordTypeAddr = 14'h2AAA;
    word_counter = 11'h2AA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 != 5'd26 &&
	  external_comms$outputNode0 != 5'd27 &&
	  external_comms$outputNode0 != 5'd28 &&
	  external_comms$outputNode1 == 5'd26)
	$write("Data output from End of Word: ");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd0)
	$write("A");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd1)
	$write("B");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd2)
	$write("C");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd3)
	$write("D");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd4)
	$write("E");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd5)
	$write("F");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd6)
	$write("G");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd7)
	$write("H");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd8)
	$write("I");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd9)
	$write("J");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd10)
	$write("K");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd11)
	$write("L");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd12)
	$write("M");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd13)
	$write("N");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd14)
	$write("O");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd15)
	$write("P");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd16)
	$write("Q");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd17)
	$write("R");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd18)
	$write("S");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd19)
	$write("T");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd20)
	$write("U");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd21)
	$write("V");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd22)
	$write("W");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd23)
	$write("X");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd24)
	$write("Y");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 == 5'd25)
	$write("Z");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 != 5'd26 &&
	  external_comms$outputNode0 != 5'd27 &&
	  external_comms$outputNode0 != 5'd28 &&
	  external_comms$outputNode1 == 5'd26 &&
	  external_comms$outputNode0 != 5'd0 &&
	  external_comms$outputNode0 != 5'd1 &&
	  external_comms$outputNode0 != 5'd2 &&
	  external_comms$outputNode0 != 5'd3 &&
	  external_comms$outputNode0 != 5'd4 &&
	  external_comms$outputNode0 != 5'd5 &&
	  external_comms$outputNode0 != 5'd6 &&
	  external_comms$outputNode0 != 5'd7 &&
	  external_comms$outputNode0 != 5'd8 &&
	  external_comms$outputNode0 != 5'd9 &&
	  external_comms$outputNode0 != 5'd10 &&
	  external_comms$outputNode0 != 5'd11 &&
	  external_comms$outputNode0 != 5'd12 &&
	  external_comms$outputNode0 != 5'd13 &&
	  external_comms$outputNode0 != 5'd14 &&
	  external_comms$outputNode0 != 5'd15 &&
	  external_comms$outputNode0 != 5'd16 &&
	  external_comms$outputNode0 != 5'd17 &&
	  external_comms$outputNode0 != 5'd18 &&
	  external_comms$outputNode0 != 5'd19 &&
	  external_comms$outputNode0 != 5'd20 &&
	  external_comms$outputNode0 != 5'd21 &&
	  external_comms$outputNode0 != 5'd22 &&
	  external_comms$outputNode0 != 5'd23 &&
	  external_comms$outputNode0 != 5'd24 &&
	  external_comms$outputNode0 != 5'd25)
	$write("EscapeMem");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 != 5'd26 &&
	  external_comms$outputNode0 != 5'd27 &&
	  external_comms$outputNode0 != 5'd28 &&
	  external_comms$outputNode1 == 5'd26)
	$write("\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 != 5'd26 &&
	  external_comms$outputNode0 != 5'd27 &&
	  external_comms$outputNode0 != 5'd28 &&
	  external_comms$outputNode1 == 5'd27)
	$write("Data Output from End of sentence: ");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd0)
	$write("A");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd1)
	$write("B");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd2)
	$write("C");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd3)
	$write("D");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd4)
	$write("E");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd5)
	$write("F");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd6)
	$write("G");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd7)
	$write("H");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd8)
	$write("I");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd9)
	$write("J");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd10)
	$write("K");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd11)
	$write("L");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd12)
	$write("M");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd13)
	$write("N");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd14)
	$write("O");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd15)
	$write("P");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd16)
	$write("Q");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd17)
	$write("R");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd18)
	$write("S");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd19)
	$write("T");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd20)
	$write("U");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd21)
	$write("V");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd22)
	$write("W");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd23)
	$write("X");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd24)
	$write("Y");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 == 5'd25)
	$write("Z");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 != 5'd26 &&
	  external_comms$outputNode0 != 5'd27 &&
	  external_comms$outputNode0 != 5'd28 &&
	  external_comms$outputNode1 == 5'd27 &&
	  external_comms$outputNode0 != 5'd0 &&
	  external_comms$outputNode0 != 5'd1 &&
	  external_comms$outputNode0 != 5'd2 &&
	  external_comms$outputNode0 != 5'd3 &&
	  external_comms$outputNode0 != 5'd4 &&
	  external_comms$outputNode0 != 5'd5 &&
	  external_comms$outputNode0 != 5'd6 &&
	  external_comms$outputNode0 != 5'd7 &&
	  external_comms$outputNode0 != 5'd8 &&
	  external_comms$outputNode0 != 5'd9 &&
	  external_comms$outputNode0 != 5'd10 &&
	  external_comms$outputNode0 != 5'd11 &&
	  external_comms$outputNode0 != 5'd12 &&
	  external_comms$outputNode0 != 5'd13 &&
	  external_comms$outputNode0 != 5'd14 &&
	  external_comms$outputNode0 != 5'd15 &&
	  external_comms$outputNode0 != 5'd16 &&
	  external_comms$outputNode0 != 5'd17 &&
	  external_comms$outputNode0 != 5'd18 &&
	  external_comms$outputNode0 != 5'd19 &&
	  external_comms$outputNode0 != 5'd20 &&
	  external_comms$outputNode0 != 5'd21 &&
	  external_comms$outputNode0 != 5'd22 &&
	  external_comms$outputNode0 != 5'd23 &&
	  external_comms$outputNode0 != 5'd24 &&
	  external_comms$outputNode0 != 5'd25)
	$write("EscapeMem");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 != 5'd26 &&
	  external_comms$outputNode0 != 5'd27 &&
	  external_comms$outputNode0 != 5'd28 &&
	  external_comms$outputNode1 == 5'd27)
	$write("\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 != 5'd26 &&
	  external_comms$outputNode0 != 5'd27 &&
	  external_comms$outputNode0 != 5'd28 &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27)
	$write("Data Output: ");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd0)
	$write("A");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd1)
	$write("B");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd2)
	$write("C");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd3)
	$write("D");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd4)
	$write("E");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd5)
	$write("F");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd6)
	$write("G");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd7)
	$write("H");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd8)
	$write("I");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd9)
	$write("J");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd10)
	$write("K");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd11)
	$write("L");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd12)
	$write("M");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd13)
	$write("N");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd14)
	$write("O");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd15)
	$write("P");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd16)
	$write("Q");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd17)
	$write("R");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd18)
	$write("S");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd19)
	$write("T");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd20)
	$write("U");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd21)
	$write("V");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd22)
	$write("W");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd23)
	$write("X");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd24)
	$write("Y");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 == 5'd25)
	$write("Z");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 != 5'd26 &&
	  external_comms$outputNode0 != 5'd27 &&
	  external_comms$outputNode0 != 5'd28 &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27 &&
	  external_comms$outputNode0 != 5'd0 &&
	  external_comms$outputNode0 != 5'd1 &&
	  external_comms$outputNode0 != 5'd2 &&
	  external_comms$outputNode0 != 5'd3 &&
	  external_comms$outputNode0 != 5'd4 &&
	  external_comms$outputNode0 != 5'd5 &&
	  external_comms$outputNode0 != 5'd6 &&
	  external_comms$outputNode0 != 5'd7 &&
	  external_comms$outputNode0 != 5'd8 &&
	  external_comms$outputNode0 != 5'd9 &&
	  external_comms$outputNode0 != 5'd10 &&
	  external_comms$outputNode0 != 5'd11 &&
	  external_comms$outputNode0 != 5'd12 &&
	  external_comms$outputNode0 != 5'd13 &&
	  external_comms$outputNode0 != 5'd14 &&
	  external_comms$outputNode0 != 5'd15 &&
	  external_comms$outputNode0 != 5'd16 &&
	  external_comms$outputNode0 != 5'd17 &&
	  external_comms$outputNode0 != 5'd18 &&
	  external_comms$outputNode0 != 5'd19 &&
	  external_comms$outputNode0 != 5'd20 &&
	  external_comms$outputNode0 != 5'd21 &&
	  external_comms$outputNode0 != 5'd22 &&
	  external_comms$outputNode0 != 5'd23 &&
	  external_comms$outputNode0 != 5'd24 &&
	  external_comms$outputNode0 != 5'd25)
	$write("EscapeMem");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 != 5'd26 &&
	  external_comms$outputNode0 != 5'd27 &&
	  external_comms$outputNode0 != 5'd28 &&
	  external_comms$outputNode1 != 5'd26 &&
	  external_comms$outputNode1 != 5'd27)
	$write("\n");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_directMemConnections &&
	  external_comms$outputNode0 == 5'd28)
	$display("Finished Connections");
  end
  // synopsys translate_on
endmodule  // mkConnections

