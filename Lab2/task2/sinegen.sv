module sinegen #(
    parameter A_WIDTH = 8,
    parameter D_WIDTH = 8
)(
    // interface signals
    input logic             clk,    // clock
    input logic             rst,    // reset
    input logic             en,     // enable
    input logic [D_WIDTH-1:0] incr, // increment for addr counter
    input logic [A_WIDTH-1:0]     k,
    output logic [D_WIDTH-1:0] dout1,
    output logic [D_WIDTH-1:0] dout2
);

    logic [A_WIDTH-1:0]     address1;    // interconnect wire
    logic [A_WIDTH-1:0]     address2;    // interconnect wire


counter addrCounter1 (
    .clk    (clkout),
    .rst    (rst),
    .en     (en),
    .incr   (incr),
    .count  (address1)
);

counter #(
    .START(64)
) addrCounter2 (
    .clk    (clkout),
    .rst    (rst),
    .en     (en),
    .incr   (incr),
    .count  (address2)
);

clkdiv clockDivider (
    .clkin      (clk),
    .en         (en),      // Enable clk divider when high
    .K          (k),      
    .clkout     (clkout)
);

rom2 sineRom (
    .clk    (clkout),
    .addr1  (address1),
    .addr2  (address2),
    .dout1   (dout1),
    .dout2   (dout2)
);

endmodule
