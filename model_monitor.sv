//Model Monitor
`ifndef model_monitor//Preprocessor commands
`define model_monitor
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "arbiter_seq_item.sv"
class model_monitor extends uvm_monitor; //Monitor Class
`uvm_component_utils(model_monitor) //Class Registration
//Model Monitor
virtual model_if model_vi; //Handle to the interface
uvm_analysis_port#(arbiter_seq_item) aport; //Declare the analysis port.
function new(string name = "model_monitor", uvm_component parent = null); //Constructor
super.new(name, parent);
endfunction: new
//Model Monitor
//Propagate the interface
function void build_phase(uvm_phase phase);
aport= new("aport",this); //Create an instance of the port.
if (!uvm_config_db#(virtual model_if)::get(this, "", "model_vi", model_vi)) begin
`uvm_fatal("model/MON/NOVIF", "No virtual interface specified for this monitor instance")
end
endfunction:build_phase
//Model Monitor
task run_phase(uvm_phase phase);
repeat(50)
begin
arbiter_seq_item tr; //Handle to the transaction
@(posedge model_vi.clk);
begin
tr= arbiter_seq_item::type_id::create("tr", this); //Create the transaction.
//Give values from the interface to the transaction.
tr.req= model_vi.req;
tr.grant= model_vi.grant;
tr.ack= model_vi.ack;
//Model Monitor
// uvm_report_info("model monitor",tr.convert2string());
aport.write(tr); //Send the transaction through the analysis port and broadcast it.
end
end
endtask : run_phase
endclass: model_monitor
`endif
