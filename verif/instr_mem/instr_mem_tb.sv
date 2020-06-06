////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: counter_tb
// Description:
// Counter verification testbench
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module instr_mem_tb;

parameter ADDR_SIZE   = 15;
parameter INSTR_WIDTH = 32;

logic [ADDR_SIZE-1:0]   addr;
logic [INSTR_WIDTH-1:0] instr;

instr_mem #(
     .ADDR_SIZE   (ADDR_SIZE)
    ,.INSTR_WIDTH (INSTR_WIDTH)
) instr_mem_dut (
     .addr        (addr)
    ,.instr       (instr)
);

initial begin
    // load memory contents
    $readmemb("instrs.mem", instr_mem_dut.mem);
end

initial begin
    for (addr = 0; addr < ADDR_SIZE; addr = addr + 1)
    begin
        $display("addr=%b   instr=%b", addr, instr);
        #100;
    end

    $display("Test complete");
    $finish;
end

initial begin
    // dump vcd waveform file
    $dumpfile("waveform.vcd");
    $dumpvars(0, instr_mem_tb);
end

endmodule
