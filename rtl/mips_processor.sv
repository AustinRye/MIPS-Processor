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

    // Instruction Format
    logic [5:0]  op, func;
    logic [4:0]  rs, rt, rd, shamt;
    logic [15:0] immediate;
    logic [25:0] target_address;

    // Program Counter
    logic [31:0] pc, pc_next;
    logic [31:0] pc4;
    logic [27:0] target_address_shift_left_2;
    logic [31:0] jump_addr;
    logic [31:0] immediate_shift_left_2;
    logic [31:0] beq_addr;
    logic        beq;
    logic [31:0] pc_beq;

    // Instruction Memory
    logic [31:0] instr;

    // Control
    logic        reg_dst;
    logic        reg_write;
    logic        alu_src;
    logic [1:0]  alu_op;
    logic        mem_read;
    logic        mem_write;
    logic        mem_to_reg;
    logic        branch;
    logic        jump;

    // Register File
    logic        reg_write_en;
    logic [4:0]  reg_write_addr;
    logic [31:0] reg_write_data;
    logic [4:0]  reg_read_addr_1, reg_read_addr_2;
    logic [31:0] reg_read_data_1, reg_read_data_2;

    // ALU Control
    logic [2:0]  alu_control;

    // ALU
    logic [31:0] immediate_sign_ext;
    logic [31:0] alu_in_a, alu_in_b;
    logic [31:0] alu_result;
    logic        zero_flag;

    // Data Memory
    logic [31:0] mem_read_data;


    ////////////////////////
    // Instruction Format //
    ////////////////////////

    assign op             = instr[31:26];
    assign rs             = instr[25:21];
    assign rt             = instr[20:16];
    assign rd             = instr[15:11];
    assign shamt          = instr[10:6];
    assign func           = instr[5:0];
    assign immediate      = instr[15:0];
    assign target_address = instr[25:0];


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

    assign pc4 = pc + 4;

    // jump
    assign target_address_shift_left_2 = target_address << 2;
    assign jump_addr = {pc4[31:28], target_address_shift_left_2[27:0]};

    // branch    
    assign immediate_shift_left_2 = immediate_sign_ext << 2;
    assign beq_addr = pc4 + immediate_shift_left_2;
    assign beq = branch & zero_flag;

    // pc_next
    assign pc_bne = bne ? bne_addr : pc4;
    assign pc_next = jump ? jump_addr : pc_bne;


    ////////////////////////
    // Instruction Memory //
    ////////////////////////

    instr_mem #(
        .ADDR_SIZE      (1024),
        .ADDR_WIDTH     (32),
        .INSTR_WIDTH    (32)
    ) u_instr_mem (
        .addr           (pc),
        .instr          (instr)
    );


    /////////////////////
    //     Control     //
    /////////////////////

    control u_control (
        .opcode         (op),
        .reg_dst        (reg_dst),
        .reg_write      (reg_write),
        .alu_src        (alu_src),
        .alu_op         (alu_op),
        .mem_read       (mem_read),
        .mem_write      (mem_write),
        .mem_to_reg     (mem_to_reg),
        .branch         (branch),
        .jump           (jump)
    );


    /////////////////////
    //  Register File  //
    /////////////////////

    assign reg_read_addr_1 = rs;
    assign reg_read_addr_2 = rt;
    assign reg_write_addr  = reg_dst ? rd : rt;
    assign reg_write_data  = mem_to_reg ? mem_read_data : alu_result;

    reg_file #(
        .DATA_WIDTH     (32),
        .ADDR_WIDTH     (5)
    ) u_reg_file (
        .clk            (clk),
        .rst            (rst),
        .write_en       (reg_write),
        .write_addr     (reg_write_addr),
        .write_data     (reg_write_data),
        .read_addr_1    (reg_read_addr_1),
        .read_addr_2    (reg_read_addr_2),
        .read_data_1    (reg_read_data_1),
        .read_data_2    (reg_read_data_2)
    );


    ///////////////////
    //  ALU Control  //
    ///////////////////

    alu_control u_alu_control (
        .alu_op         (alu_op),
        .func           (func),
        .alu_control    (alu_control)
    );


    ///////////////////
    //      ALU      //
    ///////////////////

    assign immediate_sign_ext = {{16{immediate[15]}}, immediate};

    assign alu_in_a = reg_read_data_1;
    assign alu_in_b = alu_src ? immediate_sign_ext : reg_read_data_2;

    alu #(
        .DATA_WIDTH     (32)
    ) u_alu (
        .a              (alu_in_a),
        .b              (alu_in_b),
        .op_sel         (alu_control),
        .result         (alu_result),
        .zero           (zero_flag)
    );


    ///////////////////
    //  Data Memory  //
    ///////////////////

    data_mem #(
        .ADDR_SIZE      (1024),
        .ADDR_WIDTH     (32),
        .DATA_WIDTH     (32)
    ) u_data_mem (
        .clk            (clk),
        .read_en        (mem_read),
        .write_en       (mem_write),
        .addr           (alu_result),
        .write_data     (reg_read_data_2),
        .read_data      (mem_read_data)
    );

endmodule