# MIPS-Processor

A 32-bit single-cycle MIPS processor based on the RISC instruction set architecture.

## Instruction Format

<table>
    <thead align=center>
        <tr>
            <td>Field Size</td>
            <td>6 bits</td>
            <td>5 bits</td>
            <td>5 bits</td>
            <td>5 bits</td>
            <td>5 bits</td>
            <td>6 bits</td>
        </tr>
    </thead>
    <tbody align=center>
        <tr>
            <td>R-format</td>
            <td>op</td>
            <td>rs</td>
            <td>rt</td>
            <td>rd</td>
            <td>shamt</td>
            <td>func</td>
        </tr>
        <tr>
            <td>I-format</td>
            <td>op</td>
            <td>rs</td>
            <td>rt</td>
            <td colspan=3>immediate</td>
        </tr>
        <tr>
            <td>J-format</td>
            <td>op</td>
            <td colspan=5>target address</td>
        </tr>
    </tbody>
</table>

## Control Signals

| Instruction | Opcode [5:0] | RegWrite | ALUOp [1:0] |
|:-----------:|:------------:|:--------:|:-----------:|
| R-type      | 000000       | 1        | 10          |

## ALU Control

| ALUOp [1:0] | Func [5:0] | ALUControl[2:0] | ALU Operation |
|:-----------:|:----------:|:---------------:|:-------------:|
| 1x          | 100000     | 010             | + (add)       |
| 1x          | 100010     | 110             | - (sub)       |
| 1x          | 100100     | 000             | & (and)       |
| 1x          | 100101     | 001             | \| (or)       |
| 1x          | 101010     | 111             | < (slt)       |
