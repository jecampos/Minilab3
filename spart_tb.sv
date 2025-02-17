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
    rst_n = 0;
    rxd = 1;
    br_cfg = 0;
    @(posedge clk)
    @(negedge clk)
    rst_n = 1;

    repeat (105000) @(posedge clk);
    
    // signal 1
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);

    repeat (105000) @(posedge clk);

    // signal 2
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);

    repeat (105000) @(posedge clk);

    // signal 3
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 0;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);
    rxd = 1;
    repeat (10416) @(posedge clk);

    repeat (105000) @(posedge clk);
    $stop();
end

always #1 clk = ~clk;

endmodule

