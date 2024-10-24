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
    output logic [D_WIDTH-1:0] dout
);

    logic [A_WIDTH-1:0]     address;    // interconnect wire


counter addrCounter (
    .clk    (clkout),
    .rst    (rst),
    .en     (en),
    .incr   (incr),
    .count  (address)
);

clkdiv clockDivider (
    .clkin      (clk),
    .en         (en),      // Enable clk divider when high
    .K          (k),      
    .clkout     (clkout)

);

rom sineRom (
    .clk    (clkout),
    .addr   (address),
    .dout   (dout)
);

endmodule
