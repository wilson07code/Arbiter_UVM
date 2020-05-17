`include "arbiter_dut.sv"
`include "priority_logic.sv"
`include "ring_cntr.sv"
`include "arbiter_model.sv"
`include "dut_if.sv"
`include "model_if.sv"
`include "dut_config.sv"
`include "model_config.sv"
`include "arbiter_seq_item.sv"
`include "arbiter_seq.sv"
`include "dut_monitor.sv"
`include "model_monitor.sv"
`include "dut_agent.sv"
`include "model_agent.sv"
`include "arbiter_scoreboard.sv"
`include "arbiter_env.sv"

//Arbiter-Top
module arbiter_top; //Top level module
import uvm_pkg::*; //Include the UVM BCL
`include "arbiter_test.sv" //Include the test or test library.
dut_if dut_vi(); //Instantiate the DUT interface
model_if model_vi(); //Instantiate the model interface
//Arbiter-Top
arbiter_dut DUT(.clk(dut_vi.clk),.rst(dut_vi.rst),.req(dut_vi.req),.grant(dut_vi.grant),.ack(dut_vi.ack)); //Instantiate the DUT
arbiter_model MODEL(.clk(model_vi.clk),.rst(model_vi.rst),.req(model_vi.req),.grant(model_vi.grant),.ack(model_vi.ack)); //Instantiate the MODEL
initial
begin
dut_vi.clk=1'b0;
model_vi.clk=1'b0;
end
//Arbiter-Top
always
begin
#10
fork
dut_vi.clk=~dut_vi.clk;
model_vi.clk=~model_vi.clk;
join
end
//Arbiter-Top
initial
begin
fork
dut_vi.rst=1'b0;
model_vi.rst=1'b0;
join
#20;
fork
dut_vi.rst=1'b1;
model_vi.rst=1'b1;
join
end
//Arbiter-Top
initial begin
uvm_config_db#(virtual dut_if)::set(uvm_root::get(), "*", "dut_vi", dut_vi); //Set the interface.uvm_rootclass serves as the implicit top-level and phase controller for all UVM components.
uvm_config_db#(virtual model_if)::set(uvm_root::get(), "*", "model_vi", model_vi);
run_test("arbiter_test"); //Run the test named arbiter_test.
end
endmodule
