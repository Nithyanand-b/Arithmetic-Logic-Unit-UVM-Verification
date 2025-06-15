interface alu_if(input bit clk);

logic [7:0] a;
logic [7:0] b;
logic [2:0] op_code;
logic [15:0] result;

endinterface : alu_if