typedef enum bit [2:0] {   ADD,
                           SUB,
                           MUL,
                            OR,
                           XOR,
                           AND,
                          NAND,
                           NOR   
                       }  operation;

class alu_sequence_item extends uvm_sequence_item;
               
               rand logic [7:0] a;
               rand logic [7:0] b;
               rand operation op_code;
                    logic [15:0] result;
                   
               `uvm_object_utils_begin(alu_sequence_item)
                          
                        `uvm_field_int(a, UVM_ALL_ON)
                        `uvm_field_int(b, UVM_ALL_ON)
                        `uvm_field_enum(operation, op_code, UVM_ALL_ON)

               `uvm_object_utils_end

               extern function new(string name = "alu_sequence_item");

endclass : alu_sequence_item

function alu_sequence_item::new(string name = "alu_sequence_item");

              super.new(name);

endfunction : new