/**********************************************************************
* File Name	: intf_nbitAdder.sv
* Description 	: Interface file to connect fa dut
* Creation Date : 06-12-2020
* Last Modified : Sun 17 Jan 2021 04:48:17 PM PST
* Author 	: Vinod Sake
* Email 	: vinodsake042@gmail.com
* GitHub	: github.com/vinodsake
**********************************************************************/
`ifndef _include_nbitadder_intf_
`define _include_nbitadder_intf_
`include "package.sv"
import project_pkg::*;
interface intf_nbitAdder;
	logic [MSB-1:0]A; 
	logic [MSB-1:0]B;
	logic [MSB-1:0]Sum;
	logic Carry;
	modport dut (input A, B, output Sum, Carry);
	modport tb (input Sum, Carry, output A, B);
endinterface : intf_nbitAdder
`endif // _include_nbitadder_intf_
