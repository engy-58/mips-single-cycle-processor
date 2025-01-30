// Sign Extend
module SignExtend (
    input [15:0] in,
    output [31:0] out
);
    assign out = {{16{in[15]}}, in};
endmodule

// Shift Left 2
module sl2(
    input wire [31:0] a,
    output wire [31:0] y
);
    assign y = {a[29:0], 2'b00};
endmodule

// PC Plus 4
module PCPlus4(
    input [31:0] pc,
    output [31:0] pcNext
);
    assign pcNext = pc + 4;
endmodule

// Branch Logic
module BranchLogic (
    input [31:0] PCPlus4,
    input [31:0] signExtOffset,
    input Branch,
    input Zero,
    output [31:0] PCNext
);
    wire [31:0] branchTarget = PCPlus4 + (signExtOffset << 2);
    assign PCNext = (Branch & Zero) ? branchTarget : PCPlus4;
endmodule

// 2-to-1 Multiplexer
module Mux2to1 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] in0, in1,
    input sel,
    output [WIDTH-1:0] out
);
    assign out = sel ? in1 : in0;
endmodule