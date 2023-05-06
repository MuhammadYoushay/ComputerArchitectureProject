module IF_ID (
    input clk, IFID_Write, Flush,
    input [63:0] PC_addr,
    input [31:0] Instruc,
    output reg [63:0] PC_store,
    output reg [31:0] Instr_store
);

    always @(posedge clk) begin
        if (Flush) begin
            PC_store <= 0;
            Instr_store <= 0;
        end
        else if (!IFID_Write) begin
            PC_store <= PC_store;
            Instr_store <= Instr_store;
        end
        else begin
            PC_store <= PC_addr;
            Instr_store <= Instruc;
        end
    end

endmodule 
