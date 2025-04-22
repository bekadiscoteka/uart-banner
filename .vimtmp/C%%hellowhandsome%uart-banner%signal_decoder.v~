`ifndef SIG_DECODER
	`define SIG_DECODER
	module signal_decoder(
		output reg	write_banner,
	   				start,
					pause,
					left,
					right,
		input [7:0] ascii		
	);
		always @* begin
			write_banner = 0;
			start = 0;
			pause = 0;
			left = 0;
			right = 0;
			case (ascii) 
				"s": start = 1;
				"p": pause = 1;
				"w": write_banner = 1;
				"l": left = 1;
				"r": right = 1;
			endcase
		end	
	endmodule
`endif
