
module Single_Cycle_Top_tb();
reg clk=1'b0,rst;

Single_Cycle_Top Single_Cycle_Top(
                                  .clk(clk),
                                  .rst(rst)    
);
 always #50 clk=~clk;
 initial begin
 rst=1'b0;
 #100;
 
 rst=1'b1;
 #300;
 $finish;
 end
endmodule
