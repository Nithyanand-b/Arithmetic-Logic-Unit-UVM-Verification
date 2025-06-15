class alu_sequence extends uvm_sequence #(alu_sequence_item);
          
                 alu_sequence_item req;

                 `uvm_object_utils(alu_sequence)

                  extern function new(string name = "alu_sequence");
                  extern task body(); 

endclass : alu_sequence

function alu_sequence::new(string name = "alu_sequence");

                   super.new(name);

endfunction : new

task alu_sequence::body();
       
                   req = alu_sequence_item::type_id::create("req");
                   repeat (10) begin
                     wait_for_grant();
                     assert(req.randomize());
                     send_request(req);
                     wait_for_item_done();
                   end
endtask : body