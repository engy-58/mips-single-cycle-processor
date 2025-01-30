// MIPS Register File
module MIPSRegisterFile (
    input clk,
    input RegWrite,
    input [4:0] ReadAddress1, ReadAddress2, WriteAddress,
    input [31:0] WriteData,
    output [31:0] ReadData1, ReadData2
);
    reg [31:0] registers [0:31];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 0;
    end

    assign ReadData1 = (ReadAddress1 != 0) ? registers[ReadAddress1] : 0;
    assign ReadData2 = (ReadAddress2 != 0) ? registers[ReadAddress2] : 0;

    always @(posedge clk) begin
        if (RegWrite && WriteAddress != 0)
            registers[WriteAddress] <= WriteData;
    end
endmodule