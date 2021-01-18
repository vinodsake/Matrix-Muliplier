/**********************************************************************
* File Name	: tb_nbitAdder.sv
* Description 	: test bench for nbit adder
* Creation Date : 06-12-2020
* Last Modified : Sun 17 Jan 2021 06:31:58 PM PST
* Author 	: Vinod Sake
* Email 	: vinodsake042@gmail.com
* GitHub	: github.com/vinodsake
**********************************************************************/
`include "package.sv"
import project_pkg::*;

module tb_nbitAdder(intf_nbitAdder.tb adder_if);
	logic unsigned [MSB-1:0]USSum_sb;
	logic signed [MSB-1:0]SSum_sb;
	logic Carry_sb;
	int error = 0;
	bit Signed = 0;
	bit overflow = 0;
	logic [MSB-1:0]overflow_t;

	initial begin
		if($test$plusargs("debug")) begin
			$display("           %10s	%10s	%10s	%10s	%s	%s	%s", "A", "B", "Sum", "Exp-Sum", "Carry", "Exp-Carry", "overflow");
		end
		
		// Unsigned Addition
		Signed = 0;
		adder_if.A = 0;
		adder_if.B = 0;
		#5;
		adder_if.A = 10;
		adder_if.B = 10;
		#5;
		adder_if.A = 2 ** (MSB) - 1;
		adder_if.B = 1;
		#5;
		adder_if.A = 0;
		adder_if.B = 2 ** (MSB-1) - 1;
		#5;	
		adder_if.A = 0;
		adder_if.B = 2 ** (MSB) - 1;
		#5;	
		
		// Signed Addition
		Signed = 1;
		adder_if.A = -2;
		adder_if.B = 4;
		#5;
		adder_if.A = 700;
		adder_if.B = -1300;
		#5;
		adder_if.A = -(2 ** (MSB-1));
		adder_if.B = -1;
		#5;
		adder_if.A = (2 ** (MSB-1) - 1);
		adder_if.B = 1;

		#5;
		if(error > 0) begin
			$display("Errors: %d", error);
			$display("**********TEST FAILED**********");
		end
		else begin
			$display("**********TEST PASSED**********");
		end
			
		$finish;

	end

	always @(adder_if.A, adder_if.B, adder_if.Sum, adder_if.Carry) begin
		#1; 	//wait for output to propagate
		scoreboard();
		check();
		if($test$plusargs("debug")) begin
			debug();
		end
	end

	task check;
		if(Signed) begin
			if($signed(adder_if.Sum) !== SSum_sb) begin
				$error("SSum:%0d Exp-SSum:%0d", $signed(adder_if.Sum), SSum_sb);
				error++;
			end
		end
		else begin
			if(adder_if.Sum !== USSum_sb) begin
				$error("USSum:%0d Exp-USSum:%0d", adder_if.Sum, USSum_sb);
				error++;
			end
		end
		if(adder_if.Carry !== Carry_sb) begin
			$error("Carry:%b Exp-Carry:%b", adder_if.Carry, Carry_sb);
			error++;	
		end
	endtask : check
	
	task scoreboard;
		// converting Binary to decimal to avoid errors (Ex: A=-2 B=4 => A=2147483646 B=4 sum=2 exp sum=-2147483646)
		if(Signed) begin
			{Carry_sb,SSum_sb} = adder_if.A + adder_if.B;
			SSum_sb = $signed(SSum_sb);
			// calculating overflow just to understand the debug prints; If overlow is set i.e signed addition is incorrect because of out of bound
			overflow_t = (adder_if.A^adder_if.Sum)&(adder_if.B^adder_if.Sum)&32'h80000000;
			overflow = overflow_t[31];
		end
		else begin
			{Carry_sb,USSum_sb} = adder_if.A + adder_if.B;
			overflow = 0;
		end
	endtask : scoreboard

	task debug;
		if(Signed)
			$display("signed:    %10d	%10d	%10d	%10d	%b	%b	%10d", $signed(adder_if.A), $signed(adder_if.B), $signed(adder_if.Sum), SSum_sb, adder_if.Carry, Carry_sb, overflow);
		else
			$display("unsigned:  %10d	%10d	%10d	%10d	%b	%b	%10d", adder_if.A, adder_if.B, adder_if.Sum, USSum_sb, adder_if.Carry, Carry_sb, overflow);
	endtask : debug
endmodule;
