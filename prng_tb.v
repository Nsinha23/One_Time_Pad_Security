module testbenchprng;
reg clk, reset , load; //input
reg [7:0] inp8;	// input 8 bit seed
wire [7:0] outf; // output from xor 

prng up3(outf, inp8, clk,load,reset); // instantiated
initial begin 
clk =0;
reset =0;
load =0;
inp8 =0;
end 
always #50 clk = ~clk;
 
initial begin
reset = 1;
#100;
reset = 0;
load = 1;
inp8 = 8'd22; // decimal 22
#200;
load = 0;

end

endmodule
