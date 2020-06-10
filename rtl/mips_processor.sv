////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: mips_processor
// Description:
// MIPS Processor
////////////////////////////////////////////////////////////////////////////////

module mips_processor (
        input  logic clk,
        input  logic rst
    );

    // Program Counter
    logic [31:0] pc, pc_next;

    // Instruction Memory
    logic [31:0] instr;


    /////////////////////
    // Program Counter //
    /////////////////////

    pc #(
        .PC_WIDTH       (32)
    ) u_pc (
        .clk            (clk),
        .rst            (rst),
        .pc_next        (pc_next),
        .pc             (pc)
    );

    // PC next addr (+4addr = +4bytes = +32bits)
    assign pc_next = pc + 4;


    ////////////////////////
    // Instruction Memory //
    ////////////////////////

    instr_mem #(
        .ADDR_SIZE      (1024),
        .INSTR_WIDTH    (32)
    ) u_instr_mem (
        .addr           (pc),
        .instr          (instr)
    );

endmodule