// Instruction Memory
module InstructionMemory (
    input [31:0] address,
    output reg [31:0] instruction
);
    reg [31:0] memory [0:255];

    initial begin
        memory[0] = 32'h20020005;
        memory[1] = 32'h2003000c;
        memory[2] = 32'h20670009;
        memory[3] = 32'h00e22025;
        memory[4] = 32'h00642824;
        memory[5] = 32'h00a42820;
        memory[6] = 32'h10a70008;
        memory[7] = 32'h0064202a;
        memory[8] = 32'h10800001;
        memory[9] = 32'h20050000;
        memory[10] = 32'h00e2202a;
        memory[11] = 32'h00853820;
        memory[12] = 32'h00e23822;
        memory[13] = 32'hac670044;
        memory[14] = 32'h8c020050;
        memory[15] = 32'hac020054;
    end

    always @(*) begin
        instruction = memory[address[31:2]];
    end
endmodule

// Data Memory
module DataMemory (
    input clk,
    input write_enable,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data
);
    reg [31:0] memory [0:255];
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 0;
    end

    always @(posedge clk) begin
        if (write_enable)
            memory[address[31:2]] <= write_data;
    end

    always @(*) begin
        read_data = memory[address[31:2]];
    end
endmodule