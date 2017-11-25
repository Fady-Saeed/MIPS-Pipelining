module DataMemory(ReadData,Address,WriteData,MemWrite,MemRead,Clk);
	output reg[31:0] ReadData;
	input wire[31:0] Address;
	input wire[31:0] WriteData;
	input wire MemWrite;
	input wire MemRead;
	input wire Clk;

	reg [31:0] DataMemory[0:1023];


	always @(posedge Clk) begin
		ReadData <= DataMemory[Address];
		if(MemWrite == 1) begin
			DataMemory[Address]<=WriteData;
		end
	end

/*	always @(Address or WriteData or MemWrite or MemRead) begin
		if(MemWrite == 1) begin
			DataMemory[Address]=WriteData;
			ReadData = DataMemory[Address];
		end
		else begin
			ReadData = DataMemory[Address];			
		end
	end
*/
	// Filling File & Put the values in Data Memory

	reg[31:0] i;
	integer file;
	/*initial begin
		i=0;
		file = $fopen("D:\DM.txt");
		$fmonitor(file,"%b",i);
		for(i=0;i<1024;i=i+1) begin
			#1
			i=i;
		end
		#20
		$readmemb("D:\DM.txt",DataMemory);	
	end*/

endmodule

module Test_DataMemory;
	wire[31:0] ReadData;
	reg[31:0] Address;
	reg[31:0] WriteData;
	reg MemWrite;
	reg MemRead;
	reg Clk;
	initial begin
		#2048
		Clk = 0;
		MemWrite = 0;
		#10
		Address = 0;
		#1
		$display("Address is %d ,, Data is %d ,, MemWrite is %d",Address,$signed(ReadData),MemWrite);

		#10
		MemWrite = 1;
		Address = 993;
		WriteData = 0;
		#1
		$display("Address is %d ,, Data is %d ,, MemWrite is %d",Address,$signed(ReadData),MemWrite);

		#10
		MemWrite = 0;
		Address = 993;
		#1
		$display("Address is %d ,, Data is %d ,, MemWrite is %d",Address,$signed(ReadData),MemWrite);

		#10
		Address=992;
		#1
		$display("Address is %d ,, Data is %d ,, MemWrite is %d",Address,$signed(ReadData),MemWrite);

		#10
		MemWrite = 1;
		Address = 1023;
		WriteData = -20;		
		#1
		$display("Address is %d ,, Data is %d ,, MemWrite is %d",Address,$signed(ReadData),MemWrite);

		#10
		Address = 1023;
		MemWrite = 0;
		#1
		$display("Address is %d ,, Data is %d ,, MemWrite is %d",Address,$signed(ReadData),MemWrite);
		
	end
	DataMemory D1(ReadData,Address,WriteData,MemWrite,MemRead,Clk);
	always begin
		#1 Clk = ~Clk;
	end
endmodule