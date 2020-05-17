//Ring Counter
module ring_cntr
(
input clk,rst,en,
output reg[3:0]q
);
always@(posedge clk)
begin
if(!rst)
q<=4'b0001;
else
if(en)
q<={q[2:0],q[3]};
end
endmodule
