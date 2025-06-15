class alu_p_monitor extends uvm_monitor;
                  
                 `uvm_component_utils(alu_p_monitor)

                 virtual alu_if vif;
                 alu_sequence_item req;

                 uvm_blocking_put_port #(alu_sequence_item) put_port;

                 extern function new(string name = "alu_p_monitor", uvm_component parent = null);
                 extern function void build_phase(uvm_phase phase);
                 extern function void connect_phase(uvm_phase phase);
                 extern task run_phase(uvm_phase phase);

endclass : alu_p_monitor

function alu_p_monitor::new(string name = "alu_p_monitor", uvm_component parent = null);
                 
                 super.new(name, parent);
                
endfunction : new

function void alu_p_monitor::build_phase(uvm_phase phase);

                 super.build_phase(phase);                 
                 req = alu_sequence_item::type_id::create("req", this);
                 put_port = new("put_port", this);
endfunction : build_phase

function void alu_p_monitor::connect_phase(uvm_phase phase);
                 super.connect_phase(phase);
                 if(!(uvm_config_db #(virtual alu_if)::get(null, "*", "vif", vif))) 
                           
                     `uvm_error("MON", "uvm_config_db::get - Failed at interface")           

endfunction : connect_phase

task alu_p_monitor::run_phase(uvm_phase phase);
               
               forever begin
                  
                     @(posedge vif.clk);
                        
                        req.a = vif.a;
                        req.b = vif.b;
                        req.op_code = operation'(vif.op_code);
                        req.result = vif.result;
                        put_port.put(req);

                 end
endtask : run_phase


