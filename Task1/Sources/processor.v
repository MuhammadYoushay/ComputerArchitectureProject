module Single_Cycle_Processor(
    input clk, reset,
    output wire [63:0] element1,element2,element3,element4
);
    // Inputs
    wire [31:0] instruction;

    // Control signals
    wire [6:0] opcode;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [1:0] ALUOp;
//    wire [3:0] Funct;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [3:0] Operation;
    wire less, comp, Branch, Zero, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, data_memory_select;

    // Intermediate signals
    wire [63:0] imm_data;
    wire [63:0] register_file_mux_out;
    wire [63:0] alu_result;
    wire [63:0] data_memory_read_out;
    wire [63:0] WriteData;
    wire [63:0] readData1;
    wire [63:0] readData2;

    // Outputs
    wire [63:0] pc_default_out;
    wire [63:0] pc_branch_out;
    wire [63:0] pc_mux_out;
    wire [63:0] PC_Out;
    
Instruction_Memory IM(.Inst_Address(PC_Out),.instruction(instruction));
ImmDataExtractor ID(.instruction(instruction),.imm_data(imm_data));
InstructionParser IP(.opcode(opcode),.instruction(instruction),.rs1(rs1),.rs2(rs2),.rd(rd),.funct3(funct3),.funct7(funct7));
ALU_Control ALU_C(.ALUOp(ALUOp),.Funct({instruction[30], instruction[14:12]}),.Operation(Operation));
Control_Unit CU(.opcode(opcode),.Branch(Branch),.ALUOp(ALUOp),.RegWrite(RegWrite),.MemRead(MemRead),.MemToReg(MemToReg),.MemWrite(MemWrite),.ALUSrc(ALUSrc));
branch_control BC(.Funct({instruction[30], instruction[14:12]}),.less(less),.CarryOut(Zero),.comp(comp));
registerFile rf(.WriteData(WriteData),.rs1(rs1),.rs2(rs2),.rd(rd),.readData1(readData1),.readData2(readData2),.RegWrite(RegWrite),.clk(clk),.reset(reset));
mux Mux_3_RF(.sel(ALUSrc),.a(imm_data),.b(readData2),.data_out(register_file_mux_out));
mux Mux_2_DM(.sel(MemToReg),.a(data_memory_read_out),.b(alu_result),.data_out(WriteData));
Data_Memory DM(.MemWrite(MemWrite),.MemRead(MemRead),.Mem_Addr(alu_result),.Write_Data(readData2),.clk(clk),.Read_Data(data_memory_read_out), .element1(element1), .element2(element2), .element3(element3), .element4(element4));
alu_64 ALU(.a(readData1),.b(register_file_mux_out),.ALUOp(Operation),.Result(alu_result),.CarryOut(Zero),.less(less));
mux PC_Mux(.sel(Branch & comp), .a(pc_branch_out),.b(pc_default_out),.data_out(pc_mux_out));
Adder Pc_Adder(.a(PC_Out),.b(64'd4),.out(pc_default_out));
Adder Pc_branch_Adder(.a(PC_Out),.b(imm_data << 1), .out(pc_branch_out));
Program_Counter Prog_count(.PC_In(pc_mux_out),.PC_Out(PC_Out),.clk(clk),.reset(reset));
endmodule