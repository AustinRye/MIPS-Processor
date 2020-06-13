////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: mips_processor_tb
// Description:
// MIPS Processor verification testbench
////////////////////////////////////////////////////////////////////////////////

module mips_processor_tb;

    logic clk, rst;

    always
        #5 clk = ~clk;

    mips_processor mips_processor_dut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        // load memory contents
        $readmemb("instrs.mbin", mips_processor_dut.u_instr_mem.mem);

        // initial state
        clk = 0;
        rst = 1;
        
        # 20;

        rst = 0;
        $readmemb("regs.mbin", mips_processor_dut.u_reg_file.regs);

        #10000;
        $finish;
    end

    initial begin
        // dump vcd waveform file
        $dumpfile("waveform.vcd");
        $dumpvars(0, mips_processor_tb);

        // instr_mem mem array
        for(int i=0; i < 5; i++)
            $dumpvars(1, mips_processor_dut.u_instr_mem.mem[i]);

        // reg_file reg_array array
        for(int i=0; i < 32; i++)
            $dumpvars(1, mips_processor_dut.u_reg_file.regs[i]);
    end

endmodule