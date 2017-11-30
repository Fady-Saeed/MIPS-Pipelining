module  Forwarding_Unit ( control_mux1 , control_mux2 ,  rs , rt , rd3 , rd4 , reg_write_exe, reg_write_mem );

/////**** rs and rt come from pipeline register 2 , rd3 come  from pipeline register3 , rd4 from pipeline register 4 .  *****/////////

/////**** reg_write_exe is reg write signal stored in pipelined register 3 and the same for  reg_write_mem   *****////////////

/////**** control_mux1 is register in top . control_mux2 is register below. *****//////

output reg [1:0] control_mux1 , control_mux2;

input [4:0]  rs , rt , rd3 , rd4 ;

input reg_write_exe , reg_write_mem ;

reg [3:0] where;

initial

begin

$monitor ( $time ,,,,"outputs are in same order of inputs : %b %b %b %b %b %b %b %b %b " , where, control_mux1 , control_mux2 ,  rs , rt , rd3 , rd4 , reg_write_exe, reg_write_mem );

end


always @ ( rs ,rt , rd3 , rd4 , reg_write_exe , reg_write_mem )


begin

	if ( reg_write_exe == 1 &&  ( reg_write_mem == 0 || reg_write_mem==1'bx)  )    ////  Forwarding may occur from third pipelined register
	begin

	if ( ( rs == rd3 ) && (rd3 != 5'b00000) )

	begin
		
	control_mux1 = 2'b10 ;

	where = 4'b0000;
		
	end
	else begin
		control_mux1 = 2'b00;
	end
	
	if( rt == rd3 && rd3 != 5'b00000 )
	
	begin
	
	control_mux2 = 2'b10 ;

	where = 4'b0001;
	end
	else begin
		control_mux2 = 2'b00;
	end
	
	end

	else if ( reg_write_mem == 1 && reg_write_exe != 1 )   ///// Forwarding may occur from fourth pipelined register.

	begin
	
	if ( rd4 != 5'b00000 && rd4 == rs )

	begin
	
	control_mux1 = 2'b01 ;
	where = 4'b0010;

	end
	
	else control_mux1 = 2'b00;
	
	if( rd4 != 5'b00000 && rd4 == rt )

	begin
	
	control_mux2 = 2'b01;
	where = 4'b0011;
	end

	else control_mux2 = 2'b00;

	end


	else if ( reg_write_exe == 1 && reg_write_mem ==1) ////// Forwarding may occur from third pipelined register.

	begin
	
	if ( (rd3 == rd4 || rd3 == rs) && rd3 != 5'b00000 )

	begin
	
	control_mux1 = 2'b10 ;
	where = 4'b0100;
	end

	else control_mux1 = 2'b00;

	if ( (rd3 == rd4 || rd3 == rt) && rd3 != 5'b00000 )
	begin
	control_mux2 = 2'b10 ;
	where = 4'b0101;
	end
	
	else control_mux2 = 2'b00;

	end
	
	else 
 	begin
	control_mux1 = 2'b00 ;
	control_mux2 = 2'b00;
	where = 4'b 1111;
	end

end

	
endmodule





/////////////////************** Test Bench for forwarding unit         *********//////////



module testforward ;


reg [4:0] rs , rt , rd3 , rd4 ;

reg reg_write_exe , reg_write_mem ;

wire [1:0] control_mux1 , control_mux2;

Forwarding_Unit F ( control_mux1 , control_mux2 ,  rs , rt , rd3 , rd4 , reg_write_exe, reg_write_mem );

initial


begin


reg_write_exe = 0;
reg_write_mem = 1;

rs = 5'b 10100;
rt = 5'b 10101;
rd3 = 5'b 10100;
rd4 = 5'b10101;   

# 10

reg_write_exe = 1 ;
reg_write_mem = 1;
rs = 5'b 10101;
rt = 5'b 10101;   
rd3 = 5'b 10101;
rd4 = 5'b10101;   


#10

reg_write_exe = 0;
reg_write_mem = 0;
rs = 5'b10101;
rt = 5'b10101;   
rd3 = 5'b10000;
rd4 = 5'b10100; 




end





endmodule
