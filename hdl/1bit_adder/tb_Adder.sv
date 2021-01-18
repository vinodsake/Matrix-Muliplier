/**********************************************************************
* File Name	: tb_Adder.sv
* Description 	: Verifying Half & Full Adder
* Creation Date : 21-11-2020
* Last Modified : Sat Jan 16 20:37:08 2021
* Author 	: Vinod Sake
* Email 	: vinodsake042@gmail.com
* GitHub	: github.com/vinodsake
*********************************************************************/

module tb_Adder;
	reg A, B, Cin;
	wire ha_Sum, ha_Cout, fa_Sum, fa_cout;
	reg ha_Sum_sb, ha_Cout_sb, fa_Sum_sb, fa_Cout_sb;
	int error = 0;

	HA ha(.A(A), .B(B), .Sum(ha_Sum), .Cout(ha_Cout));
	FA fa(.A(A), .B(B), .Cin(Cin), .Sum(fa_Sum), .Cout(fa_Cout));

	initial begin
		if($test$plusargs("debug")) begin
			$display("Type	A	B	Cin	RcvSum	ExpSum	RcvCout	ExpCout");
		end
		{A,B,Cin} = 0;
		#5 {A,B,Cin} = 1; 		
		#5 {A,B,Cin} = 2; 		
		#5 {A,B,Cin} = 3; 		
		#5 {A,B,Cin} = 4; 		
		#5 {A,B,Cin} = 5; 		
		#5 {A,B,Cin} = 6; 		
		#5 {A,B,Cin} = 7;

		#5
		if(error > 0) begin
			$display("Errors: %d", error);
			$display("**********TEST FAILED**********");
		end
		else begin
			$display("**********TEST PASSED**********");
		end
		$finish;		
	end

	always @ (A,B,Cin) begin
		score_board(A, B, Cin, ha_Sum_sb, ha_Cout_sb, fa_Sum_sb, fa_Cout_sb);
		#1;	//wait for output to propagate
		check(ha_Sum, ha_Cout, fa_Sum, fa_cout,
			ha_Sum_sb, ha_Cout_sb, fa_Sum_sb, fa_Cout_sb, error);	
		if($test$plusargs("debug")) begin
			debug(A, B, Cin, ha_Sum, ha_Cout, fa_Sum, fa_Cout,
				ha_Sum_sb, ha_Cout_sb, fa_Sum_sb, fa_Cout_sb);
		end
	end	

	task score_board;
		input A, B, Cin;
		output reg ha_Sum_sb, ha_Cout_sb, fa_Sum_sb, fa_Cout_sb;
		begin
			{ha_Cout_sb,ha_Sum_sb} = A + B;
			{fa_Cout_sb,fa_Sum_sb} = A + B + Cin;
		end
	endtask : score_board

	task check;
		input ha_Sum, ha_Cout, fa_Sum, fa_cout;
		input ha_Sum_sb, ha_Cout_sb, fa_Sum_sb, fa_Cout_sb;
		output int error;
		if(ha_Sum !== ha_Sum_sb) begin
			$error("HA Rcv Sum:%b Exp Sum:%b",ha_Sum,ha_Sum_sb);
			error++;	
		end
		if(ha_Cout !== ha_Cout_sb) begin
			$error("HA Rcv Cout:%b Exp Cout:%b", ha_Cout, ha_Cout_sb);
			error++;
		end
		if(fa_Sum !== fa_Sum_sb) begin
			$error("FA Rcv Sum:%b Exp Sum:%b",fa_Sum,fa_Sum_sb);	
			error++;
		end
		if(fa_Cout !== fa_Cout_sb) begin
			$error("FA Rcv Cout:%b Exp Cout:%b", fa_Cout, fa_Cout_sb);
			error++;
		end
	endtask: check

	task debug;
		input A , B, Cin, ha_Sum, ha_Cout, fa_Sum, fa_cout;
		input ha_Sum_sb, ha_Cout_sb, fa_Sum_sb, fa_Cout_sb;
		$display("HA	%b	%b	N/A	%b	%b	%b	%b", A, B, ha_Sum, ha_Sum_sb, ha_Cout, ha_Cout_sb);
		$display("FA	%b	%b	%b	%b	%b	%b	%b", A, B, Cin, fa_Sum, fa_Sum_sb, fa_Cout, fa_Cout_sb);
	endtask : debug	
endmodule
