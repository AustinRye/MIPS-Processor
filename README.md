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

## Instructions

| Instruction   | Assembly       | Function         | Encoding | Op     | Func   |
|:-------------:|:--------------:|:----------------:|:--------:|:------:|:------:|
| Addition      | add $1, $2, $3 | $1 <- $2 + $3    | R        | 000000 | 100000 |
| Subtraction   | sub $1, $2, $3 | $1 <- $2 - $3    | R        | 000000 | 100010 |
| Bitwise And   | and $1, $2, $3 | $1 <- $2 & $3    | R        | 000000 | 100100 |
| Bitwise Or    | or $1, $2, $3  | $1 <- $2 \| $3   | R        | 000000 | 100101 |
| Set Less Than | slt $1, $2, $3 | $1 <- $2 < $3    | R        | 000000 | 101010 |
| Load Word     | lw $1, 100($2) | $1 = mem[$2+100] | I        | 100011 | xxxxxx |
| Store Word    | sw $1, 100($2) | mem[$2+100] = $1 | I        | 101011 | xxxxxx |
| Jump          | j 10000        | go to 10000      | J        | 000010 | xxxxxx |

## Control

| Instruction | Opcode [5:0] | RegDst | RegWrite | ALUSrc | ALUOp [1:0] | MemRead | MemWrite | MemToReg | Jump |
|:-----------:|:------------:|:------:|:--------:|:------:|:-----------:|:-------:|:--------:|:--------:|:----:|
| R-type      | 000000       | 1      | 1        | 0      | 10          | 0       | 0        | 0        | 0    |
| lw          | 100011       | 0      | 1        | 1      | 00          | 1       | 0        | 1        | 0    |
| sw          | 101011       | x      | 0        | 1      | 00          | 0       | 1        | x        | 0    |
| j           | xxxxxx       | x      | 0        | x      | xx          | 0       | 0        | x        | 1    |

## ALU Control

| ALU Operation | ALUOp [1:0] | Func [5:0] | ALUControl[2:0] |
|:-------------:|:-----------:|:----------:|:---------------:|
| + (lw, sw)    | 00          | xxxxxx     | 010             |
| + (add)       | 1x          | 100000     | 010             |
| - (sub)       | 1x          | 100010     | 110             |
| & (and)       | 1x          | 100100     | 000             |
| \| (or)       | 1x          | 100101     | 001             |
| < (slt)       | 1x          | 101010     | 111             |
