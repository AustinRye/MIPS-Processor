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

    // PC
    logic [31:0] pc;
    logic signed [31:0] pc_next;
    logic signed [31:0] pc_4, pc_bne, pc_4_bne;

    // Control unit
    logic        reg_dst;
    logic        jump;
    logic        branch;
    logic        mem_read;
    logic        mem_to_reg;
    logic [1:0]  alu_op;
    logic        mem_write;
    logic        alu_src;
    logic        reg_write;
    logic        sign_zero;

    // Register file
    logic [4:0]  reg_write_addr;
    logic [31:0] alu_result;
    logic [31:0] reg_read_data_1, reg_read_data_2;

    // Immediate extending
    logic [31:0] ext_im;

    // JR control
    logic        jr_control;

    // ALU control
    logic        alu_control;

    // ALU
    logic        zero_flag;

    ////////
    // PC //
    ////////
    pc #(
        .PC_WIDTH   (32)
    ) u_pc (
        .clk        (clk),
        .rst        (rst),
        .pc_next    (pc_next),
        .pc         (pc)
    );

    assign pc_4 = pc + 32'h00000004;
    assign instr_shift = instr << 2;
    assign ext_im_shift = ext_im << 2;
    assign pc_bne = pc_4 + ext_im_shift;
    assign bne_control = branch & ~zero_flag;
    assign pc_4_bne = bne_control ? pc_bne : pc_4;
    assign pc_j = {pc_4[31:28], instr_shift[27:0]};
    assign pc_4_bne_j = jump ? pc_j : pc_4_bne;
    assign pc_next = jr_control ? reg_read_data_1 : pc_4_bne_j;

    ////////////////////////
    // Instruction memory //
    ////////////////////////
    instr_mem #(
        .ADDR_SIZE  (32),
        .INSTR_WIDTH(32)
    ) u_instr_mem (
        .addr       (pc),
        .instr      (instr)
    );

    //////////////////
    // Control unit //
    //////////////////
    control u_control (
        .opcode     (instr[31:26]),
        .reg_dst    (reg_dst),
        .jump       (jump),
        .branch     (branch),
        .mem_read   (mem_read),
        .mem_to_reg (mem_to_reg),
        .alu_op     (alu_op),
        .mem_write  (mem_write),
        .alu_src    (alu_src),
        .reg_write  (reg_write),
        .sign_zero  (sign_zero)
    );

    ///////////////////
    // Register file //
    ///////////////////
    assign reg_write_addr = reg_dst ? instr[15:11] : instr[20:16];
    assign reg_write_data = mem_to_reg ? mem_read_data : alu_result;

    reg_file #(
        .DATA_WIDTH (32),
        .REG_WIDTH  (5)
    ) u_reg_file (
        .clk        (clk),
        .rst        (rst),
        .write_en   (reg_write),
        .write_addr (reg_write_addr),
        .write_data (reg_write_data),
        .read_addr_1(instr[25:21]),
        .read_addr_2(instr[20:16]),
        .read_data_1(reg_read_data_1),
        .read_data_2(reg_read_data_2)
    );

    /////////////////////////
    // Immediate extending //
    /////////////////////////
    assign sign_ext_im = {{16{instr[15]}}, instr[15:0]};
    assign zero_ext_im = {{16{1'b0}}, instr[15:0]};
    
    assign ext_im = sign_zero ? zero_ext_im : sign_ext_im;

    ////////////////
    // JR control //
    ////////////////
    jr_control u_jr_control (
        .alu_op     (alu_op),
        .fn         (instr[5:0]),
        .jr_control (jr_control)
    );

    /////////////////
    // ALU control //
    /////////////////
    alu_control u_alu_control (
        .alu_op     (alu_op),
        .fn         (instr[5:0]),
        .alu_control(alu_control)
    );

    /////////
    // ALU //
    /////////
    assign alu_in1 = reg_read_data_1;
    assign alu_in2 = alu_src ? extend_im : reg_read_data_2;

    alu #(
        .DATA_WIDTH(32)
    ) alu_u (
        .a          (alu_in1),
        .b          (alu_in2),
        .op_sel     (alu_control),
        .result     (alu_result),
        .zero       (zero_flag)
    );

    /////////////////
    // Data memory //
    /////////////////
    data_mem #(
        .ADDR_SIZE  (1024),
        .DATA_WIDTH (32)
    ) u_data_mem (
        .clk        (clk),
        .read_en    (mem_read),
        .write_en   (mem_write),
        .addr       (alu_result),
        .write_data (reg_read_data_2),
        .read_data  (mem_read_data)
    );

endmodule