/**********************************************************************
* File Name	: Adder.sv
* Description 	: Half & Full Adder
* Creation Date : 20-11-2020
* Last Modified : Sat 21 Nov 2020 11:57:46 PM PST
* Author 	: Vinod Sake
* Email 	: vinodsake042@gmail.com
* GitHub	: github.com/vinodsake
*********************************************************************/
module HA (
	input	A,
	input	B,
	output	Sum,
	output	Cout
	);
	reg Sum, Cout;
	assign Sum = A ^ B;
       	assign Cout = A & B;	
endmodule

module FA (
	input	A,
	input	B,
	input	Cin,
	output	Sum,
	output	Cout
);
	reg Sum, Cout;
	assign Sum = Cin ^ (A ^ B);
	assign Cout = (A & B) | (Cin & (A ^ B)); 
endmodule
