
LDA X0, a
ADDI X1,XZR,#0
ADDI X2,XZR,#5
SUBI X3,X1,#1
ADDI X4,X1,#0
BL PARTITION
STOP


SWAP: 
SUBI SP,SP #40
STUR FP,[SP,#0]
STUR LR,[SP,#8]
STUR X0,[SP,#16]
STUR X1,[SP,#24]
ADDI FP,SP,#32

LDUR X9,[X0,#0]
LDUR X10,[X1,#0]
STUR X10,[X0,#0]
STUR X9,[X1,#0]

LDUR X19 [X0,#0] // PRINTING FOR TESTING
LDUR X20 [X1,#0]
putint X19
putint X20       // PRINTING FOR TESTING

SWAPEND:
LDUR FP,[SP,#0]
LDUR LR,[SP,#8]
LDUR X0,[SP,#16]
LDUR X1,[SP,#24]
ADDI SP,SP,#40
	
BR LR

////////////////////////////
//                    	//
//   	partition        //
//                   	//
////////////////////////////

PARTITION: 
	//   input:
	//   X0: The address of (pointer to) the first value of the unsorted array (this value does not depend on the values of 'low' and 'high')
    	//   X1: The value of 'low'
	//   X2: The value of 'high'
	//   X3: TPI, which is initialized as 'low-1' in Quicksort function
	//   X4: CI, which is initialized as 'low' in Quicksort function
	
	//   output:
	//   X0: the index of the pivot in the sorted array
 	
	// INSERT YOUR CODE HERE
	SUBI SP,SP,#80
	STUR FP,[SP,#0]
	STUR LR,[SP,#8]
	STUR X0,[SP,#16]
	STUR X1,[SP,#24]
	STUR X2,[SP,#32]
	STUR X3,[SP,#40]
	STUR X4,[SP,#48]
	ADDI FP,SP,#72
	LSL X15,X2,#3
	
	ADD X14,X15,X0
	LDUR X14,[X14,#0] // X14 PIVOT VALUE
	
	ADDI X9,X3,#0
	ADDI X10,X4,#0  // X10 J VALUE
	SUBS XZR,X10,X2
	B.NE SECONDIF
	ADDI X9,X9,#1
	LSL X13,X9,#3
	ADD X0,X0,X13
	LSL X11,X2,#3
	LDUR X12,[SP,#16]
	ADD X1,X11,X12
	BL SWAP
	ADDI X0,X9,#0
	B PARTITIONEND
	
SECONDIF:
	LSL X16,X10,#3 // X16 = J * 8
	LDUR X0,[SP,#16]
	ADD X17,X16,X0 // X17 ADDRESS OF A[J]
	LDUR X18,[X17,#0]
	SUBS XZR,X14,X18
	B.GT CONTINUE
	LDUR X3,[SP,#40]
	ADDI X19,X3,#1
	LSL X19,X19,#3
	ADD X0,X0,X19 // X0 HAS THE ADDRESS A[I]
	BL SWAP
CONTINUE:
	ADDI X4,X10,#1
	BL PARTITION
	
PARTITIONEND:
	PUTINT X0    ////// PRINTING
	LDUR FP,[SP,#0]
	LDUR LR,[SP,#8]
	ADDI SP,SP,#80
	BR LR


