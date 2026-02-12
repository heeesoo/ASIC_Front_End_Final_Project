module fir_filter(
    input               		clk,
    input               		n_rst,
    input  		signed	[7:0] 	din,    
    output reg 	signed 	[7:0] 	dout 
);

// 13-tap 대칭 FIR 계수 Fixed : [-24, -21, 0, 37, 80, 114, 127, 114, 80, 37, 0, -21, -24]
// 대칭이니까 127 다음 114부터는 사용 X
localparam signed B0 = -24;
localparam signed B1 = -21;
localparam signed B2 =   0;
localparam signed B3 =  37;
localparam signed B4 =  80;
localparam signed B5 = 114;
localparam signed B6 = 127;

// Declared Net, Reg 
reg signed [7:0] din_d;

// 01. X[n] Delay 선언
reg signed [7:0] din_d1;
reg signed [7:0] din_d2;
reg signed [7:0] din_d3;
reg signed [7:0] din_d4;
reg signed [7:0] din_d5;
reg signed [7:0] din_d6;
reg signed [7:0] din_d7;
reg signed [7:0] din_d8;
reg signed [7:0] din_d9;
reg signed [7:0] din_d10;
reg signed [7:0] din_d11;
reg signed [7:0] din_d12;

// 02. 대칭 입력 합 (signed 9bit) 선언부
wire signed [8:0] sum_w0;
wire signed [8:0] sum_w1;
wire signed [8:0] sum_w2;
wire signed [8:0] sum_w3;
wire signed [8:0] sum_w4;
wire signed [8:0] sum_w5;
wire signed [8:0] sum_w6;

// 03. 곱셈 결과 (signed 17bit) 선언
wire signed [16:0] mul_0;
wire signed [16:0] mul_1;
wire signed [16:0] mul_2;
wire signed [16:0] mul_3;
wire signed [16:0] mul_4;
wire signed [16:0] mul_5;
wire signed [16:0] mul_6;

// 04. 내부 FF 1 (곱셈 결과 delay) 선언
reg signed [16:0] mul_0d;
reg signed [16:0] mul_1d;
reg signed [16:0] mul_2d;
reg signed [16:0] mul_3d;
reg signed [16:0] mul_4d;
reg signed [16:0] mul_5d;
reg signed [16:0] mul_6d;

// 05. 합산 1 (signed 18bit) 선언
wire signed [17:0] sum_w00;
wire signed [17:0] sum_w01;
wire signed [17:0] sum_w02;
wire signed [17:0] sum_w03;

// 06. 내부 FF 2 (합산1 결과 delay) 선언언
reg signed [17:0] sum_w00d;
reg signed [17:0] sum_w01d;
reg signed [17:0] sum_w02d;
reg signed [17:0] sum_w03d;

// 07. 합산 2 (signed 19bit, delay된 값 사용) 선언
wire signed [18:0] sum_w000;
wire signed [18:0] sum_w001;

// 08. 합산 3 (signed 20bit) 선언
wire signed [19:0] sum_all;

// 09. 포화(클리핑) 처리
//reg signed [7:0] sum_finish;
wire signed [7:0] sum_finish;


// ----- 01. In/Outside Flip Flop ----- //
// INPUT
always @(posedge clk or negedge n_rst) begin
	if (!n_rst) begin 
		din_d <= 8'h0;
	end

	else begin 
		din_d <= din;
	end
end

// OUTPUT
always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin 
        dout <= 8'sd0;
	end

    else begin 
        dout <= sum_finish;
	end
end


// ----- 02. Inside Module  ----- //

// 01. X[n] Delay 
always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        din_d1  <= 8'sd0; 
        din_d2  <= 8'sd0; 
        din_d3  <= 8'sd0; 
        din_d4  <= 8'sd0;
        din_d5  <= 8'sd0; 
        din_d6  <= 8'sd0; 
        din_d7  <= 8'sd0; 
        din_d8  <= 8'sd0;
        din_d9  <= 8'sd0; 
        din_d10 <= 8'sd0; 
        din_d11 <= 8'sd0; 
        din_d12 <= 8'sd0;
    end else begin
        din_d1  <= din_d;
        din_d2  <= din_d1;
        din_d3  <= din_d2;
        din_d4  <= din_d3;
        din_d5  <= din_d4;
        din_d6  <= din_d5;
        din_d7  <= din_d6;
        din_d8  <= din_d7;
        din_d9  <= din_d8;
        din_d10 <= din_d9;
        din_d11 <= din_d10;
        din_d12 <= din_d11;
    end
