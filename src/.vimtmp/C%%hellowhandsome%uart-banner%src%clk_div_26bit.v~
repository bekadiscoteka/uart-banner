//clk divider
//divider max 67_108_863
`ifndef CLK_DIV_26BIT
`define CLK_DIV_26BIT
module clk_div_26bit #(
	parameter [25:0] DIVIDER=49_999
)(
	output reg clk_out,
	input clk, reset
);
	reg [25:0] counter;
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			counter <= 0;
			clk_out <= 0;
		end
		else if (counter == DIVIDER) begin
			counter <= 0;
			clk_out <= 1;
		end
		else begin
		   	counter <= counter + 1;
			clk_out <= 0;	
		end
	end
endmodule
`endif
