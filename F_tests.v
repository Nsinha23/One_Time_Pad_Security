module F_tests();

initial begin
$display("245 / 3: %d",245/3);
$display("3 pcnt 4: %d",3%4);
$display("16 pcnt 4: %d",16%4);
$display("245093 / 5: %d",245093/5);
$display("2/5: %d",2/5);



#10 $stop;

end

endmodule





// WORKING BLOCK
/*


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
	 //$display("Got char [%0d] 0x%0b",i,mem);
	 i=i+1;
	 mem=$fgetc(plain_text);
	 num_matches=$fgetc(plain_text);
	
	if (linkSealed)
	begin
	 $fwrite(cypher_text,"%b\n",cypher_);
	 //$display("\n Stream [%0d] 0x%0b",i,plain_stream);
	 //$display(" Cypher [%0d] 0x%0b",i,cypher_);
	 //$display(" Opened [%0d] 0x%0b",i,Decrypted);
		if (plain_stream==Decrypted)
		$display(" Encrytpion OK! ");
		else 
		$display(" Problematic Encrytpion! ");
	 reset=1'b1;
	end
	#10 clk=~clk;
	#10 clk=~clk;
	reset=1'b0;
end
while(((i-1)%4)!=0)begin
i=i+1;
mem=8'b00100000;

if (linkSealed)
	begin
	 $fwrite(cypher_text,"%b\n",cypher_);
	 //$display("\n Stream [%0d] 0x%0b",i,plain_stream);
	 //$display(" Cypher [%0d] 0x%0b",i,cypher_);
	 //$display(" Opened [%0d] 0x%0b",i,Decrypted);
		if (plain_stream==Decrypted)
		$display(" Encrytpion OK! ");
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

`timescale 1 ns/ 100 ps

module IO_Testbench;
integer file_handle,error,i,num_matches;
reg[7:0]mem,r;//[0:255][89:0];
reg[639:0]err_str;
reg eof;

initial begin
i=0;
file_handle=$fopen("text3.txt","r");
error=$ferror(file_handle,err_str);
eof=$feof(file_handle);
if(error==0)begin
 num_matches=$fgetc(file_handle);
while(num_matches>0)
begin
	 r=$ungetc(num_matches,file_handle);
	 i=i+1;
	 mem=$fgetc(file_handle);
	 $display("Got char [%0d] 0x%0b",i,mem);
	 num_matches=$fgetc(file_handle);
end
end
else 
begin 
$display("Could not open file text3.txt");
end
end


endmodule



module io_test();

integer file_handle,error,indx,num_matches;
reg[7:0]mem[0:255][89:0];
reg[639:0]err_str;

initial begin
indx=0;
file_handle=$fopen("text3.txt","r");
error=$ferror(file_handle,err_str);

if(error==0)begin
 num_matches=$fscanf(file_handle,"%b",{mem[indx][0:89]});
while(num_matches>0)
begin
	$display("data is: %h %h",mem[indx][0],mem[indx][1]);
	 indx=indx+1;
	 num_matches=$fscanf(file_handle,"%h %h",mem[indx][0],mem[indx][1]);
end
end
else 
begin 
$display("Could not open file text3.txt");
end
end

endmodule






module testit;
reg [3:0] A,B;
wire [7:0] C;
reg [639:0] err_str_a,err_str_b;
reg clk;
integer file_a,file_b,error_a,error_b,i,results;

mult MUT(A,B,clk,C);

initial 
begin
A=4'b0;
B=4'b0;
clk=0;
file_a= $fopen("inputA.txt","r");
file_b= $fopen("inputB.txt","r");
results= $fopen("Results.txt","w");
error_a=$ferror(file_a,err_str_a);
error_b=$ferror(file_b,err_str_b);

if ((error_a==0) && (error_b==0))
begin

for (i=0;i<10;i=i+1)
begin

$fscanf(file_a,"%h\n",A);
$fscanf(file_b,"%h\n",B);
#10 clk=~clk;
#10 clk=~clk;
$fwrite(results,"%b\n",line);
$display("Parameter, A, B: ",A," ",B, "\t Multiplication Result: %d", C);
end

end
else if (error_a!=0)
$display("Unable to open inputA.txt");
else
$display("Unable to open inputB.txt");
end

endmodule


module IO_Testbench;
integer file_handle, error, results;
reg clk, readval;
wire [63:0] line; 
reg[639:0]err_str;

io_test READIT(clk, readval, file_handle, error, line);
initial 
begin
 file_handle=$fopen("text3.txt","r");
 error=$ferror(file_handle,err_str);
 results= $fopen("Results.txt","w");
 readval=1'b1;
end

always begin
#10 clk=~clk;
#10 clk=~clk;
$fwrite(results,"%b\n",line);
$display("Parameter, line: %b",line);
end
endmodule






//////////////// W2



`timescale 1 ns/ 100 ps

module IO_Testbench;
integer keypad,keytemp,plain_text,cypher_text,cypher_text2,error,error2,i,num_matches,t,char,indx;
integer plain_text2;
reg[7:0]mem,r;//[0:255][89:0];
reg[639:0]err_str,err_str2;
reg eof,clk,clk2,reset,reset2,request;
wire linkSealed,linkfreed,done;
wire[31:0] plain_stream,cypher_,cypher_read,Decrypted;
reg [31:0]key,key_temp;
wire[7:0]fo;


FIFO streamBits(mem, clk,reset, plain_stream,linkSealed);
brickwall forge_lock (plain_stream,key,1'b0,cypher_); 
brickwall break_lock (cypher_read,key,1'b1,Decrypted); 
FIFO2 flushBits(Decrypted, clk2,reset2, fo,linkfreed,done);

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
// ================================ ENCRYPT ===============================
if(error==0)begin
 num_matches=$fgetc(plain_text);
while(num_matches>0)
begin
	 r=$ungetc(num_matches,plain_text);
	 //$display("Got char [%0d] 0x%0b",i,mem);
	 i=i+1;
	 mem=$fgetc(plain_text);
	 num_matches=$fgetc(plain_text);
	
	if (linkSealed)
	begin
	 $fwrite(cypher_text,"%b\n",cypher_);
	 //$display("\n Stream [%0d] 0x%0b",i,plain_stream);
	 //$display(" Cypher [%0d] 0x%0b",i,cypher_);
	 //$display(" Opened [%0d] 0x%0b",i,Decrypted);
		if (plain_stream==Decrypted)
		$display(" Encrytpion OK! ");
		else 
		$display(" Problematic Encrytpion! ");
	 reset=1'b1;
	end
	#10 clk=~clk;
	#10 clk=~clk;
	reset=1'b0;
end
while(((i-1)%4)!=0)begin
i=i+1;
mem=8'b00100000;

if (linkSealed)
	begin
	 $fwrite(cypher_text,"%b\n",cypher_);
	 //$display("\n Stream [%0d] 0x%0b",i,plain_stream);
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
end

$display(" ** ENCRYPTION SUCCESSFUL! ** \n");
end
else
begin 
$display("Could not open file text3.txt");
end
$fclose(cypher_text);
$fclose(plain_text);
$fclose(keypad);
$fclose(keytemp);
// ================================ END/ENCRYTPYION ========================
end

else begin
// ========================= FUNCTION FAIL. IF KEYPAD EMPTY ==================
	 $display(" ** Keypad Exhausted. ** \n");
	 $display(" ** ENCRYPTION ABORTED! ** \n");
end



// ===============================  DECRYPTION =============================
cypher_text2=$fopen("cypher.txt","r");
error=$ferror(cypher_text2,err_str);
eof=$feof(cypher_text2);

plain_text2=$fopen("Decrypted.txt","w");

keypad=$fopen("keypad2.txt","r");
keytemp=$fopen("keytemp.txt","w");
error=$ferror(plain_text2,err_str);
eof=$feof(plain_text2);
error2=$ferror(keypad,err_str2);
eof=$feof(keypad);



/*
if(error==0)begin
 num_matches=$fscanf(cypher_text,"%b\n",cypher_read);
 $display("Key used is: %b\n",key);
while(num_matches>0)
begin
	 $fwrite(plain_text,"%b\n",Decrypted);
	 num_matches=$fscanf(cypher_text,"%b\n",cypher_read);
	 indx=indx+1;
end
$fclose(cypher_text);
$fclose(plain_text);
end
else $display("Could not open file cypher.txt");
*/





