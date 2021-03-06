
`timescale 1 ns/ 100 ps

module IO_Testbench;
integer keypad,keytemp,plain_text,cypher_text,error,error2,i,num_matches,t,char,indx;
reg[7:0]mem,r;//[0:255][89:0];
reg[639:0]err_str,err_str2;
reg eof,clk,reset,request;
wire linkSealed;
wire[31:0] plain_stream,cypher_,Decrypted;
reg [31:0]key,key_temp;



FIFO streamBits(mem, clk,reset, plain_stream,linkSealed);
brickwall forge_lock (plain_stream,key,1'b0,cypher_); 
brickwall break_lock (cypher_,key,1'b1,Decrypted); 

initial begin
plain_text=$fopen("text3.txt","r");
keypad=$fopen("keypad.txt","r");
cypher_text=$fopen("cypher.txt","w");
keytemp=$fopen("keytemp.txt","w");
error=$ferror(plain_text,err_str);
eof=$feof(plain_text);
error2=$ferror(keypad,err_str2);
eof=$feof(keypad);


#10 reset=1'b1;
#10 clk=1'b0;
#10 clk=1'b1;
#10 reset=1'b0;
i=0;


if(error2==0)begin
 num_matches=$fscanf(keypad,"%b\n",key);
 $display("Key used is: %b\n",key);
while(num_matches>0)
begin
	 $fwrite(keytemp,"%b\n",key_temp);
	 num_matches=$fscanf(keypad,"%b\n",key_temp);
	 indx=indx+1;
end
$fclose(keypad);
$fclose(keytemp);
end
else $display("Could not open file keypad.txt");


keypad=$fopen("keypad.txt","w");
keytemp=$fopen("keytemp.txt","r");
error2=$ferror(keytemp,err_str2);
eof=$feof(keytemp);
if(error2==0)begin
 num_matches=$fscanf(keytemp,"%b\n",key_temp);

while(num_matches>0)
begin
if (key_temp>0)begin
	 $fwrite(keypad,"%b\n",key_temp);
end
	 num_matches=$fscanf(keytemp,"%b\n",key_temp);
	 indx=indx+1;

end
$fclose(keypad);
$fclose(keytemp);
end

else 
begin 
$display("Could not open file keypad.txt");
end

if (key>0)begin
// ================================ ENCRYPT/DECRYPT ========================
if(error==0)begin
 num_matches=$fgetc(plain_text);
while(num_matches>0)
begin
 r=$ungetc(num_matches,plain_text);
	if(~linkSealed) begin
	 //$display("Got char [%0d] 0x%0b",i,mem);
	 //i=i+1;
	 mem=$fgetc(plain_text);
	 //$display("Got char [%0d] %c",i,mem);
	 end
	else 
	begin
	 $fwrite(cypher_text,"%b\n",cypher_);
	  i=i+1;
	 $display("Stream [%0d] %c %c %c %c",i,plain_stream[31:24],plain_stream[23:16],plain_stream[15:8],plain_stream[7:0]);
	 //$display(" Cypher [%0d] 0x%0b",i,cypher_);
	 //$display(" Opened [%0d] 0x%0b",i,Decrypted);
		//if (plain_stream==Decrypted)
		//$display(" Encrytpion OK! ");
		//else 
		//$display(" Problematic Encrytpion! ");
	 reset=1'b1;
	end
	#10 clk=~clk;
	#10 clk=~clk;
	reset=1'b0;
		 num_matches=$fgetc(plain_text);
end

while(((i-1)%4)!=0)begin
if (~linkSealed) begin

mem=8'b00100000;
end
else begin
	 $fwrite(cypher_text,"%b\n",cypher_);
	 $display("Stream [%0d] %c %c %c %c",i,plain_stream[31:24],plain_stream[23:16],plain_stream[15:8],plain_stream[7:0]);
	 i=i+1;
	 //$display("\n Stream [%0d] 0x%0b",i,plain_stream);
	 //$display(" Cypher [%0d] 0x%0b",i,cypher_);
	 //$display(" Opened [%0d] 0x%0b",i,Decrypted);
		if (plain_stream==Decrypted)
		$display(" Encrytpion kO! ");
		else 
		$display(" Problematic Encrytpion! ");
	 reset=1'b1;
	end

#10 clk=~clk;
#10 clk=~clk;
end

$display(" ** ENCRYPTION SUCCESSFUL! ** \n");
end
else
begin 
$display("Could not open file text3.txt");
end
$fclose(cypher_text);
// ================================ END/ENCRYTPYION ========================
end

else begin
	 // ================================ FUNCTION FAIL. KEYPAD EMPTY ============
	 $display(" ** Keypad Exhausted. ** \n");
	 $display(" ** ENCRYPTION ABORTED! ** \n");
end



end


endmodule


/*

while(((i-1)%4)!=0)begin
if (~linkSealed) begin
i=i+1;
mem=8'b00100000;
end
else begin
	 $fwrite(cypher_text,"%b\n",cypher_);
	 //$display("\n Stream [%0d] 0x%0b",i,plain_stream);
	 //$display(" Cypher [%0d] 0x%0b",i,cypher_);
	 //$display(" Opened [%0d] 0x%0b",i,Decrypted);
		if (plain_stream==Decrypted)
		$display(" Encrytpion O! ");
		else 
		$display(" Problematic Encrytpion! ");
	 reset=1'b1;
	end

#10 clk=~clk;
#10 clk=~clk;
end

*/ 
