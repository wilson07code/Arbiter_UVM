//priority Logic
module priority_logic
(
input en,
input a3,a2,a1,a0,
output reg[3:0]y
);

//Priority Logic
always@(en,a3,a2,a1,a0)
begin
if(!en)
y=4'b0000;
else
begin
if(a0)
y=4'b0001;
else if(a1)
y=4'b0010;
else if(a2)
y=4'b0100;
else if(a3)
y=4'b1000;
else
y=4'b0000;
end
end
endmodule
