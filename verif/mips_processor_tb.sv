////////////////////////////////////////////////////////////////////////////////
// Author: Austin Rye <ryeaustinw@gmail.com>
//
// Name: mips_processor_tb
// Description:
// MIPS Processor verification testbench
////////////////////////////////////////////////////////////////////////////////

module mips_processor_tb;

    logic clk, rst;


    ////////////////////////////////////////////////////////////////////////////
    //  Tasks
    ////////////////////////////////////////////////////////////////////////////

    task reset;
        // reset
        rst = 1;
        #100;
        rst = 0;
    endtask

    task itype_test;
        parameter instr_num = 2;

        // load instr contents
        $readmemb("bin/itype.ibin", mips_processor_dut.u_instr_mem.mem);

        // load register contents
        $readmemb("bin/itype.rbin", mips_processor_dut.u_reg_file.regs);

        // Execute instructions
        repeat(instr_num) @(posedge clk);
    endtask

    task rtype_test;
        parameter instr_num = 5;

        // load instr contents
        $readmemb("bin/rtype.ibin", mips_processor_dut.u_instr_mem.mem);

        // load register contents
        $readmemb("bin/rtype.rbin", mips_processor_dut.u_reg_file.regs);

        // Execute instructions
        repeat(instr_num) @(posedge clk);
    endtask


    ////////////////////////////////////////////////////////////////////////////
    //  Test Runs
    ////////////////////////////////////////////////////////////////////////////

    initial begin
        clk = 0;
        reset();

        itype_test();

        #10;
        $finish;
    end

    ////////////////////////////////////////////////////////////////////////////
    //  DUT Instantiations
    ////////////////////////////////////////////////////////////////////////////

    always
        #5 clk = ~clk;

    mips_processor mips_processor_dut (
        .clk(clk),
        .rst(rst)
    );


    ////////////////////////////////////////////////////////////////////////////
    //  GTKWave
    ////////////////////////////////////////////////////////////////////////////

    initial begin
        // dump vcd waveform file
        $dumpfile("waveform.vcd");
        $dumpvars(0, mips_processor_tb);

        // instr_mem mem array
        for(int i=0; i < 1024; i++)
            $dumpvars(1, mips_processor_dut.u_instr_mem.mem[i]);

        // reg_file regs array
        for(int i=0; i < 32; i++)
            $dumpvars(1, mips_processor_dut.u_reg_file.regs[i]);

        // data_mem mem array
        for(int i=0; i < 1024; i++)
            $dumpvars(1, mips_processor_dut.u_data_mem.mem[i]);
    end

endmodule