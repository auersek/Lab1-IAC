module clkdiv #(
    parameter WIDTH = 16
)(
    input  logic             clkin,   // Clock input signal to be divided
    input  logic             en,      // Enable clk divider when high
    input  logic [WIDTH-1:0] K,       // Half clock period counts K+1 clkin cycles
    output logic             clkout   // Symmetric clock output Fout = Fin / 2*(K+1)
);                                     // End of port list

    logic [WIDTH-1:0] count;           // Internal counter

initial clkout = 1'b0;                       // Alternative way to initialize logic
initial count = {WIDTH{1'b0}};               // ... or FF (Good for FPGA designs)

always_ff @ (posedge clkin)
    if (en == 1'b1)
        if (count == {WIDTH{1'b0}}) begin
            clkout <= ~clkout;               // Toggle the clock output
            count <= K;                      // Shift right one bit
        end
    else
        count <= count - 1'b1;

endmodule 
