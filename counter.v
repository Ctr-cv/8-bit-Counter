module programmable_counter (
    input wire clk,          // Clock input
    input wire reset,       // Active-high reset
    input wire load,        // Active-high load control
    input wire oe_n,        // Active-low output enable (for tri-state)
    input wire [7:0] data,  // 8-bit data input for loading
    output wire [7:0] count // 8-bit counter output
);

    reg [7:0] counter_reg;  // Internal counter register
    
    // Counter logic
  always @(posedge clk or posedge reset) begin      // Here we start a persistent loop on the rising edge of clock OR on reset
        if (reset) begin
            counter_reg <= 8'b0;         // Reset counter to 0 if reset is high
        end else if (load) begin
            counter_reg <= data;         // Synchronous load from the input wire data
        end else begin
            counter_reg <= counter_reg + 1; // Increment counter by 1
        end
    end

  assign count = (~oe_n) ? counter_reg : 8'bz;  // Tri-state output to allow counter_reg OR high-impedance output
    
endmodule
