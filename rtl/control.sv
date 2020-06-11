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
        output logic [1:0] alu_op     // alu opcode
    );

    always_comb
        casex(opcode)
            6'b000000: begin // R-type
                reg_write = 1'b1;
                alu_op    = 2'b10;
            end
            default: begin
                reg_write = 1'b0;
                alu_op    = 2'b00;
            end
        endcase

endmodule