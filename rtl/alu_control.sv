////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: alu_control
// Description:
// ALU Control for controlling ALU operations
////////////////////////////////////////////////////////////////////////////////

module alu_control (
        input  logic [1:0] alu_op,     // alu opcode
        input  logic [5:0] fn,         // function code
        output logic [1:0] alu_control // alu control opcode
    );

    always_comb
        casex ({alu_op, fn})
            8'b11xxxxxx: alu_control = 2'b01;
            8'b00xxxxxx: alu_control = 2'b00;
            8'b01xxxxxx: alu_control = 2'b10;
            8'b10100000: alu_control = 2'b00;
            8'b10100010: alu_control = 2'b10;
            8'b10101010: alu_control = 2'b11;
            default: alu_control = 2'b00;
        endcase

endmodule