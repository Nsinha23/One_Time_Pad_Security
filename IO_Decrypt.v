

`timescale 1 ns/ 100 ps

module IO_Decrypt;
integer keypad,keytemp,plain_text,cypher_text,error,error2,i,num_matches,t,char,indx;
reg[7:0]r;//[0:255][89:0];
reg[639:0]err_str,err_str2;
reg eof,clk,reset,request;
wire linkSealed,done;
wire[31:0] plain_stream,cypher_,Decrypted;
reg [31:0]key,key_temp,Decrypted_;
wire [7:0] mem;

brickwall break_lock (Decrypted_,key,1'b1,Decrypted); 
FIFO2 streamBits(Decrypted, clk,reset, mem,linkSealed,done);


initial begin
plain_text=$fopen("cypher.txt","r");
keypad=$fopen("keypad2.txt","r");
cypher_text=$fopen("Decrypted.txt","w");
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


keypad=$fopen("keypad2.txt","w");
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
// ================================ DECRYPT ========================
if(error==0)begin
  num_matches=$fscanf(plain_text,"%b\n",Decrypted_);
#10 reset=1'b1;
#10 clk=1'b0;
#10 clk=1'b1;
#10 reset=1'b0;
i=0;
while(num_matches>0)
begin
	 if (done) begin
	 num_matches=$fscanf(plain_text,"%b\n",Decrypted_);
	 //i=i+1;
	 //$display(" Plain [%0d] 0x%0b",i,Decrypted);
	 reset=1'b1;

	 end
	////
	if (linkSealed)
	begin
	  $fwrite(cypher_text,"%c",mem);
	 //$ungetc(mem, cypher_text);
	 //$display("\n Stream [%0d] 0x%0b",i,plain_stream);
	 //$display(" Plain [%0d] 0x%0b",i,Decrypted);
	 $display(" Fo [%0d] %c",i,mem);
	 i=i+1;
		//if (plain_stream==Decrypted)
		//$display(" Encrytpion OK! ");
		//else 
		//$display(" Problematic Encrytpion! ");
	 //reset=1'b1;
	end
	#10 clk=~clk;
	#10 clk=~clk;
	reset=1'b0;
end


$display(" ** DECRYPTION SUCCESSFUL! ** \n");
end
else
begin 
$display("Could not open file text3.txt");
end
$fclose(cypher_text);
// ================================ END/DECRYTPYION ========================
end

else begin
	 // ================================ FUNCTION FAIL. KEYPAD EMPTY ============
	 $display(" ** Keypad Exhausted. ** \n");
	 $display(" ** DECRYPTION ABORTED! ** \n");
end



end


endmodule
















