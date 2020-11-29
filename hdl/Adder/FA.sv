/**********************************************************************
* File Name	: FA.sv
* Description 	: Full Adder using Half Adders
* Creation Date : 27-11-2020
* Last Modified : Sat 28 Nov 2020 11:36:40 AM PST
* Author 	: Vinod Sake
* Email 	: vinodsake042@gmail.com
* GitHub	: github.com/vinodsake
**********************************************************************/
`celldefine
module FA (
        input   A,
        input   B,
        input   Cin,
        output  Sum,
        output  Cout
);
	wire ha1_sum, ha1_cout, ha2_sum, ha2_cout;
	wire Sum, Cout;
	HA ha1(.A(A), .B(B), .Sum(ha1_sum), .Cout(ha1_cout));
	HA ha2(.A(ha1_sum), .B(Cin), .Sum(ha2_sum), .Cout(ha2_cout));
	
	assign Sum = ha2_sum;
	assign Cout = ha2_cout | ha1_cout;
endmodule
`endcelldefine
