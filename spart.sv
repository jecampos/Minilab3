//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:   
// Design Name: 
// Module Name:    spart 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spart(
    input clk,
    input rst,
    input iocs,
    input iorw,
    output logic rda,
    output logic tbr,
    input [1:0] ioaddr,
    inout [7:0] databus,
    output txd,
    input rxd
    );

 logic en;
 logic [8:0] transmit;
 logic [8:0] recieve;
 logic [4:0] t_cnt;
 logic [4:0] r_cnt;
 logic recieve_done;

 assign txd = transmit[0];
 assign databus = ((~|ioaddr) && iorw && rda) ? recieve[7:0] : 8'bz;

 always_ff@(posedge clk, negedge rst) begin
    if (!rst) begin
        transmit <= '1;
        t_cnt <= 0;
        tbr <= 1;
    end
    else if(iocs && (!iorw) && (~|ioaddr)) begin
        t_cnt <= 0;
        tbr <= 0;
        transmit <= {databus, 1'b0};
    end
    else if(en) begin
        t_cnt <= t_cnt + 1;
        transmit <= {1'b1, transmit[8:1]};
        if (t_cnt == 4'd9)
            tbr <= 1;
    end
 end

always_ff@(posedge clk, negedge rst) begin
    if(~rst) begin
        rda <= 0;
        recieve <= '1;
        r_cnt <= 0;
        recieve_done <= 0;
    end 
    else if (en) begin
        recieve <= {rxd, recieve[8:1]};
        if (recieve_done && !rxd) begin
            rda <= 0;
            r_cnt <= 1;
            recieve_done <= 0;
        end
        else
            r_cnt <= r_cnt + 1;
        if (r_cnt == 4'd9) begin
            recieve_done <= 1;
            rda <= 1;
        end
    end
    else
        rda <= 0;
end

baud_rate baud0(.clk(clk), .rst(rst), .ioaddr(ioaddr), .databus(databus), .enable(en));

endmodule