#10 reset2=1'b1;
#10 clk2=1'b0;
#10 clk2=1'b1;
#10 reset2=1'b0;
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
// ================================ DECRYPT ===============================
if(error==0)begin
 num_matches=$fscanf(cypher_text2,"%b\n",cypher_read);
while(num_matches>0)
begin
	//if (done) begin
	 num_matches=$fscanf(cypher_text2,"%b\n",cypher_read);
	 indx=indx+1;
	 reset2=1'b1;
	//end
	////
	if (linkfreed)
	begin
	 $fwrite(plain_text2,"%b\n",fo);
	 //$display("\n Stream [%0d] 0x%0b",i,plain_stream);
	 $display(" Plain [%0d] 0x%0b",i,cypher_read);
	 $display(" Fo [%0d] 0x%0b",i,fo);
		//if (plain_stream==Decrypted)
		//$display(" Encrytpion OK! ");
		//else 
		//$display(" Problematic Encrytpion! ");
	 //reset=1'b1;
	end
	#10 clk2=~clk2;
	#10 clk2=~clk2;
	reset2=1'b0;
end


$display(" ** DECRYPTION SUCCESSFUL! ** \n");
end
else
begin 
$display("Could not open file text3.txt");
end
$fclose(cypher_text2);
$fclose(plain_text2);
// ================================ END/ENCRYTPYION ========================
end

