
`timescale 1 ns/ 100 ps

module Generate_Pad;
reg [31:0]seed;
wire [31:0]Key;
reg eof,clk,load,reset;
reg[639:0]err_str;

integer keypad,keypad2,i,error,error2,num_matches,char,j;

key_gen forge_key(seed,clk,load,reset,Key);

initial begin
keypad=$fopen("keypad.txt","w");
keypad2=$fopen("keypad2.txt","w");
error=$ferror(keypad,err_str);
eof=$feof(keypad);
seed=32'b00001111_01010011_11001100_10010010;
#10 clk=0;
#10 load=1;
#10 clk=~clk;
#10 clk=~clk;
#10 load=0;
#10 clk=~clk;
#10 clk=~clk;

#1 j=0;

while (j<8)
begin
for (i=0;i<8;i=i+1)
begin
#10 clk=~clk;
#10 clk=~clk;
end
$display("Seed 0x%0b",seed);
$display("Key  0x%0b",Key);
$display(" ");

if(error==0)begin
	 $fwrite(keypad,"%b\n",Key);
	 $fwrite(keypad2,"%b\n",Key);
end
j=j+1;
end
$stop;
end








endmodule

