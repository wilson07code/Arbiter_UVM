`ifndef shared_driver //Preprocessor commands.
`define shared_driver
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "arbiter_seq_item.sv"
//Driver class parameterised by the type of transaction. The driver is shared between the MODEL &amp; DUT
class shared_driver extends uvm_driver #(arbiter_seq_item);
virtual dut_if dut_vi; //Interface handles
virtual model_if model_vi;
arbiter_seq_item tr; //Handle to the transaction.

`uvm_component_utils(shared_driver) //Class Registration
function new(string name = "shared_driver", uvm_component parent = null); //Constructor
super.new(name,parent);
endfunction
//Propagate the interface
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual dut_if)::get(this,"","dut_vi",dut_vi))
`uvm_fatal("NOVIF",{"virtual interface must be set for:",get_full_name(),".vif"});
if(!uvm_config_db#(virtual model_if)::get(this,"","model_vi",model_vi))
`uvm_fatal("NOVIF",{"virtual interface must be set for:",get_full_name(),".vif"});

endfunction: build_phase

task run_phase(uvm_phase phase);
int count;
phase.raise_objection(this); //Raise objection.
repeat(50) begin
@(posedge dut_vi.clk)
begin
seq_item_port.get_next_item(tr); //Request for a sequence.
//Items given from the transaction to the virtual interface i.e wiggling the pins of the DUT
dut_vi.req = tr.req;
model_vi.req = tr.req;

if(count<4)
count++;
else
count=0;

if(count==3)
tr.ack=1;
else
tr.ack=0;

dut_vi.ack = tr.ack;
model_vi.ack = tr.ack;

seq_item_port.item_done(); //Indicates to the sequencer that the request is complete.
// uvm_report_info(&quot;driver&quot;,tr.convert2string());
end
end
phase.drop_objection(this); //Drop objection.
endtask : run_phase
endclass:shared_driver
`endif
