class alu_sequencer extends uvm_sequencer #(alu_sequence_item);
               
               `uvm_component_utils(alu_sequencer)

               extern function new(string name = "alu_sequencer", uvm_component parent = null);
               
endclass : alu_sequencer

function alu_sequencer::new(string name = "alu_sequencer", uvm_component parent = null);
               super.new(name, parent);
endfunction : new