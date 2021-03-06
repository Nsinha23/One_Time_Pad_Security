`timescale 1 ns/ 100 ps

module key_gen (input [31:0]seed, input clk,load,reset, output [31:0] Key);

prng RAND1(Key[31:24], seed[31:24], clk,load,reset);
prng RAND2(Key[23:16], seed[23:16], clk,load,reset);
prng RAND3(Key[15:8], seed[15:8], clk,load,reset);
prng RAND4(Key[7:0], seed[7:0], clk,load,reset);

endmodule



/*





module key_gen (input [31:0]seed, output reg [31:0] Key);
reg clk,load,reset;
reg [7:0] inp8; 
reg [7:0] outf;
integer i;

prng RAND1(outf, inp8, clk,load,reset);

assign {inp8}={seed[31:24]};
assign reset=1'b1;
assign #1 clk=1'b0;
assign #1 clk=1'b1;
assign reset=1'b0;
assign load=1'b1;
assign #1 clk=1'b0;
assign #1 clk=1'b1;
assign load=1'b0;
assign #1 clk=1'b0;
assign #1 clk=1'b1;

assign Key[31:24]=outf;

prng RAND2(outf, inp8, clk,load,reset);

assign {inp8}={seed[23:16]};
assign reset=1'b1;
assign #1 clk=1'b0;
assign #1 clk=1'b1;
assign reset=1'b0;
assign load=1'b1;
assign #1 clk=1'b0;
assign #1 clk=1'b1;
assign load=1'b0;
assign #1 clk=1'b0;
assign #1 clk=1'b1;

assign Key[23:16]=outf;

prng RAND3(outf, inp8, clk,load,reset);

assign {inp8}={seed[15:8]};
assign reset=1'b1;
assign #1 clk=1'b0;
assign #1 clk=1'b1;
assign reset=1'b0;
assign load=1'b1;
assign #1 clk=1'b0;
assign #1 clk=1'b1;
assign load=1'b0;
assign #1 clk=1'b0;
assign #1 clk=1'b1;

assign Key[15:8]=outf;

prng RAND4(outf, inp8, clk,load,reset);

assign {inp8}={seed[7:0]};
assign reset=1'b1;
assign #1 clk=1'b0;
assign #1 clk=1'b1;
assign reset=1'b0;
assign load=1'b1;
assign #1 clk=1'b0;
assign #1 clk=1'b1;
assign load=1'b0;
assign #1 clk=1'b0;
assign #1 clk=1'b1;

assign Key[7:0]=outf;


endmodule








*/
