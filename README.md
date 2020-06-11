# MIPS-Processor

A 32-bit single-cycle MIPS processor based on the RISC instruction set architecture.

## Instruction Format

<table>
    <thead align=center>
        <tr>
            <th>Name</th>
            <th colspan=6>Fields</th>
        </tr>
    </thead>
    <tbody align=center>
        <tr>
            <td>Field Size</td>
            <td>6 bits</td>
            <td>5 bits</td>
            <td>5 bits</td>
            <td>5 bits</td>
            <td>5 bits</td>
            <td>6 bits</td>
        </tr>
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