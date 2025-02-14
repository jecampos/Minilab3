module baud_rate(
    input clk,
    input rst,
    input [1:0] ioaddr,
    inout [7:0] databus,
    output enable
    );

parameter N = 4;
parameter twoN = 16;
parameter clk_freq = 50000000;

reg [15 : 0] baud;
reg [15 : 0] divisor;
reg [15 : 0] count;
reg en;

assign divisor = clk_freq / ((twoN * baud) - 1);
assign enable = en;

always_ff@(posedge clk, negedge rst)begin
    if(!rst)
        baud <= '1;
    else if(ioaddr[1] && ioaddr[0])
        baud <= {databus, baud[7:0]};
    else if(ioaddr[1] && !ioaddr[0])
        baud <= {baud[15:8], databus};
end

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
