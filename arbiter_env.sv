//Arbiter-Environment
//Environment class consists of the agent and the scoreboard and the connection between them.
`ifndef arbiter_env //Preprocessor commands
`define arbiter_env
import uvm_pkg::*; //Include the UVM BCL
`include "uvm_macros.svh" //Include the macros.
`include "dut_agent.sv"
`include "model_agent.sv"
`include "arbiter_scoreboard.sv"
//Arbiter-Environment
class arbiter_env extends uvm_env;
`uvm_component_utils (arbiter_env) //Class registration
dut_agent d_agent; //Create handle of the child components
model_agent m_agent;
arbiter_scoreboard a_scoreboard;
//Arbiter-Environment
function new(string name = "arbiter_env", uvm_component parent = null); //Construstor
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
d_agent = dut_agent::type_id::create("d_agent", this); //Create the child components
m_agent = model_agent::type_id::create("m_agent", this);
a_scoreboard = arbiter_scoreboard::type_id::create("a_scoreboard", this);
endfunction:build_phase
//Arbiter-Environment
function void connect_phase (uvm_phase phase);
d_agent.aport.connect (a_scoreboard.dut_export); //Connect one port of the scoreboard to the DUT agent port.
m_agent.aport.connect (a_scoreboard.model_export); //Connect the other port of the scoreboard to the MODEL agent port.
endfunction:connect_phase
endclass:arbiter_env
`endif
