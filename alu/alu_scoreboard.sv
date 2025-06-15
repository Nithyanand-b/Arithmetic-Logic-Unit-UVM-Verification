                 `uvm_blocking_put_imp_decl(_a)
                 `uvm_blocking_put_imp_decl(_p)
                 
class alu_scoreboard extends uvm_scoreboard;

                 `uvm_component_utils(alu_scoreboard)

                 virtual alu_if vif;

                 alu_sequence_item data_rec_a[$]; // Active monitor queue
                 alu_sequence_item data_rec_p[$]; // Passive monitor queue
                 
                 // Temporarily holds items popped from the queues for processing
                 alu_sequence_item temp_seq_item_a; 
                 alu_sequence_item temp_seq_item_p;

                 uvm_blocking_put_imp_a #(alu_sequence_item, alu_scoreboard) put_export_a;
                 uvm_blocking_put_imp_p #(alu_sequence_item, alu_scoreboard) put_export_p;

                 extern function new(string name = "alu_scoreboard", uvm_component parent = null);
                 extern function void build_phase(uvm_phase phase);
                 extern function void connect_phase(uvm_phase phase);
                 extern task put_a(alu_sequence_item seq);
                 extern task put_p(alu_sequence_item seq);
                 extern virtual task run_phase(uvm_phase phase);
                 extern function void compare_item();

endclass : alu_scoreboard

function alu_scoreboard::new(string name = "alu_scoreboard",uvm_component parent = null);
   
                     super.new(name,parent);

endfunction : new

function void alu_scoreboard::build_phase(uvm_phase phase);
                 
                 super.build_phase(phase);
                 put_export_a    =   new("put_export_a",this);
                 put_export_p    =   new("put_export_p",this);
                 temp_seq_item_a =   new("temp_seq_item_a");
                 temp_seq_item_p =   new("temp_seq_item_p");

endfunction : build_phase

function void alu_scoreboard::connect_phase(uvm_phase phase);
                 super.connect_phase(phase);
                 if(!(uvm_config_db #(virtual alu_if)::get(null, "*", "vif", vif))) 
                           
                     `uvm_error("MON", "uvm_config_db::get - Failed at interface")           

endfunction : connect_phase

task alu_scoreboard::put_a(alu_sequence_item seq);
                 
                 data_rec_a.push_back(seq);

endtask : put_a

task alu_scoreboard::put_p(alu_sequence_item seq);

                 data_rec_p.push_back(seq);

endtask : put_p

function void alu_scoreboard::compare_item();

                 temp_seq_item_p = data_rec_p.pop_front();

                 if(temp_seq_item_a.compare(temp_seq_item_p))
                     `uvm_info(get_name(),"******************** -> Data Matched Successful <- ********************",UVM_MEDIUM)
                 else
                     `uvm_error(get_name(), "-******************** -> Data Mismatched <- ********************")

endfunction : compare_item

task alu_scoreboard::run_phase(uvm_phase phase);
    forever begin
        wait(data_rec_a.size > 0);
        temp_seq_item_a = data_rec_a.pop_front();
    
        case(temp_seq_item_a.op_code)
            ADD     : 
                    begin 
                        temp_seq_item_a.result  =   temp_seq_item_a.a + temp_seq_item_a.b;
                    end
            SUB     :
                    begin 
                        temp_seq_item_a.result  =   temp_seq_item_a.a - temp_seq_item_a.b;
                    end
            MUL     :
                    begin 
                        temp_seq_item_a.result  =   temp_seq_item_a.a * temp_seq_item_a.b;
                    end
           
            OR      :
                    begin 
                        temp_seq_item_a.result  =   temp_seq_item_a.a | temp_seq_item_a.b;
                    end
            XOR     :
                    begin 
                        temp_seq_item_a.result  =   temp_seq_item_a.a ^ temp_seq_item_a.b;
                    end
            AND     :
                    begin 
                        temp_seq_item_a.result  =   temp_seq_item_a.a & temp_seq_item_a.b;
                    end
                    
            NAND    :
                    begin 
                        temp_seq_item_a.result  =   ~(temp_seq_item_a.a & temp_seq_item_a.b);
                    end
            NOR     :
                    begin 
                        temp_seq_item_a.result  =   ~(temp_seq_item_a.a | temp_seq_item_a.b);
                    end
        
            
            default:
                    begin 
                        temp_seq_item_a.result  =   16'b0; 
                    end
        endcase
        compare_item();
    end
endtask : run_phase