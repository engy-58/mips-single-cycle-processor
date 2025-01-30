// Modified Control Unit
module MIPSControl (
    input [31:0] instruction,
    output reg RegDst, ALUSrc, MemToReg, RegWrite, MemWrite, MemRead, Branch,
    output reg [1:0] ALUOp
);
    wire [5:0] opcode;
    assign opcode = instruction[31:26];

    always @(*) begin
        // Default values
        RegDst = 0;
        ALUSrc = 0;
        MemToReg = 0;
        RegWrite = 0;
        MemWrite = 0;
        MemRead = 0;
        Branch = 0;
        ALUOp = 2'b00;

        case (opcode)
            6'b000000: begin // R-type
                RegDst = 1;
                RegWrite = 1;
                ALUOp = 2'b10;
            end
            6'b001000: begin // addi
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b00;
            end
            6'b100011: begin // lw
                ALUSrc = 1;
                MemToReg = 1;
                RegWrite = 1;
                MemRead = 1;
                ALUOp = 2'b00;
            end
            6'b101011: begin // sw
                ALUSrc = 1;
                MemWrite = 1;
                ALUOp = 2'b00;
            end
            6'b000100: begin // beq
                Branch = 1;
                ALUOp = 2'b01;
            end
        endcase
    end
endmodule