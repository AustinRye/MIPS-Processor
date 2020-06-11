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

    // Register File
    logic        reg_write_en;
    logic [4:0]  reg_write_addr;
    logic [31:0] reg_write_data;
    logic [4:0]  reg_read_addr_1, reg_read_addr_2;
    logic [31:0] reg_read_data_1, reg_read_data_2;

    // ALU
    logic [31:0] alu_in_a, alu_in_b;
    logic [2:0]  alu_op;
    logic [31:0] alu_result;
    logic        zero_flag;


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
        .ADDR_WIDTH     (32),
        .INSTR_WIDTH    (32)
    ) u_instr_mem (
        .addr           (pc),
        .instr          (instr)
    );


    /////////////////////
    //  Register File  //
    /////////////////////

    assign reg_read_addr_1 = instr[25:21];
    assign reg_read_addr_2 = instr[20:16];
    assign reg_write_addr  = instr[15:11];
    assign reg_write_data  = alu_result;

    reg_file #(
        .DATA_WIDTH     (32),
        .ADDR_WIDTH     (5)
    ) u_reg_file (
        .clk            (clk),
        .rst            (rst),
        .write_en       (reg_write_en),
        .write_addr     (reg_write_addr),
        .write_data     (reg_write_data),
        .read_addr_1    (reg_read_addr_1),
        .read_addr_2    (reg_read_addr_2),
        .read_data_1    (reg_read_data_1),
        .read_data_2    (reg_read_data_2)
    );

    ///////////////////
    //      ALU      //
    ///////////////////

    assign alu_in_a = reg_read_data_1;
    assign alu_in_b = reg_read_data_2;

    alu #(
        .DATA_WIDTH     (32)
    ) u_alu (
        .a              (alu_in_a),
        .b              (alu_in_b),
        .op_sel         (alu_op),
        .result         (alu_result),
        .zero           (zero_flag)
    );


endmodule