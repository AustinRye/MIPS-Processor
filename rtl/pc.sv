////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: pc
// Description:
// Program Counter for storing the instruction address
////////////////////////////////////////////////////////////////////////////////

module pc
    #(
        parameter PC_WIDTH = 8
    ) (
        input  logic clk, // system clock
        input  logic rst, // active high reset
        input  logic [PC_WIDTH-1:0] pc_next, // next pc address
        output logic [PC_WIDTH-1:0] pc       // current pc address
    );

    always_ff @(posedge clk or posedge rst)
        if (rst)
            pc = 0;
        else
            pc = pc_next;

endmodule