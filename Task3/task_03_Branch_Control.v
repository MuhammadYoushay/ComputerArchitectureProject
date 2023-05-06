module Branch_Control
(
    input Branch, Zero, Greater_Check,
    input [3:0] funct,
    output reg switch_branch, Flush
);

always @(*) begin
    if (Branch) begin
        case ({funct[2:0]})
            3'b000: switch_branch = Zero ? 1 : 0;
            3'b001: switch_branch = Zero ? 0 : 1;
            3'b101: switch_branch = Greater_Check ? 1 : 0;
            3'b100: switch_branch = Greater_Check ? 0 : 1;
            default: switch_branch = 0;
        endcase
    end else begin
        switch_branch = 0;
    end
end

always @(switch_branch) begin
    if (switch_branch) begin
        Flush <= 1;
    end else begin
        Flush <= 0;
    end
end

endmodule 