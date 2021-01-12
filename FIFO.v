

module FIFO(input [7:0]data_in, input clk,reset, output reg[31:0] data_out,output reg done);
reg [2:0] state;

always @(reset,posedge clk)
begin
if (reset) begin
state=3'b0;
data_out=32'bx;
done=1'b0;
end
else
begin
case (state)
2'b000: 
	begin
	data_out[31:24]=data_in;
	state=3'b001;
	done=1'b0;
	end
2'b001: 
	begin
	data_out[23:16]=data_in;
	state=3'b010;
	end
2'b010: 
	begin
	data_out[15:8]=data_in;
	state=3'b011;
	end
2'b011: 
	begin
	data_out[7:0]=data_in;
	state=3'b100;
	done=1'b1;
	end
2'b100: 
	begin
	state=3'b0;
	data_out=32'bx;
	done=1'b0;
	end
default :data_out=32'bx;
endcase
end
end



endmodule
