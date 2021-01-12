module prng (outf, inp8, clk,load,reset);
input clk, reset, load;
input [7:0] inp8; 	// input 8 bit
output [7:0] outf; 	// 8 bit outp
wire out1, out2,out3; 	// wire comming out of ff and shifter
reg [7:0] ff; 		// flip flop with 8 bits
always @(posedge clk or posedge reset)
begin 
	if (reset) begin
		ff <= 0;
		
	end
	else if (load) begin
		ff <= inp8;
	end
	else begin
		ff[6:0] = (ff[7:1]); // shifting the bits when load ==0 , shifts to right
		ff[7] = out3; // and 7th becomes the output from xor
	end
end
assign out1 = ff[1];
assign out2 = ff[0];
assign out3 = out1^out2;
assign 	outf = ff;
endmodule
