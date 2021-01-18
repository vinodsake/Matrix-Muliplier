/**********************************************************************
* File Name	: Ripple.sv
* Description 	: Ripple carry adder using FA
* Creation Date : 06-12-2020
* Last Modified : Sun 17 Jan 2021 05:03:08 PM PST
* Author 	: Vinod Sake
* Email 	: vinodsake042@gmail.com
* GitHub	: github.com/vinodsake
**********************************************************************/
`include "package.sv"
import project_pkg::*;

module ripple_carry_adder(intf_nbitAdder.dut adder_if);
	
	wire [MSB:0] w_carry;
	
	//assign fitst carryin to 0
	assign w_carry[0] = 0;
	assign adder_if.Carry = w_carry[32];

	genvar i;
	generate
		for(i=0; i<MSB; i++) begin
			FA fa_inst(.A(adder_if.A[i]), .B(adder_if.B[i]), .Cin(w_carry[i]), .Sum(adder_if.Sum[i]), .Cout(w_carry[i+1]));
		end
	endgenerate

endmodule
//`endif //_ripple_sv
