class alu_agent extends uvm_agent;

  `uvm_component_utils(alu_agent)

  alu_driver     driver;
  alu_sequencer  sequencer;
  alu_a_monitor  monitor_a;
  alu_p_monitor  monitor_p;

  extern function new(string name = "alu_agent", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass : alu_agent

function alu_agent::new(string name = "alu_agent", uvm_component parent);
  super.new(name, parent);
endfunction

function void alu_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  driver     = alu_driver::type_id::create("driver", this);
  sequencer  = alu_sequencer::type_id::create("sequencer", this);
  monitor_a  = alu_a_monitor::type_id::create("monitor_a", this);
  monitor_p  = alu_p_monitor::type_id::create("monitor_p", this);
`uvm_info("BUILD", $sformatf("driver: %p", driver), UVM_MEDIUM)
`uvm_info("BUILD", $sformatf("sequencer: %p", sequencer), UVM_MEDIUM)

  if (driver == null) 
    `uvm_fatal("DRV_NULL", "driver is null in build_phase")
  if (sequencer == null)
    `uvm_fatal("SEQ_NULL", "sequencer is null in build_phase")
  if (monitor_a == null)
    `uvm_fatal("MONA_NULL", "monitor_a is null in build_phase")
  if (monitor_p == null)
    `uvm_fatal("MONP_NULL", "monitor_p is null in build_phase")
endfunction

function void alu_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if (driver == null || sequencer == null)
    `uvm_fatal("CONNECT_NULL", "Cannot connect null driver or sequencer");

  driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction
