`include "clk_div_26bit.v"
`include "bcd_shift_register.v"
`include "uart/uart.v"
`include "top.v"

`timescale 1ns / 1ns
module clk_generate(
	output reg clk
);
	initial begin
		clk=0;
		forever #10 clk = ~clk;
	end
endmodule

`timescale 1ms / 1ns

module stimulus;
	reg reset=0, write=0;
	reg [7:0] terminal=0;
	wire divided_clk_tick;
	wire clk;

	uart #(.FIFO_DEPTH(16)) uart_inst (
		.clk(clk),
		.reset(reset),
		.tx(rx),
		.data_in(terminal),
		.wr_data(write)	
	);		

	top top(
		.clk(clk),
		.reset(reset),
		.rx(rx),
		.baund_rate_ready(baund_ready),
		.banner_write(being_written)
	);

	clk_generate genclk(.clk(clk));


	always @(posedge top.divided_clk_tick) $display("%d %d %d %d %d %d ",
		top.bcd_set[(6*4)-1:(5*4)],
		top.bcd_set[(5*4)-1:(4*4)],
		top.bcd_set[(4*4)-1:(3*4)],
		top.bcd_set[(3*4)-1:(2*4)],
		top.bcd_set[(2*4)-1:(1*4)],
		top.bcd_set[(1*4)-1:(0*4)]
	);

	initial begin
		reset = 1;
		@(posedge clk);
		reset = 0;
		@(posedge clk);
		terminal="5";
		write=1;
		@(posedge clk);
		write=0;
		wait(baund_ready);
		write=0;
		$display("time: %t", $time);

		#1;
		terminal="w";
		write=1;
		@(posedge clk);
		write=0;
		#1;
		write=1;
		terminal="3";
		@(posedge clk);
		write=0;
		#1;
		write=1;
		terminal="4";
		@(posedge clk);
		write=0;
		#1;
		write=1;
		terminal="0";
		@(posedge clk);
		write=0;
		#1;
		write=1;
		terminal="3";
		@(posedge clk);
		write=0;
		#1;
		write=1;
		terminal="4";
		@(posedge clk);
		write=0;
		#1;
		write=1;
		terminal="0";
		@(posedge clk);
		write=0;
		#1;
		write=1;
		terminal = "s";
		@(posedge clk);
		write=0;
	   	
		#30 $finish;	
	end	
endmodule
