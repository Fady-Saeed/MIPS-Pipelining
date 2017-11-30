module IF_ID_register(pc_plus_four,out_instruction,
_pc_plus_four,op_code,rr1,rr2,immediate_address,rs,rt,rt_extra,rd,
clk);//na2es input bta3 control hazard
input wire [31:0] pc_plus_four,out_instruction;
output reg [31:0] _pc_plus_four;
output reg [5:0] op_code;
output reg [4:0] rr1,rr2;
output reg [15:0] immediate_address;
output reg [4:0] rs,rt,rt_extra,rd;
input clk;
always@(posedge clk)
begin
_pc_plus_four<=pc_plus_four;
op_code<=out_instruction[31:26];
rr1<=out_instruction[25:21];rr2<=out_instruction[20:16];
immediate_address<=out_instruction[15:0];
rs<=out_instruction[25:21];rt<=out_instruction[20:16];
rt_extra<=out_instruction[20:16];rd<=out_instruction[15:11];
end


endmodule
