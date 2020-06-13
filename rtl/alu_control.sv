////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: alu_control
// Description:
// ALU Control for controlling ALU operations
////////////////////////////////////////////////////////////////////////////////

module alu_control (
        input  logic [1:0] alu_op,     // alu opcode
        input  logic [5:0] func,       // function code
        output logic [2:0] alu_control // alu control opcode
    );

    always_comb
        casex ({alu_op, func})
            8'b00xxxxxx: alu_control = 3'b010; // lw, sw
            8'b1x100000: alu_control = 3'b010; // add
            8'b1x100010: alu_control = 3'b110; // sub
            8'b1x100100: alu_control = 3'b000; // and
            8'b1x100101: alu_control = 3'b001; // or
            8'b1x101010: alu_control = 3'b111; // slt
            default: alu_control = 3'b000;
        endcase

endmodule