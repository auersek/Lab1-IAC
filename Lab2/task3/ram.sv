module ram #(
    parameter   ADDRESS_WIDTH = 9,
                DATA_WIDTH = 8
)(
    input logic                     clk,
    input logic                     wren,
    input logic                     rden,
    input logic [ADDRESS_WIDTH-1:0] waddr,
    input logic [ADDRESS_WIDTH-1:0] offset,
    input logic [DATA_WIDTH-1:0]    din,
    output logic [DATA_WIDTH-1:0]   dout              
);

    logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];

always_ff @(posedge clk) begin
    if(wren == 1'b1)
        ram_array[waddr] <= din;
    if(rden == 1'b1)
        dout <= ram_array[waddr + offset];
end

endmodule
