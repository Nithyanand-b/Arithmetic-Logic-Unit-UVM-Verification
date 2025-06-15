class alu_a_monitor extends uvm_monitor;
                  
                 `uvm_component_utils(alu_a_monitor)

                 virtual alu_if vif;
                 alu_sequence_item req;

                 uvm_blocking_put_port #(alu_sequence_item) put_port;

                 extern function new(string name = "alu_a_monitor", uvm_component parent = null);
                 extern function void build_phase(uvm_phase phase);
                 extern function void connect_phase(uvm_phase phase);
                 extern task run_phase(uvm_phase phase);

endclass : alu_a_monitor

function alu_a_monitor::new(string name = "alu_a_monitor", uvm_component parent = null);
                 
                 super.new(name, parent);
                
endfunction : new

function void alu_a_monitor::build_phase(uvm_phase phase);

                 super.build_phase(phase);                 
                 req = alu_sequence_item::type_id::create("req", this);
                 put_port = new("put_port", this);
endfunction : build_phase

function void alu_a_monitor::connect_phase(uvm_phase phase);
                 super.connect_phase(phase);
                 if(!(uvm_config_db #(virtual alu_if)::get(null, "*", "vif", vif))) 
                           
                     `uvm_error("MON", "uvm_config_db::get - Failed at interface")           

endfunction : connect_phase

task alu_a_monitor::run_phase(uvm_phase phase);
               
                 forever begin
                  
                     @(posedge vif.clk);
                        
                        req.a = vif.a;
                        req.b = vif.b;
                        req.op_code = operation'(vif.op_code);

                        #20; 
     
                        req.result = vif.result;
                        put_port.put(req);

                 end

endtask : run_phase


