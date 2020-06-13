////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: control
// Description:
// Control Unit for controlling individual unit datapath activity
////////////////////////////////////////////////////////////////////////////////

module control (
        input  logic [5:0] opcode,    // instruction opcode
        output logic       reg_write, // register write
        output logic       alu_src,   // alu source
        output logic [1:0] alu_op,    // alu opcode
        output logic       mem_read,  // memory read
        output logic       mem_to_reg // memory to register
    );

    always_comb
        casex(opcode)
            6'b000000: begin // R-type
                reg_write  = 1'b1;
                alu_src    = 1'b0;
                alu_op     = 2'b10;
                mem_read   = 1'b0;
                mem_to_reg = 1'b0;
            end
            6'b100011: begin // lw
                reg_write  = 1'b1;
                alu_src    = 1'b1;
                alu_op     = 2'b00;
                mem_read   = 1'b1;
                mem_to_reg = 1'b1;
            end
            default: begin
                reg_write = 1'b0;
                alu_src    = 1'b0;
                alu_op    = 2'b00;
                mem_read   = 1'b0;
                mem_to_reg = 1'b0;
            end
        endcase

endmodule