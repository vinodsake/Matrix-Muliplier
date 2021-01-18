/**********************************************************************
* File Name	: top_nbitAdder.sv
* Description 	: Top module connecting dut with tb via interface
* Creation Date : 06-12-2020
* Last Modified : Wed 09 Dec 2020 07:14:59 PM PST
* Author 	: Vinod Sake
* Email 	: vinodsake042@gmail.com
* GitHub	: github.com/vinodsake
**********************************************************************/

module top_nbitAdder;
	intf_nbitAdder adder_if();
	ripple_carry_adder dut(adder_if);
	tb_nbitAdder tb(adder_if);
endmodule;
