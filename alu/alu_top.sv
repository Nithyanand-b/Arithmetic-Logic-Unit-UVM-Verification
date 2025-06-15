
    `include "uvm_macros.svh"
    `include "alu_if.sv"
    `include "alu_dut.sv"
    import uvm_pkg::*;
    `include "alu_sequence_item.sv"
    `include "alu_sequence.sv"
    `include "alu_sequencer.sv"
    `include "alu_driver.sv"
    `include "alu_a_monitor.sv"
    `include "alu_p_monitor.sv"
    `include "alu_agent.sv"
    `include "alu_scoreboard.sv"
    `include "alu_env.sv"
    `include "alu_test.sv"

module alu_top;
    
    bit clk = 0;

    always #25 clk = ~clk;
    
    alu_if vif(clk);

    alu_dut dut(.op_code(vif.op_code),
            .clk(clk),
            .a(vif.a), .b(vif.b),
            .result(vif.result));

         
    initial begin
        uvm_config_db#(virtual alu_if)::set(uvm_root::get(), "*","vif", vif);
        uvm_top.set_report_verbosity_level(UVM_MEDIUM);
    end

    initial begin
        run_test("alu_test_random");
    end
endmodule