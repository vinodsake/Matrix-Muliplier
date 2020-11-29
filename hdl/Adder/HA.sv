/**********************************************************************
* File Name	: HA.sv
* Description 	: Half Adder	
* Creation Date : 27-11-2020
* Last Modified : Sat 28 Nov 2020 11:37:03 AM PST
* Author 	: Vinod Sake
* Email 	: vinodsake042@gmail.com
* GitHub	: github.com/vinodsake
**********************************************************************/

module HA (
        input   A,
        input   B,
        output  Sum,
        output  Cout
        );
        wire Sum, Cout;
        assign Sum = A ^ B;
        assign Cout = A & B;
endmodule

