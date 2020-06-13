////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: data_mem
// Description:
// Data Memory for reading/writing to memory
////////////////////////////////////////////////////////////////////////////////

module data_mem
    #(
        parameter ADDR_SIZE  = 1,
        parameter ADDR_WIDTH = 1,
        parameter DATA_WIDTH = 1
    ) (
        input  logic clk,      // system clock
        input  logic read_en,  // read enable
        input  logic write_en, // write enable
        input  logic [ADDR_WIDTH-1:0] addr,       // address
        input  logic [DATA_WIDTH-1:0] write_data, // write data
        output logic [DATA_WIDTH-1:0] read_data   // read data
    );

    logic [DATA_WIDTH-1:0] mem [ADDR_SIZE-1:0];

    always_ff @(posedge clk)
        if (write_en)
            mem[addr/4] = write_data;

    always_comb
        if (read_en)
            read_data = mem[addr/4];

endmodule