module baud_rate(
    input clk,
    input rst,
    input [1:0] ioaddr,
    inout [7:0] databus,
    output logic enable
    );

reg [15 : 0] divisor;
reg [15 : 0] count;

always_ff@(posedge clk, negedge rst)begin
    if(!rst)
        divisor <= '1;
    else if(ioaddr[1] && ioaddr[0])
        divisor <= {databus, divisor[7:0]};
    else if(ioaddr[1] && !ioaddr[0])
        divisor <= {divisor[15:8], databus};
end

always_ff@(posedge clk, negedge rst) begin
    if(~rst) begin
        count <= 2;
        enable <= 0;
    end
    else if(count == 0) begin
        enable <= 1;
        count <= divisor;
    end
    else begin
        enable <= 0;
        count <= count - 1;
    end
end

endmodule
