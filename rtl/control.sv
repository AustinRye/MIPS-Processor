////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: control
// Description:
// Control Unit for controlling individual unit datapath activity
////////////////////////////////////////////////////////////////////////////////

module control (
        input  logic [5:0] opcode,     // instruction opcode
        output logic       reg_dst,    // register destination
        output logic       reg_write,  // register write
        output logic       alu_src,    // alu source
        output logic [1:0] alu_op,     // alu opcode
        output logic       mem_read,   // memory read
        output logic       mem_write,  // memory write
        output logic       mem_to_reg, // memory to register
        output logic       branch,     // branch
        output logic       jump        // jump
    );

    always_comb
        casex(opcode)
            6'b000000: begin // R-type
                reg_dst    = 1'b1;
                reg_write  = 1'b1;
                alu_src    = 1'b0;
                alu_op     = 2'b10;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                mem_to_reg = 1'b0;
                branch     = 1'b0;
                jump       = 1'b0;
            end
            6'b100011: begin // lw
                reg_dst    = 1'b0;
                reg_write  = 1'b1;
                alu_src    = 1'b1;
                alu_op     = 2'b00;
                mem_read   = 1'b1;
                mem_write  = 1'b0;
                mem_to_reg = 1'b1;
                branch     = 1'b0;
                jump       = 1'b0;
            end
            6'b101011: begin // sw
                reg_dst    = 1'b1;
                reg_write  = 1'b0;
                alu_src    = 1'b1;
                alu_op     = 2'b00;
                mem_read   = 1'b0;
                mem_write  = 1'b1;
                mem_to_reg = 1'b0;
                branch     = 1'b0;
                jump       = 1'b0;
            end
            6'b000100: begin // beq
                reg_dst    = 1'b0;
                reg_write  = 1'b0;
                alu_src    = 1'b0;
                alu_op     = 2'b01;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                mem_to_reg = 1'b0;
                branch     = 1'b1;
                jump       = 1'b0;
            end
            6'b000010: begin // j
                reg_dst    = 1'b0;
                reg_write  = 1'b0;
                alu_src    = 1'b0;
                alu_op     = 2'b00;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                mem_to_reg = 1'b0;
                branch     = 1'b0;
                jump       = 1'b1;
            end
            default: begin
                reg_dst    = 1'b1;
                reg_write  = 1'b0;
                alu_src    = 1'b0;
                alu_op     = 2'b00;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                mem_to_reg = 1'b0;
                branch     = 1'b0;
                jump       = 1'b0;
            end
        endcase

endmodule