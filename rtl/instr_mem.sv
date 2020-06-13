////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: instr_mem
// Description:
// Intruction memory outputs instructions at the given address
////////////////////////////////////////////////////////////////////////////////

module instr_mem
    #(
        parameter ADDR_SIZE   = 1,
        parameter ADDR_WIDTH  = 1,
        parameter INSTR_WIDTH = 1
    ) (
        input  logic [ADDR_WIDTH-1:0]  addr, // address
        output logic [INSTR_WIDTH-1:0] instr // instruction data
    );

    logic [INSTR_WIDTH-1:0] mem [ADDR_SIZE-1:0];

    assign instr = mem[addr/4];

endmodule