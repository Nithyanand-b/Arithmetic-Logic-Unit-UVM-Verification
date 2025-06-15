module alu_dut (op_code, clk, a, b, result);

                input clk;
                input [7:0] a;
                input [7:0] b;
                input [2:0] op_code;
                
                output reg [15:0] result;

                parameter ADD = 3'b000,
                          SUB = 3'b001,
                          MUL = 3'b010,
                          OR  = 3'b011,
                          XOR = 3'b100,
                          AND = 3'b101,
                         NAND = 3'b110,
                          NOR = 3'b111  ;

      always @(posedge clk) begin
        
             case (op_code)

                  ADD : result <= a + b;
                  SUB : result <= a - b;
                  MUL : result <= a * b;
                   OR : result <= a | b;
                  XOR : result <= a ^ b;
                  AND : result <= a & b;
                 NAND : result <= ~(a & b);
                  NOR : result <= ~(a | b);
              default : result <= 16'b0;

             endcase
                
       end

endmodule