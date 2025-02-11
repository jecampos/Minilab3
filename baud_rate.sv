module baud_rate(
    input clk,
    input rst,
    input [1:0] br_cfg,
    output enable
    );

parameter N = 4;
parameter twoN = 16;
parameter clk_freq = 50000000;

reg [15 : 0] baud;
reg [15 : 0] divisor;
reg [15 : 0] count;
reg en;

assign baud = br_cfg[1] ? (br_cfg[0] ? 18400 : 19200) : (br_cfg[0] ? 9600 : 4800);
assign divisor = clk_freq / ((twoN * baud) - 1);
assign enable = en;

always_ff@(posedge clk, negedge rst) begin
    if(~rst) begin
        count = divisor;
        en = 0;
    end
    else if(count == 0) begin
        en = 1;
        count = divisor;
    end
    else begin
        en = 0;
        count = count - 1;
    end
end

endmodule
