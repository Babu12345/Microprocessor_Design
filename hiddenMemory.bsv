
(*synthesize*)
module mkMemory(Memory);
    BRAM_Configure cfg = defaultValue();
    cfg.loadFormat = tagged Hex "mem.vmh";
    BRAM1Port#(Bit#(14), Word) bram <- mkBRAM1Server(cfg);
    method Action req(MemReq memReq);
        if (memReq.op == St) begin
            if (memReq.addr == 'h4000_0000) begin
                // Writing to STDOUT
                $write("%c", memReq.data[7:0]);
            end else if (memReq.addr == 'h4000_0004) begin
                // Write integer to STDOUT
                $write("%0d", memReq.data);
            end else if (memReq.addr == 'h4000_1000) begin
                // Exiting Simulation
                if (memReq.data == 0) begin
                    $display("PASSED");
                end else begin
                    $display("FAILED %0d", memReq.data);
                end
                $finish;
            end
        end
        bram.portA.request.put(BRAMRequest{
                write: memReq.op == St,
                responseOnWrite: False,
                address: truncate(memReq.addr >> 2),
                datain: memReq.data});
    endmethod
    method ActionValue#(Word) resp();
        let x <- bram.portA.response.get();
        return x;
    endmethod
endmodule
