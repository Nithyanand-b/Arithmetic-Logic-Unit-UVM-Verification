
class alu_test extends uvm_test;

                 `uvm_component_utils(alu_test)
             
                 alu_env env;
             
                 extern function new(string name = "alu_test",uvm_component parent);
                 extern function void build_phase(uvm_phase phase);
             
                 //UVM phase that runs after all components are constructed and connected 
                 // but before simulation starts.
                 extern function void end_of_elaboration();            
             
             
                 //to check how many UVM errors occurred in simulation.
                 extern function void report_phase(uvm_phase phase);
   
endclass : alu_test




function alu_test::new(string name = "alu_test",uvm_component parent);
    super.new(name,parent);
endfunction : new

function void alu_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = alu_env::type_id::create("env", this);
endfunction : build_phase

function void alu_test::end_of_elaboration();
    print();
endfunction : end_of_elaboration


function void alu_test::report_phase(uvm_phase phase);
    uvm_report_server svr;

    super.report_phase(phase);
    svr = uvm_report_server::get_server();

    if(svr.get_severity_count(UVM_ERROR)> 0)
    begin        
        $display("");
        $display("--------------------------------------------------------------------");
        $display("                              TEST FAILED ");
        $display("--------------------------------------------------------------------");
    end
    else 
    begin
        $display("");
        $display("--------------------------------------------------------------------");
        $display("                              TEST PASSED ");
        $display("--------------------------------------------------------------------");
    end
    
endfunction : report_phase



class alu_test_random extends alu_test;

    `uvm_component_utils(alu_test_random)

    alu_sequence seq;

    extern function new(string name = "alu_test_random", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);


endclass : alu_test_random


function alu_test_random::new(string name = "alu_test_random", uvm_component parent);
    super.new(name,parent);
endfunction : new

function void alu_test_random::build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = alu_sequence::type_id::create("seq",this);
endfunction : build_phase

task alu_test_random::run_phase(uvm_phase phase);
    seq.start(env.agent.sequencer);
endtask : run_phase


