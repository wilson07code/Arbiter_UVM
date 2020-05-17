//Arbiter DUT -Monitor
`ifndef dut_monitor//Preprocessor commands
`define dut_monitor
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "arbiter_seq_item.sv"
class dut_monitor extends uvm_monitor; //Monitor Class
`uvm_component_utils(dut_monitor) //Class Registration
//Arbiter DUT -Monitor
virtual dut_if dut_vi; //Handle to the interface
uvm_analysis_port#(arbiter_seq_item) aport; //Declare the analysis port.
function new(string name = "dut_monitor", uvm_component parent = null); //Constructor
super.new(name, parent);
endfunction: new
//Arbiter DUT -Monitor
//Propagate the interface
function void build_phase(uvm_phase phase);
aport= new("aport",this); //Create an instance of the port.
if (!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vi", dut_vi)) begin
`uvm_fatal("DUT/MON/NOVIF", "No virtual interface specified for this monitor instance")
end
endfunction:build_phase
//Arbiter DUT -Monitor
task run_phase(uvm_phase phase);
repeat(50)
begin
arbiter_seq_item tr; //Handle to the transaction
@(posedge dut_vi.clk);
begin
tr= arbiter_seq_item::type_id::create("tr", this); //Create the transaction.
//Give values from the interface to the transaction.
tr.req= dut_vi.req;
tr.grant= dut_vi.grant;
tr.ack= dut_vi.ack;
//Arbiter DUT -Monitor
// uvm_report_info("DUT monitor",tr.convert2string());
aport.write(tr); //Send the transaction through the analysis port and broadcast it.
end
end
endtask : run_phase
endclass: dut_monitor
`endif
