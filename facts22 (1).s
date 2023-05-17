LDA X0, a
ADDI X1,X0,#8

BL SWAP

SWAP: 
	//   input:
	//   X0: The address of (pointer to) the first value to be swapped
    	//   X1: The address of (pointer to) the second value to be swapped.
	
	// INSERT YOUR CODE HERE
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

SWAPEND:
	LDUR FP,[SP,#0]
	LDUR LR,[SP,#8]
	LDUR X0,[SP,#16]
	LDUR X1,[SP,#24]
	ADDI SP,SP,#40
	
	BR LR