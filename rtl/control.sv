////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: control
// Description:
// Control Unit for controlling individual unit datapath activity
////////////////////////////////////////////////////////////////////////////////

module control (
        input  logic [5:0] opcode, // opcode from instruction
        output logic reg_dst,      // register destination enable
        output logic jump,         // jump enable
        output logic branch,       // branch enable
        output logic mem_read,     // memory read enable
        output logic mem_to_reg,   // memory to register enable
        output logic [1:0] alu_op, // alu opcode
        output logic mem_write,    // memory write enable
        output logic alu_src,      // alu source enable
        output logic reg_write,    // register write enable
        output logic sign_zero     // sign zero enable
    );

    always_comb
        casex(opcode)
            6'b000000: begin // R - type
                reg_dst    = 1'b1;
                alu_src    = 1'b0;
                mem_to_reg = 1'b0;
                reg_write  = 1'b1;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                branch     = 1'b0;
                alu_op     = 2'b10;
                jump       = 1'b0;
                sign_zero  = 1'b0;
            end
            6'b100011: begin // LW - load word
                reg_dst    = 1'b0;
                alu_src    = 1'b1;
                mem_to_reg = 1'b1;
                reg_write  = 1'b1;
                mem_read   = 1'b1;
                mem_write  = 1'b0;
                branch     = 1'b0;
                alu_op     = 2'b00;
                jump       = 1'b0;
                sign_zero  = 1'b0;
            end
            6'b101011: begin // SW - store word
                reg_dst    = 1'bx;
                alu_src    = 1'b1;
                mem_to_reg = 1'bx;
                reg_write  = 1'b0;
                mem_read   = 1'b0;
                mem_write  = 1'b1;
                branch     = 1'b0;
                alu_op     = 2'b00;
                jump       = 1'b0;
                sign_zero  = 1'b0;
            end
            6'b000101: begin // BNE - branch not equal
                reg_dst    = 1'b0;
                alu_src    = 1'b0;
                mem_to_reg = 1'b0;
                reg_write  = 1'b0;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                branch     = 1'b1;
                alu_op     = 2'b01;
                jump       = 1'b0;
                sign_zero  = 1'b0;
            end
            6'b001110: begin // XORI - XOR immidiate
                reg_dst    = 1'b0;
                alu_src    = 1'b1;
                mem_to_reg = 1'b0;
                reg_write  = 1'b1;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                branch     = 1'b0;
                alu_op     = 2'b11;
                jump       = 1'b0;
                sign_zero  = 1'b1;
            end
            6'b001110: begin // J - jump
                reg_dst    = 1'b0;
                alu_src    = 1'b0;
                mem_to_reg = 1'b0;
                reg_write  = 1'b0;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                branch     = 1'b0;
                alu_op     = 2'b00;
                jump       = 1'b1;
                sign_zero  = 1'b0;
            end
            default: begin
                reg_dst    = 1'b0;
                alu_src    = 1'b0;
                mem_to_reg = 1'b0;
                reg_write  = 1'b0;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                branch     = 1'b0;
                alu_op     = 2'b00;
                jump       = 1'b0;
                sign_zero  = 1'b0;
            end
        endcase

endmodule