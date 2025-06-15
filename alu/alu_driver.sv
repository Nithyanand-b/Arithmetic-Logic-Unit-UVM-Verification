class alu_driver extends uvm_driver #(alu_sequence_item);
                 `uvm_component_utils(alu_driver)
               
                 virtual alu_if vif;
                 alu_sequence_item req;
               
                 extern function new(string name = "alu_driver", uvm_component parent = null);
                 extern function void connect_phase(uvm_phase phase);
                 extern task run_phase(uvm_phase phase);
                 extern function void put_data();
endclass : alu_driver

function alu_driver::new(string name = "alu_driver", uvm_component parent = null);

                 super.new(name, parent);

endfunction

function void alu_driver::connect_phase(uvm_phase phase);

                 if (!(uvm_config_db #(virtual alu_if)::get(null, "*", "vif", vif))) 
                   `uvm_error("DRV", "uvm_config_db::get - Failed at interface")

endfunction

task alu_driver::run_phase(uvm_phase phase);

                 phase.raise_objection(this);
                 repeat (10) begin
                   @(posedge vif.clk);
                   seq_item_port.get_next_item(req);
                   put_data();
                   seq_item_port.item_done();
                 end
                 phase.drop_objection(this);

endtask

function void alu_driver::put_data();

                 vif.a = req.a;
                 vif.b = req.b;
                 vif.op_code = req.op_code;

endfunction
