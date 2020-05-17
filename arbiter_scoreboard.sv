//Arbiter ?ScoreBoard
`ifndef arbiter_scoreboard//Preprocessor commands
`define arbiter_scoreboard
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "arbiter_seq_item.sv"
//Arbiter ?ScoreBoard
class arbiter_scoreboard extends uvm_scoreboard;
`uvm_component_utils(arbiter_scoreboard) //Class registration.
uvm_analysis_export#(arbiter_seq_item) dut_export; //uvm_analysis_exportexports a lower level uvm_analysis_impto its parent.
uvm_analysis_export#(arbiter_seq_item) model_export; //uvm_analysis_exportexports a lower level uvm_analysis_impto its parent.
//Arbiter ?ScoreBoard
uvm_tlm_analysis_fifo #(arbiter_seq_item) dut_fifo; //this class provides storage of transaction between 2 independently running processes.
uvm_tlm_analysis_fifo #(arbiter_seq_item) model_fifo;//seq_itemsare put into the FIFO via put_export. seq_itemsare fetched from the FIFO in the order they arrived via get_export.
//Arbiter ?ScoreBoard
function new(string name = "arbiter_scoreboard",uvm_component parent = null);
super.new(name,parent);
dut_export= new("dut_export", this); //Create the instance of the ports.
model_export= new("model_export", this);
dut_fifo= new("dut_fifo", this);
model_fifo= new("model_fifo", this);
endfunction : new
//Arbiter ?ScoreBoard
function void connect_phase(uvm_phase phase);
dut_export.connect(dut_fifo.analysis_export); //Connect the Port of the FIFO to the port of the scoreboard.
model_export.connect(model_fifo.analysis_export);
endfunction
task run_phase(uvm_phase phase);
int comparator_matches,comparator_mismatches;
//Arbiter ?ScoreBoard
arbiter_seq_item dut_tr, model_tr; //Create handles of the seq_item.
repeat(50) begin
fork
dut_fifo.get(dut_tr); //get seq_itemfrom the FIFO.
model_fifo.get(model_tr);
join
//Arbiter ?ScoreBoard
//Compare the seq_items
//if(dut_tr.compare(model_tr))
if((dut_tr.req===model_tr.req)&(dut_tr.ack===model_tr.ack)&(dut_tr.grant===model_tr.grant))
begin
// uvm_report_info("Scoreboard",$psprintf("Comparator match"),UVM_LOW);
comparator_matches++;
end
else
begin
// uvm_report_info("Scoreboard",$psprintf("Comparator mismatch"),UVM_LOW);
comparator_mismatches++;
//Arbiter ?ScoreBoard
`uvm_info("Failed Case",$sformatf("\n#########################################################################################\nFailedCase No=%d\nDUTReq=%b\nModelReq=%b\nDUTGrant=%b\nModelGrant=%b\nDUTAck=%b\nModelAck=%b\n#########################################################################################",comparator_mismatches,dut_tr.req,model_tr.req,dut_tr.grant,model_tr.grant,dut_tr.ack,model_tr.ack),UVM_LOW)
end
end
//Arbiter ?ScoreBoard
//Display the number of matches and mismatches.
`uvm_info("Comparator Mismatches",$sformatf("Mismatches = %0d",comparator_mismatches),UVM_LOW)
`uvm_info("Comparator Matches",$sformatf("Matches = %0d",comparator_matches),UVM_LOW)
endtask
endclass:arbiter_scoreboard
`endif
