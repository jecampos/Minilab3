//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    driver 
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
module driver(
    input clk,
    input rst,
    input [1:0] br_cfg,
    output logic iocs,
    output logic iorw,
    input rda,
    input tbr,
    output logic [1:0] ioaddr,
    inout [7:0] databus
    );

logic [15:0] baudrate;

// for UART transmit
logic [7:0] uart_reg;

// mux for baudrate based off br_cfg
always_comb begin
    case(br_cfg)
        2'b00 : baudrate = 16'd4800;
        2'b01 : baudrate = 16'd9600;
        2'b10 : baudrate = 16'd19200;
        2'b11 : baudrate = 16'd38400;
    endcase
end

always_ff @(posedge clk, negedge rst) begin
    if (rda) begin
        uart_reg <= databus;
    end
end

////// STATE MACHINE ///////
typedef enum reg {BAUD_LOW, BAUD_HIGH, RECEIVE, TRANSMIT} state_t;
state_t state, next_state;

// next state each cycle
always_ff @(posedge clk, negedge rst) begin
	if (!rst) begin
		state <= BAUD_LOW;
	end
	else begin
		state <= nxt_state;
	end
end

// next state transistion logic
always_comb begin
    iocs = 0;
    iorw = 0;
    ioaddr = 0;
    next_state = state;

    case(state)
        BAUD_LOW : begin
            ioaddr = 2'b10;
            databus = baudrate[7:0];
            next_state = BAUD_HIGH;
        end

        BAUD_HIGH : begin
            ioaddr = 2'b11;
            databus = baudrate[15:8];
            if (rda) begin
                iorw = 1;
                next_state = RECEIVE;
            end
        end

        RECEIVE : if (tbr) begin
            iocs = 1;
            next_state = TRANSMIT;
        end

        TRANSMIT : if (rda) begin
            iorw = 1;
            next_state = RECEIVE;
        end

    endcase
end

endmodule
