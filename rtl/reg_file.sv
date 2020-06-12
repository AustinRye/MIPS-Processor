////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: reg_file
// Description:
// Register File for storing register data
////////////////////////////////////////////////////////////////////////////////

module reg_file
    #(
        parameter DATA_WIDTH = 8,
        parameter ADDR_WIDTH = 8
    ) (
        input  logic clk,                          // system clock
        input  logic rst,                          // active high reset
        input  logic write_en,                     // write enable
        input  logic [ADDR_WIDTH-1:0] write_addr,  // write address
        input  logic [DATA_WIDTH-1:0] write_data,  // write data
        input  logic [ADDR_WIDTH-1:0] read_addr_1, // read 1st address
        input  logic [ADDR_WIDTH-1:0] read_addr_2, // read 2nd address
        output logic [DATA_WIDTH-1:0] read_data_1, // read 1st data
        output logic [DATA_WIDTH-1:0] read_data_2  // read 2nd data
    );

    logic [DATA_WIDTH-1:0] regs [2**ADDR_WIDTH-1:0];

    always_ff @(posedge clk or posedge rst)
        if (rst)
            for (int i = 0; i < 2**ADDR_WIDTH; i++)
                regs[i] = 0;
        else if (write_en)
            regs[write_addr] = write_data;

    assign read_data_1 = regs[read_addr_1];
    assign read_data_2 = regs[read_addr_2];

endmodule