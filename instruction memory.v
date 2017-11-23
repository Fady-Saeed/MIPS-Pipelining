module instruction_memory(read_address,out);
input [31:0] read_address;
output [31:0] out;
reg [31:0] IM [0:1023];//instruction memory is 4KB,address is 32 bit
initial
begin
IM[0]=32 'h 02508820; //  // add s1,s2,s0
//IM[1]=32'h 02508822;  // sub s1,s2,s0

end
assign out=IM[read_address>>2];

endmodule