else begin
// ========================= FUNCTION FAIL. IF KEYPAD EMPTY ==================
	 $display(" ** Keypad Exhausted. ** \n");
	 $display(" ** DECRYPTION ABORTED! ** \n");
end


end


endmodule





/*

`timescale 1 ns/ 100 ps

module IO_Testbench;
integer file_handle,error,i,num_matches;
reg[7:0]mem,r;//[0:255][89:0];
reg[639:0]err_str;
reg eof;

initial begin
i=0;
file_handle=$fopen("text3.txt","r");
error=$ferror(file_handle,err_str);
eof=$feof(file_handle);
if(error==0)begin
 num_matches=$fgetc(file_handle);
while(num_matches>0)
begin
	 r=$ungetc(num_matches,file_handle);
	 i=i+1;
	 mem=$fgetc(file_handle);
	 $display("Got char [%0d] 0x%0b",i,mem);
	 num_matches=$fgetc(file_handle);
end
end
else 
begin 
$display("Could not open file text3.txt");
end
end


endmodule



module io_test();

integer file_handle,error,indx,num_matches;
reg[7:0]mem[0:255][89:0];
reg[639:0]err_str;

initial begin
indx=0;
file_handle=$fopen("text3.txt","r");
error=$ferror(file_handle,err_str);

if(error==0)begin
 num_matches=$fscanf(file_handle,"%b",{mem[indx][0:89]});
while(num_matches>0)
begin
	$display("data is: %h %h",mem[indx][0],mem[indx][1]);
	 indx=indx+1;
	 num_matches=$fscanf(file_handle,"%h %h",mem[indx][0],mem[indx][1]);
end
end
else 
begin 
$display("Could not open file text3.txt");
end
end

endmodule






module testit;
reg [3:0] A,B;
wire [7:0] C;
reg [639:0] err_str_a,err_str_b;
reg clk;
integer file_a,file_b,error_a,error_b,i,results;

mult MUT(A,B,clk,C);

initial 
begin
A=4'b0;
B=4'b0;
clk=0;
file_a= $fopen("inputA.txt","r");
file_b= $fopen("inputB.txt","r");
results= $fopen("Results.txt","w");
error_a=$ferror(file_a,err_str_a);
error_b=$ferror(file_b,err_str_b);

if ((error_a==0) && (error_b==0))
begin

for (i=0;i<10;i=i+1)
begin

$fscanf(file_a,"%h\n",A);
$fscanf(file_b,"%h\n",B);
#10 clk=~clk;
#10 clk=~clk;
$fwrite(results,"%b\n",line);
$display("Parameter, A, B: ",A," ",B, "\t Multiplication Result: %d", C);
end

end
else if (error_a!=0)
$display("Unable to open inputA.txt");
else
$display("Unable to open inputB.txt");
end

endmodule


module IO_Testbench;
integer file_handle, error, results;
reg clk, readval;
wire [63:0] line; 
reg[639:0]err_str;

io_test READIT(clk, readval, file_handle, error, line);
initial 
begin
 file_handle=$fopen("text3.txt","r");
 error=$ferror(file_handle,err_str);
 results= $fopen("Results.txt","w");
 readval=1'b1;
end

always begin
#10 clk=~clk;
#10 clk=~clk;
$fwrite(results,"%b\n",line);
$display("Parameter, line: %b",line);
end
endmodule
*/



















*/



















