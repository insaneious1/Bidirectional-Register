`timescale 1ns / 1ps

//designing a multiplexer to select whose data to be read

module mux(
	input wire clk,reset,[1:0]smux,rdnwr,
	input wire [7:0]data0,data1,data2,data3,
	output reg [7:0] out
);
	always @(posedge clk)begin
    	if(reset)begin
        	out = 8'bz;
    	end
    	else if(rdnwr)begin
        	case(smux)
            	2'b00 : out = data0;
            	2'b01 : out = data1;
            	2'b10 : out = data2;
            	2'b11 : out = data3;
            	endcase
        	end    
  	end
endmodule

//designing a demultiplexer to select where to write

module demux(
	input wire clk,reset,[1:0]sdemux,rdnwr,
	output reg [7:0]data0,data1,data2,data3,
	input wire [7:0]in
);
	always @(posedge clk)begin
    	if(reset)begin
        	data0 = 8'bz;
        	data1 = 8'bz;
        	data2 = 8'bz;
        	data3 = 8'bz;          	 
        	end else if(!rdnwr) begin
        	case(sdemux)
            	2'b00 : data0 = in;
            	2'b01 : data1 = in;
            	2'b10 : data2 = in;
            	2'b11 : data3 = in;
            	endcase
        	end    
  	end
endmodule
module bidirectional_register (
	input wire clk,    	// Clock input
	input wire reset,  	// Reset input
	input wire rdnwr, 	// Enable input
	input wire [7:0]wr_data, 	//data to be written on bidir_io in write mode
	inout wire [7:0]bidir_io,	// Bidirectional I/O pin
	input wire [7:0] databi, //input to bidirectional reg in read mode
	output reg [7:0]op
  	 
);

	reg [7:0] data;	// 8-bit data register
	always @(posedge clk)
	begin
    	data <= databi;
	end
    
  // Read operation

	assign bidir_io = (rdnwr) ? data : wr_data; //read operation on recieving ack or when rdnwr is high or in write operation
                                                      	//bidir_io will get data from processor through wr_data wires
    
	// Write operation
	always @(posedge clk or posedge reset) begin
    	if (reset) begin
        	data <= 8'b0;   // Reset data to 0
    	end else if ((rdnwr) == 1'b0) begin
        	op <= bidir_io;  // Write bidirectional input data to register when enabled
   	 
    	end
	end
 
endmodule

module topmodule(
	input wire clk,reset,rdnwr,
	input wire [1:0]smux,[1:0]sdemux,
	input wire [7:0] rddata0,rddata1,rddata2,rddata3,wr_data,
	inout wire [7:0]data_bus,
	output wire [7:0]wrdata0,wrdata1,wrdata2,wrdata3
);
	wire [7:0] mux_out,demux_in;
    
	mux mux_inst(
    	.clk(clk),
    	.reset(reset),
    	.smux(smux),
    	.data0(rddata0),
    	.data1(rddata1),
    	.data2(rddata2),
    	.data3(rddata3),
    	.out(mux_out),
    	.rdnwr(rdnwr)
	);
   
	demux demux_inst(
    	.clk(clk),
    	.reset(reset),
    	.sdemux(sdemux),
    	.data0(wrdata0),
    	.data1(wrdata1),
    	.data2(wrdata2),
    	.data3(wrdata3),
    	.in(demux_in),
    	.rdnwr(rdnwr)
	);
    
	bidirectional_register bidirectional_register_set(
    	.clk(clk),
    	.reset(reset),
    	.rdnwr(rdnwr),
    	.wr_data(wr_data),
    	.bidir_io(data_bus),
    	.databi(mux_out),
    	.op(demux_in)
	);
endmodule
