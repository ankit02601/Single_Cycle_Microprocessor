
module Instr_Mem(A,rst,RD );
input [31:0] A;
input rst;
output [31:0]RD;

reg [31:0]Mem [1023:0];

assign RD=(rst==1'b0)?32'h00000000:Mem[A[31:2]];
initial begin
Mem[0]=32'hFFC4A303;
Mem[1]=32'h00832383;
//Mem[0]=32'h0064A423;
//Mem[1]=32'h00B62423;

//Mem[0]=32'h0062E234;
//Mem[0]=32'h0062E3B3;
//Mem[1]=32'h0062F433;
end 
/*initial begin
$readmemh("memfile.hex",Mem);
end*/
endmodule
