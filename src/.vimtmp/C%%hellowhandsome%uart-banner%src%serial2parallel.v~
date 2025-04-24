`ifndef SERIAL2PARALLEL
	`define SERIAL2PARALLEL
	module serial2parallel #(
		parameter	W=4,
					N=6
	)(
		output reg [(W*N)-1:0] data_out,
		output reg done_tick,
		output write_mode,
		input [W-1:0] data_in, 
		input clk, reset, 
			  start,  
			  new_in_data // 1 when there is a new input data 
	);
		localparam	IDLE=0,
					START=1;

		reg [N:0] counter;
		reg state;

		assign write_mode = state == START;

		always @(posedge clk, posedge reset) begin
			if (reset) begin
				done_tick <= 0;
				state <= IDLE;
				data_out <= 0;	
				counter <= 0;
			end
			else begin
				case (state) 
					IDLE: begin
					   	if (start) state <= START; 
						counter <= 0;
						done_tick <= 0;
					end
					START: begin
						if (new_in_data & !start) begin
							if (counter == N-1) begin
								data_out = data_out << W;
								data_out <= {data_out[(N*W)-1:W], data_in};
								state <= IDLE;
								done_tick <= 1;
							end
							else begin
								data_out = data_out << W;
								data_out <= {data_out[(N*W)-1:W], data_in};
							   	counter <= counter + 1;
							end
						end
					end
				endcase
			end
		end
	endmodule
`endif
