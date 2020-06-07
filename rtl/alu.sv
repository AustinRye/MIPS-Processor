////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: alu
// Description:
// Arithmetic Logic Unit for calculating mathematical operations given specific
// operation selection
////////////////////////////////////////////////////////////////////////////////

module alu
    #(
        parameter DATA_WIDTH = 8
    ) (
        input  logic [DATA_WIDTH-1:0] a,        // operation data
        input  logic [DATA_WIDTH-1:0] b,        // operation data
        input  logic [1:0]            op_sel,   // select operation
        output logic [DATA_WIDTH-1:0] result,   // operation result
        output logic                  zero      // zero flag
    );

    always_comb
    begin
        case(op_sel)
            2'b00: result = a + b; // add
            2'b01: result = a | b; // or
            2'b10: result = a - b; // sub
            2'b11: if (a < b) result = 1;
                   else       result = 0;
            default: result = 0;
        endcase
    end

    assign zero = (result == 0) ? 1 : 0;

endmodule