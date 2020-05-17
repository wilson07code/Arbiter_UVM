//Arbiter DUT-Interface

interface dut_if();

	logic clk;
	logic rst;
	logic [3:0]req;
	logic ack;
	logic [3:0]grant;

endinterface
