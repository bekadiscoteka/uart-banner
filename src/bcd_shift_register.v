`ifndef BCD_SHIFT_REG
	`define BCD_SHIFT_REG
	module bcd_shift_register #(
		parameter W=4, N=6
	)(
		output reg [(W*N)-1:0]	data_out,
		input [(W*N)-1:0] data_in,
		input	set_left,
				set_right,
				start,
				pause,
				write,
				clk, reset
	);
		localparam	START=1,
					PAUSE=0;

		localparam	LEFT=0,
					RIGHT=1;
		reg shift_direction;

		reg state; 

		always @(posedge clk, posedge reset) begin
			if (reset) begin
				data_out <= 0;
				state <= PAUSE;
				shift_direction <= RIGHT;
			end
			else if (write) data_out <= data_in;
			else begin
				if (set_left) shift_direction <= LEFT;
				else if (set_right) shift_direction <= RIGHT;
				case (state) 
					START: begin
						if (pause) state <= PAUSE;
						data_out <= shift_direction == RIGHT ? 
				  					data_out >> W : data_out << W;
					end
					PAUSE: if (start) state <= START;
				endcase
			end
		end	
	endmodule
`endif
