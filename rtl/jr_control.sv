////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: jr_control
// Description:
// JR Control for controlling JR operations
////////////////////////////////////////////////////////////////////////////////

module alu_control (
        input  logic [1:0] alu_op,    // alu opcode
        input  logic [5:0] fn,        // function code
        output logic       jr_control // jr control
    );

    always_comb
        casex ({alu_op, fn})
            8'b10001000: jr_control = 1'b1;
            default: jr_control = 1'b0;
        endcase

endmodule