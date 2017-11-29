module MEM_WB_register(
WB_control,MemtoReg,MemWrite,
address,_address,
one,_one,
two,_two,
clk
);
input clk;

input [1:0] WB_control;
output reg MemtoReg,MemWrite;

input wire [31:0] address;
output reg [31:0] _address;

input wire [31:0] one;
output reg [31:0] _one;

input wire [4:0] two;
output reg [4:0] _two;

always@(posedge clk)
begin
MemtoReg<=WB_control[0];
MemWrite<=WB_control[1];
_address<=address;
_one<=one;
_two<=two;
end


endmodule