end


// 02. 대칭 입력 합 (signed 9bit)
// assign sum_w0 = {din[7], din} + {din_d12[7], din_d12};
// assign sum_w1 = {din_d1[7], din_d1} + {din_d11[7], din_d11};
// assign sum_w2 = {din_d2[7], din_d2} + {din_d10[7], din_d10};
// assign sum_w3 = {din_d3[7], din_d3} + {din_d9[7], din_d9};
// assign sum_w4 = {din_d4[7], din_d4} + {din_d8[7], din_d8};
// assign sum_w5 = {din_d5[7], din_d5} + {din_d7[7], din_d7};
// assign sum_w6 = {din_d6[7], din_d6};   

assign sum_w0 = $signed(din) + $signed(din_d12);
assign sum_w1 = $signed(din_d1) + $signed(din_d11);
assign sum_w2 = $signed(din_d2) + $signed(din_d10);
assign sum_w3 = $signed(din_d3) + $signed(din_d9);
assign sum_w4 = $signed(din_d4) + $signed(din_d8);
assign sum_w5 = $signed(din_d5) + $signed(din_d7);
assign sum_w6 = {din_d6[7], din_d6};   


// 03. 곱셈 (signed 17bit) 
assign mul_0 = $signed(B0) * $signed(sum_w0);
assign mul_1 = $signed(B1) * $signed(sum_w1);
assign mul_2 = $signed(B2) * $signed(sum_w2);
assign mul_3 = $signed(B3) * $signed(sum_w3);
assign mul_4 = $signed(B4) * $signed(sum_w4);
assign mul_5 = $signed(B5) * $signed(sum_w5);
assign mul_6 = $signed(B6) * $signed(sum_w6);


// 04. 내부 FF 1
always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin 
        mul_0d <= 17'sd0;
        mul_1d <= 17'sd0;
        mul_2d <= 17'sd0;
        mul_3d <= 17'sd0;
        mul_4d <= 17'sd0;
        mul_5d <= 17'sd0;
        mul_6d <= 17'sd0;
    end 
	
	else begin 
        mul_0d <= mul_0;
        mul_1d <= mul_1;
        mul_2d <= mul_2;
        mul_3d <= mul_3;
        mul_4d <= mul_4;
        mul_5d <= mul_5;
        mul_6d <= mul_6;
    end
end


// 05. 합산 1 (signed 18bit) - delay된 곱셈값 사용
assign sum_w00 = $signed(mul_0d) + $signed(mul_1d); 
assign sum_w01 = $signed(mul_2d) + $signed(mul_3d); 
assign sum_w02 = $signed(mul_4d) + $signed(mul_5d);
assign sum_w03 = $signed(mul_6d);


// 06. 내부 FF 2
always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        sum_w00d <= 18'sd0;
        sum_w01d <= 18'sd0;
        sum_w02d <= 18'sd0;
        sum_w03d <= 18'sd0;
    end 
	
	else begin
        sum_w00d <= sum_w00;
        sum_w01d <= sum_w01;
        sum_w02d <= sum_w02;
        sum_w03d <= sum_w03;
    end
end


// 07. 합산 2 (signed 19bit)
assign sum_w000 = $signed(sum_w00d) + $signed(sum_w01d); 
assign sum_w001 = $signed(sum_w02d) + $signed(sum_w03d);


// 08. 합산 3 (signed 20bit)
assign sum_all = $signed(sum_w000) + $signed(sum_w001);


// 09. 포화(클리핑) 처리
assign sum_finish =	((sum_all[19]) && (sum_all[18:16] != 3'b111))? 8'h81 : 
 					((!sum_all[19]) && (sum_all[18:16] != 3'b000))? 8'h7F : sum_all[16:9];

// assign sum_finish = (sum_all[19] && ~&sum_all[18:15])? 8'h81 : 
// 					(!sum_all[19] && |sum_all[18:15])? 8'h7F : sum_all[15:8];


endmodule