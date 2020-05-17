
// Arbiter DUT
module arbiter_dut
(
input clk,rst,ack,
input[3:0] req,
output [3:0]grant
);
wire [3:0]y1,y2,y3,y4;
wire [3:0]en;

//Priority Logic
priority_logic p1(.a0(req[0]),.a1(req[1]),.a2(req[2]),.a3(req[3]),.en(en[0]),.y(y1));
priority_logic p2(.a0(req[1]),.a1(req[2]),.a2(req[3]),.a3(req[0]),.en(en[1]),.y(y2));
priority_logic p3(.a0(req[2]),.a1(req[3]),.a2(req[0]),.a3(req[1]),.en(en[2]),.y(y3));
priority_logic p4(.a0(req[3]),.a1(req[0]),.a2(req[1]),.a3(req[2]),.en(en[3]),.y(y4));

//Ring Counter
ring_cntr c1(.clk(clk),.rst(rst),.en(ack),.q(en));
assign grant[0]=y1[0]|y2[3]|y3[2]|y4[1];
assign grant[1]=y1[1]|y2[0]|y3[3]|y4[2];
assign grant[2]=y1[2]|y2[1]|y3[0]|y4[3];
assign grant[3]=y1[3]|y2[2]|y3[1]|y4[0];

endmodule
