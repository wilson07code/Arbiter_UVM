//Arbiter Sequence
`ifndef arbiter_seq //Preprocessor commands.
`define arbiter_seq
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "arbiter_seq_item.sv"
`include "dut_config.sv"
`include "model_config.sv"
class arbiter_seq extends uvm_sequence #(arbiter_seq_item); //Sequence class parameterized by the type of seq_item
`uvm_object_utils(arbiter_seq) //Register the class using object_utils
//Arbiter Sequence
arbiter_seq_item tr; //Handle to the seq_item
dut_config d_cfg;
model_config m_cfg;
int limit = 50;
function new(string name = "arbiter_seq"); //Constructor
super.new(name);
endfunction
task body;
int count;
tr= arbiter_seq_item::type_id::create("tr"); //Create a seq_item
//Arbiter Sequence
//Propagate the interface.
if(!uvm_config_db#(dut_config)::get(null,get_full_name(),"config",d_cfg))begin
`uvm_error("body dut","Unable to access agent configuration object in sequence")
end
if(!uvm_config_db#(model_config)::get(null,get_full_name(),"config",m_cfg))begin
`uvm_error("body model","Unableto access agent configuration object in sequence")
end
//Arbiter Sequence
repeat(limit)
begin
start_item(tr); //Request next item from the sequencer
if(!tr.randomize()) begin
`uvm_error("body", "Randomization of req failed")
end
finish_item(tr); //seq_item given to driver
end
endtask:body
endclass:arbiter_seq
`endif
