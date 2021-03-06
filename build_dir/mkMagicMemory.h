/*
 * Generated by Bluespec Compiler, version 2016.07.beta1 (build 34806, 2016-07-05)
 * 
 * On Tue Oct 30 18:02:05 UTC 2018
 * 
 */

/* Generation options: */
#ifndef __mkMagicMemory_h__
#define __mkMagicMemory_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"


/* Class declaration for the mkMagicMemory module */
class MOD_mkMagicMemory : public Module {
 
 /* Clock handles */
 private:
  tClock __clk_handle_0;
 
 /* Clock gate handles */
 public:
  tUInt8 *clk_gate[0];
 
 /* Instantiation parameters */
 public:
 
 /* Module state */
 public:
  MOD_Reg<tUInt8> INST_dumpState;
  MOD_RegFile<tUInt32,tUInt64> INST_mem;
  MOD_Reg<tUInt32> INST_mem_counter;
  MOD_Reg<tUInt8> INST_mem_state;
  MOD_Reg<tUInt32> INST_sizeCounter;
 
 /* Constructor */
 public:
  MOD_mkMagicMemory(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
 
 /* Publicly accessible definitions */
 public:
  tUInt8 DEF_mem_state_EQ_1___d38;
  tUInt8 DEF_mem_state__h348;
 
 /* Local definitions */
 private:
  tUInt32 DEF_x__h483;
 
 /* Rules */
 public:
  void RL_findMemSize();
  void RL_dumpData();
 
 /* Methods */
 public:
  tUInt64 METH_put(tUInt64 ARG_put_memReq);
  tUInt8 METH_RDY_put();
  tUInt64 METH_get0(tUInt32 ARG_get0_addr);
  tUInt8 METH_RDY_get0();
  tUInt64 METH_get1(tUInt32 ARG_get1_addr);
  tUInt8 METH_RDY_get1();
  tUInt64 METH_get2(tUInt32 ARG_get2_addr);
  tUInt8 METH_RDY_get2();
  tUInt64 METH_get3(tUInt32 ARG_get3_addr);
  tUInt8 METH_RDY_get3();
  void METH_nodeDump();
  tUInt8 METH_RDY_nodeDump();
  tUInt8 METH_dumpCompletion();
  tUInt8 METH_RDY_dumpCompletion();
 
 /* Reset routines */
 public:
  void reset_RST_N(tUInt8 ARG_rst_in);
 
 /* Static handles to reset routines */
 public:
 
 /* Pointers to reset fns in parent module for asserting output resets */
 private:
 
 /* Functions for the parent module to register its reset fns */
 public:
 
 /* Functions to set the elaborated clock id */
 public:
  void set_clk_0(char const *s);
 
 /* State dumping routine */
 public:
  void dump_state(unsigned int indent);
 
 /* VCD dumping routines */
 public:
  unsigned int dump_VCD_defs(unsigned int levels);
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkMagicMemory &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkMagicMemory &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkMagicMemory &backing);
};

#endif /* ifndef __mkMagicMemory_h__ */
