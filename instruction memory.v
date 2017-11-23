module instruction_memory(read_address,out);
input [31:0] read_address;
output [31:0] out;
reg [31:0] IM [0:1023];//instruction memory is 4KB,address is 32 bit
initial
begin
IM[0]=32 'h FFFFFFFF;
IM[1]=1;

end
assign out=IM[read_address];

endmodule
