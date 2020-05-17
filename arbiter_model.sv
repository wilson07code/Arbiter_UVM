//Arbiter-Model

`timescale 1ns / 1ps
module arbiter_model(
input rst,input clk,input ack,
input[3:0] req,
output reg[3:0]grant
);
//Arbiter-Model
reg [3:0]q=4'b0001;
always@(rst)
if(!rst)
grant=0;
always @(*)
begin
if(rst)
if(req==4'bxxxx)
grant=4'bxxxx;
else
begin
//Arbiter-Model
case(q)
4'b0001: begin
if(req[0])
grant=4'b0001;
else if (req[1])
grant=4'b0010;
else if(req[2])
grant=4'b0100;
else if(req[3])
grant=4'b1000;
else
grant=4'b0000;
end
//Arbiter-Model
4'b0010:begin
if(req[1])
grant=4'b0010;
else if (req[2])
grant=4'b0100;
else if(req[3])
grant=4'b1000;
else if(req[0])
grant=4'b0001;
else
grant=4'b0000;
end
//Arbiter-Model
4'b0100:begin
if(req[2])
grant=4'b0100;
else if (req[3])
grant=4'b1000;
else if(req[0])
grant=4'b0001;
else if(req[1])
grant=4'b0010;
else
grant=4'b0000;
end
//Arbiter-Model
4'b1000:begin
if(req[3])
grant=4'b1000;
else if (req[0])
grant=4'b0001;
else if(req[1])
grant=4'b0010;
else if(req[2])
grant=4'b0100;
else
grant=4'b0000;
end
endcase
end
else
grant=0;
end
//Arbiter-Model
always@(posedge clk)
begin
if(!rst)
q<=4'b0001;
else
if(ack)
q<={q[2:0],q[3]};
end
endmodule
