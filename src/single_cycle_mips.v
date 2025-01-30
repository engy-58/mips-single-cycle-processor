// Single Cycle MIPS Processor
module SingleCycleMIPS (
    input clk,
    input reset
);
    // Internal signals
    wire [31:0] PC, PCNext, PCPlus4;
    wire [31:0] instruction;
    wire RegDst, ALUSrc, MemToReg, RegWrite, MemWrite, MemRead, Branch;
    wire [1:0] ALUOp;
    wire [4:0] writeReg;
    wire [31:0] readData1, readData2, writeData;
    wire [31:0] signExtImm;
    wire [3:0] ALUCtl;
    wire [31:0] ALUIn2, ALUOut;
    wire Zero;
    wire [31:0] memReadData;

    // Program Counter
    MIPSPC pcModule (.clk(clk), .reset(reset), .newPC(PCNext), .PC(PC));
    PCPlus4 pcPlus4Module (.pc(PC), .pcNext(PCPlus4));

    // Instruction Memory
    InstructionMemory instrMem (.address(PC), .instruction(instruction));

    // Control Unit
    MIPSControl controlUnit (
        .instruction(instruction),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    // Register File
    Mux2to1 #(5) regDstMux (
        .in0(instruction[20:16]),
        .in1(instruction[15:11]),
        .sel(RegDst),
        .out(writeReg)
    );

    MIPSRegisterFile regFile (
        .clk(clk),
        .RegWrite(RegWrite),
        .ReadAddress1(instruction[25:21]),
        .ReadAddress2(instruction[20:16]),
        .WriteAddress(writeReg),
        .WriteData(writeData),
        .ReadData1(readData1),
        .ReadData2(readData2)
    );

    // Sign Extend
    SignExtend signExt (.in(instruction[15:0]), .out(signExtImm));

    // ALU Control
    ALUControl aluCtrl (
        .ALUOp(ALUOp),
        .funct(instruction[5:0]),
        .ALUControl(ALUCtl)
    );

    // ALU
    Mux2to1 aluSrcMux (
        .in0(readData2),
        .in1(signExtImm),
        .sel(ALUSrc),
        .out(ALUIn2)
    );

    MIPSALU alu (
        .ALUctl(ALUCtl),
        .A(readData1),
        .B(ALUIn2),
        .ALUOut(ALUOut),
        .Zero(Zero)
    );

    // Data Memory
    DataMemory dataMem (
        .clk(clk),
        .write_enable(MemWrite),
        .address(ALUOut),
        .write_data(readData2),
        .read_data(memReadData)
    );

    // Writeback
    Mux2to1 memToRegMux (
        .in0(ALUOut),
        .in1(memReadData),
        .sel(MemToReg),
        .out(writeData)
    );

    // Branch Logic
    BranchLogic branchLogic (
        .PCPlus4(PCPlus4),
        .signExtOffset(signExtImm),
        .Branch(Branch),
        .Zero(Zero),
        .PCNext(PCNext)
    );
endmodule