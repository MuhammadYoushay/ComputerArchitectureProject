module Program_Counter (
    input clk, reset, PCWrite,
    input [63:0] PC_In,
    output reg [63:0] PC_Out
);

    reg reset_force; // variable to force 0th value after reset

    initial begin
        PC_Out <= 64'd0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset || reset_force) begin
            PC_Out <= 64'd0;
            reset_force <= 0;
        end
        else if (!PCWrite) begin
            PC_Out <= PC_Out;
        end
        else begin
            PC_Out <= PC_In;
        end
    end

    always @(negedge reset) begin
        reset_force <= 1;
    end

endmodule 
