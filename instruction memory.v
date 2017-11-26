module instruction_memory(read_address,out);
input [31:0] read_address;
output [31:0] out;
reg [31:0] IM [0:1023];//instruction memory is 4KB,address is 32 bit
initial
begin
/*IM[0]=32 'h 02508820; //  // add s1,s2,s0
IM[1]=32'h 02508822;  // sub s1,s2,s0*/
//IM[1]=32'b00000000000000001000000000100000; //$s0=0
//IM[1]=32'b00100000000100010000000000000100; //$s1=4
//IM[2]=32'b10101100000100010000000000000000; //DM[0] = $s1 = 4
//IM[3]=32'b10001100000100100000000000000000; //$s2=DM[0]=4
//IM[0]=32'b10101100000100010000000000000000; // lw $s2,0($zero)

//IM[0]=32'h0x00008020; // add $s0,$zero,$zero
//IM[0]=32'h0x8C110000; // lw $s1,0($zero)
//IM[0]=32'h0x0000B820; // add $s7,$zero,$zero
//IM[0]=32'h0x8C160000; // lw $s6,0($zero)
//IM[0]=32'h0xAC160000; // sw $s6,0($zero)

//IM[0]=32'h0x12110003; // beq $s0,$s1,label
//IM[0]=32'h0x02328020; // add $s0,$s1,$s2
//IM[0]=32'h0x8e550000; // lw $s5,0($s2)
//IM[0]=32'h0xac0d0000; // sw $t5,0($zero)
//IM[1]=32'h0x0232b020; // label: sub $s6,$s1,$s2

//IM[0]=32'h0x00000000;
IM[0]=32'h0x8C100004; // lw $s0,0($zero)
//IM[1]=32'h0xAC110000; // sw $s1,0($zero)

end
assign out=IM[read_address>>2];

endmodule
