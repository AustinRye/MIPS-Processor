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
        parameter REG_WIDTH   = 8
    ) (
        input  logic clk,                          // system clock
        input  logic rst,                          // active high reset
        input  logic write_en,                     // write enable
        input  logic [REG_WIDTH-1:0]  write_addr,  // write address
        input  logic [DATA_WIDTH-1:0] write_data,  // write data
        input  logic [REG_WIDTH-1:0]  read_addr_1, // read 1st address
        input  logic [REG_WIDTH-1:0]  read_addr_2, // read 2nd address
        output logic [DATA_WIDTH-1:0] read_data_1, // read 1st data
        output logic [DATA_WIDTH-1:0] read_data_2  // read 2nd data
    );

    logic [DATA_WIDTH-1:0] reg_array [2**REG_WIDTH-1:0];

    always_ff @(posedge clk or posedge rst)
        if (rst)
            for (int i = 0; i < 2**REG_WIDTH; i++)
                reg_array[i] = 0;
        else if (write_en)
            reg_array[write_addr] = write_data;

    assign read_data_1 = reg_array[read_addr_1];
    assign read_data_2 = reg_array[read_addr_2];

endmodule