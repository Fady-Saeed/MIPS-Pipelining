module mips_processor;
reg clk;
reg [31:0] pc=0;wire [31:0] out_instruction;
wire [5:0] opcode,func;assign opcode=out_instruction[31:26];assign func=out_instruction[5:0];
wire [4:0] rs,rt,rd;assign rs=out_instruction[25:21];assign rt=out_instruction[20:16];assign rd=out_instruction[15:11];
wire [15:0] immediate;assign immediate=out_instruction[15:0];
wire [4:0] shift_amt;assign shift_amt=out_instruction[10:6];
wire RegDst , Branch , MemRead , MemtoReg , MemWrite , AluSrc , RegWrite;
wire [1:0] AluOp;
initial
begin
$monitor($time,,,,"%d   %d   %d",rs,rt,rd);
end

instruction_memory IM(pc,out_instruction);
wire [4:0] write_register;M5 m1(rt,rd,RegDes,write_register);
wire [31:0] out_RF1;wire [31:0] out_RF2,write_data;registerfile RF(rs,rt,write_register,write_data,RegWrite,out_RF1,out_RF2,clk);

ControlUnit cu( RegDst , Branch , MemRead , MemtoReg , AluOp , MemWrite , AluSrc , RegWrite ,opcode );
wire [31:0] output_extended;sign_extend SE(immediate,output_extended);
wire[31:0] in_ALU1;mux m2(out_RF2,output_extended,AluSrc,in_ALU1);
wire [3:0] alu_control_out;ALU_CNTRL a1(alu_control_out,AluOp,func);
wire zero_flag;wire[31:0] output_alu;ALU a(out_RF1,in_ALU1,alu_control_out,shift_amt,output_alu,zero_flag);
wire [31:0] ReadData;DataMemory DM(ReadData,output_alu,out_RF2,MemWrite,MemRead,Clk);
mux m3(ReadData,output_alu,MemtoReg,write_data);
wire output_and;assign output_and=Branch&zero_flag;
wire [31:0]temp1,temp2;
assign temp1=pc+4;assign temp2=(output_extended*4)+temp1;
wire [31:0] new_pc;mux m4(temp1,temp2,output_and,new_pc);
new_pc=new_pc<<2;
always@(posedge clk)
begin
	if(pc!=0)
	begin
		pc<=new_pc;
	end
end
always
begin
#5
clk=~clk;
end
endmodule