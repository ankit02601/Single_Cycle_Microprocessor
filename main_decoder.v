
module main_decoder(op,zero,RegWrite,MemWrite,ImmSrc,ResultSrc,PCSrc,ALUSrc,ALUOp,Branch );
// input declarations

input zero;
input[6:0] op;
output RegWrite,MemWrite,ResultSrc,ALUSrc,PCSrc,Branch;
output[1:0] ImmSrc,ALUOp;

// interim Wire
//wire Branch;

assign RegWrite= ((op==7'b0000011)|(op==7'b0110011))?1'b1:1'b0;
assign MemWrite= (op==7'b0100011)?1'b1:1'b0;
assign ResultSrc=(op==7'b0000011)?1'b1:1'b0;
assign ALUSrc=((op==7'b0000011)|(7'b0100011))?1'b1:1'b0;
assign Branch=(op==7'b1100011)?1'b1:1'b0;
assign ImmSrc=(op==7'b0100011)?2'b01:(op==7'b1100011)?2'b10:2'b00;
assign ALUOp=(op==7'b0110011)?2'b10:(op==7'b1100011)?2'b01:2'b00;
assign PCSrc=zero & Branch;
endmodule
