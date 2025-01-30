module top (
    input wire clk,
    input wire reset,
    output wire [31:0] writedata,
    output wire [31:0] dataadr,
    output wire memwrite
);
    SingleCycleMIPS mips (.clk(clk), .reset(reset));

    assign writedata = mips.readData2;
    assign dataadr = mips.ALUOut;
    assign memwrite = mips.MemWrite;
endmodule