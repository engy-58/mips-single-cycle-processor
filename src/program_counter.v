// Program Counter
module MIPSPC #(parameter MIPS_PC_WIDTH_m1 = 31)(
    input clk,
    input reset,
    input [MIPS_PC_WIDTH_m1:0] newPC,
    output reg [MIPS_PC_WIDTH_m1:0] PC
);
    initial PC = 0;

    always @(posedge clk) begin
        if (reset)
            PC <= 0;
        else
            PC <= newPC;
    end
endmodule