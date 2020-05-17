//Arbiter Sequence Item
`ifndef arbiter_seq_item //Preprocessor commands
`define arbiter_seq_item
import uvm_pkg::*;
`include "uvm_macros.svh"
class arbiter_seq_item extends uvm_sequence_item;
`uvm_object_utils(arbiter_seq_item) //Class registration using object_utils.
rand logic [3:0]req;
logic ack;
logic [3:0]grant;
//Arbiter Sequence Item
function new(string name = "arbiter_seq_item"); //Constructor. Transaction is not a component, hence, has no parent.
super.new(name);
endfunction : new
function string convert2string(); //to print debug messages or contents of a particular transaction
return $sformatf ("%s\nREQ=%b ACK=%b GRANT=%b", super.convert2string(),req,ack,grant);
endfunction: convert2string
endclass: arbiter_seq_item
`endif
