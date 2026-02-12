`timescale 1ns/1ps
`define T_CLK 10

module tb_fir_filter;

reg 			clk;
reg 			n_rst;

reg 	[7:0] 	xn_mem[0:2999];

wire 	[7:0]	dout;	// yn

wire	[7:0]	xn;

reg		[11:0]	r_addr;


fir_filter u_fir_filter(
	.clk	(clk),
	.n_rst	(n_rst),
	.din	(xn),
	.dout	(dout)
);

initial begin
	clk = 1'b1;
	n_rst = 1'b0;

	#(`T_CLK*2.2) n_rst = 1'b1;
end

always #(`T_CLK/2) clk = ~clk;

// ------ Memory Encoding ------ //

integer i;


initial begin 
	$readmemh("./xn_data.txt", xn_mem);
end

initial begin
	r_addr = 12'h000;
	wait(n_rst==1'b1);
	
	for (i = 0; i<3000;i=i+1) begin
		#(`T_CLK*1 ) r_addr = r_addr + 12'h001;
	end

	#(`T_CLK*5) $finish;
end

assign xn = xn_mem[r_addr]; 
// always @(posedge clk or negedge n_rst) begin
// 	xn <= xn_mem[r_addr];
// end

/*
initial begin 
	$fsdbDumpfile("wave.fsdb");
	$fsdbDumpvars(0);
end
*/

`ifdef SDF_PRE
initial begin
	$sdf_annotate("../../syn/2_Output/mapped/fir_filter.pre.sdf", u_fir_filter);
end
`endif

initial begin
	`ifdef SDF_PRE
	$fsdbDumpfile("test.pre.fsdb");
	`else
	$fsdbDumpfile("test.fsdb");
	`endif
	$fsdbDumpvars(0);
end

endmodule 
