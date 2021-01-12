module io_test();

integer file_handle,error,indx,num_matches;
reg[63:0]mem[0:255][1:0];
reg[639:0]err_str;

initial begin
indx=0;
file_handle=$fopen("text3.txt","r");
error=$ferror(file_handle,err_str);

if(error==0)begin
 num_matches=$fscanf(file_handle,"%b\n",mem[indx]);
while(num_matches>0)
begin
	$display("data is: %b\n",mem[indx]);
	 indx=indx+1;
	 num_matches=$fscanf(file_handle,"%b\n",mem[indx]);
end
end
else 
begin 
$display("Could not open file text3.txt");
end
end

endmodule







/*
module io_test();

integer file_handle,error,indx,num_matches,memo;
reg[255:0]mem[0:255];
reg[639:0]err_str;

initial begin
indx=0;
file_handle=$fopen("text3.txt","r");
error=$ferror(file_handle,err_str);

if(error==0)begin
 num_matches=$fscanf(file_handle,"\oNNN",memo);
while(num_matches>0)
begin
	$display("data is: %s",memo);
	 indx=indx+1;
	 num_matches=$fscanf(file_handle,"\oNNN",memo);
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







module io_test(input clk, readval,input integer file_handle, error, output reg [63:0] line);

integer indx,num_matches;
reg[7:0]mem[0:255][7:0];


always @(posedge clk)
if(error==0)begin
if (readval)
begin
 num_matches=$fscanf(file_handle,"%b %b %b %b %b %b %b %b",mem[indx][0],mem[indx][1],mem[indx][2],mem[indx][3],mem[indx][4],mem[indx][5],mem[indx][6],mem[indx][7]);
while(num_matches>0)
begin
	$display("data is: %b %b %b %b %b %b %b %b",mem[indx][0],mem[indx][1],mem[indx][2],mem[indx][3],mem[indx][4],mem[indx][5],mem[indx][6],mem[indx][7]);
	 indx=indx+1;
	 num_matches=$fscanf(file_handle,"%b %b %b %b %b %b %b %b",mem[indx][0],mem[indx][1],mem[indx][2],mem[indx][3],mem[indx][4],mem[indx][5],mem[indx][6],mem[indx][7]);
	 line[63:0]={mem[indx][0],mem[indx][1],mem[indx][2],mem[indx][3],mem[indx][4],mem[indx][5],mem[indx][6],mem[indx][7]};

end
end
end
else 
begin 
$display("Could not open file text3.txt");
end


endmodule







*/























