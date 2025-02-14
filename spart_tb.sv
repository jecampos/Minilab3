module spart_tb();

logic clk, rst_n;
logic rxd, txd;
logic [1:0] br_cfg;
wire [35:0] gpio;
lab1_spart iDUT(.CLOCK_50(clk), 
                .CLOCK2_50(), 
                .CLOCK3_50(), 
                .CLOCK4_50(), 
                .HEX0(), 
                .HEX1(), 
                .HEX2(), 
                .HEX3(), 
                .HEX4(), 
                .HEX5(), 
                .KEY({{3{1'b0}}, rst_n}), 
                .LEDR(), 
                .SW({br_cfg, {8{1'b0}}}), 
                .GPIO(gpio));

assign gpio[5] =  rxd;
assign txd = gpio[3];

initial begin
    clk = 0;
    rst_n = 1;
    rxd = 0;
    br_cfg = 0;
    @(posedge clk)
    @(negedge clk)
    rst_n = 0;
    
    rxd = 0;
    repeat (651) @(posedge clk);
    rxd = 1;
    repeat (651) @(posedge clk);
    rxd = 0;
    repeat (651) @(posedge clk);
    rxd = 1;
    repeat (651) @(posedge clk);
    rxd = 0;
    repeat (651) @(posedge clk);
    rxd = 1;
    repeat (651) @(posedge clk);
    rxd = 0;
    repeat (651) @(posedge clk);
    rxd = 1;
    repeat (651) @(posedge clk);
    rxd = 0;
    repeat (651) @(posedge clk);
    rxd = 1;
    repeat (651) @(posedge clk);

    repeat (7000) @(posedge clk);
    $stop();
end

always #5 clk = ~clk;

endmodule

