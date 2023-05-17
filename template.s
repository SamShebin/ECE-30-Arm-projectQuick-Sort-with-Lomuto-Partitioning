/////////////////////////////////////
//                                 //
// Project Submission              //
//                                 //
/////////////////////////////////////

// Partner1: (your name here), (Student ID here)
// Partner2: (your name here), (Student ID here)

////////////////////////
//                    //
//       main         //
//                    //
////////////////////////

// You can modify the elements in the list 'a', the values attained by 'low' and 'high' to test your own cases.

LDA X0, a
MOV X7,X0 // For printing purposes only. Please try avoid using the register X7 in your implementation
ADDI X1, XZR, #0 // 'Low' value stored in X1
ADDI X2, XZR, #5 //  'High' value stored in X2 (0 and 5 are hypothetical numbers, you can put your test values)
BL QUICKSORT
ADDI X2, XZR, #0	   // Initializing a counter for printing
ADDI X3, XZR, #10  // For adding a newline after each number, again for printing purposes only
BL PRINTLIST
STOP

////////////////////////
//                    //
//   	swap	     //
//                    //
////////////////////////

SWAP: 
	//   input:
	//   X0: The address of (pointer to) the first value to be swapped
    	//   X1: The address of (pointer to) the second value to be swapped.
	
	// INSERT YOUR CODE HERE
	SUBI SP,SP # 40
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
	SUBI SP,SP,#40
	STUR FP,[SP,#0]
	STUR LR,[SP,#8]
	ADDI FP,SP,#32
	LSL X15,X2,#3
	
	ADD X14,X15,X0
	LDUR X14,[X14,#0]
	
	ADDI X9,X3,#0
	ADDI X10,X4,#0
	SUBIS XZR,X10,X2
	B.NE SECONDIF
	ADDI X9,X9,#1
	B SWAP
	ADDI X0,X9,#0
	B PARTITIONEND
	
SECONDIF:
	LSL X11,X10,#3
	ADD X13,X11,X0
	LDUR X12,[X13,#0]
	SUBIS XZR,X14,X12
	B.NQ CONTINUE
	ADDI X2,X3,#1
	B SWAP
CONTINUE:
	BL PARTITION
	
PARTITIONEND:
	LDUR FP,[SP,#0]
	LDUR LR,[SP,#8]
	ADDI SP,SP,#40
	BR LR

////////////////////////////
//                    	//
//     quicksort   	//
//                   	//
////////////////////////////


QUICKSORT: 
	//   input:
	//   X0: The address of (pointer to) the first value of the unsorted array (this value does not depend on the values of 'low' and 'high')
    	//   X1: The value of 'low'
	//   X2: The value of 'high'
	
	// INSERT YOUR CODE HERE
	SUBI SP,SP,#48
	STUR FP,[SP,#0]
	STUR LR,[SP,#8]
	ADDI FP,SP,40
	
	STUR X1,[SP,#16] // STORING LOW VALUE ONTO STACK
	STUR X2,[SP,#24] // STORING HIGH VALUE ONTO STACK
	STUR X0,[SP,#32] // STORING A VALUE
	
	SUBS XZR,X1,X2
	B.GE QUICKSORTEND
	
	SUBI X3,X1,#1 // X3 = TPI FOR PARTITION = LOW - 1
	ADDI X4,X1,#0
	BL PARTITION
	STUR X0,[SP,#40] // STORE PIVOT
	SUBI X2,X0,#1
	LDUR X0,[SP,#32]
	BL QUICKSORT
	LDUR X19,[SP,#40]
	ADDI X1,X19,#0
	ADDI X19,X19,#1
	LSL X19,X19,#3
	LDUR X20,[SP,#32]
	ADD X20,X20,X19
	LDUR X0,[X20,#20]
	LDUR X2,[SP,#24]
	BL QUICKSORT
	
QUICKSORTEND:
	LDUR FP,[SP,#0]
	LDUR LR,[SP,#8]
	ADDI SP,SP,#48
	BR LR

PRINTLIST:
    
    SUBIS XZR, X2, #9 // You can change the immediate value corresponding to the length of the array
    B.EQ PRINTLIST_LOOP_END
	MOV X1,X2
 	LSL X1,X1,#3
	ADD X4,X7,X1
    LDUR X1, [X4, #0]
    PUTINT X1
    PUTCHAR X3
    ADDI X2, X2,#1
    B PRINTLIST
PRINTLIST_LOOP_END:
    BR LR
