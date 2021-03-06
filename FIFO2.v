

module FIFO2(input [31:0]data_in, input clk,reset, output reg[7:0] data_out,output reg cmp,done);
reg [2:0] state;

always @(reset,posedge clk)
begin
if (reset) begin
state=3'b0;
data_out=8'bx;
done=1'b0;
cmp=1'b0;
end
else
begin
case (state)
2'b000: 
	begin
	data_out=data_in[31:24];
	state=3'b001;
	done=1'b0;
	cmp=1'b1;
	end
2'b001: 
	begin
	data_out=data_in[23:16];
	state=3'b010;
	cmp=1'b1;
	end
2'b010: 
	begin
	data_out=data_in[15:8];
	state=3'b011;
	cmp=1'b1;
	end
2'b011: 
	begin
	data_out=data_in[7:0];
	state=3'b100;
	cmp=1'b1;
	done=1'b1;
	end
2'b100: 
	begin
	state=3'b0;
	data_out=8'bx;
	cmp=1'b0;
	done=1'b0;
	end
default :data_out=8'bx;
endcase
end
end



endmodule

