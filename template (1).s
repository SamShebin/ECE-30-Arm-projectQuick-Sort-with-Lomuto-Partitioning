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
ADDI X2, XZR, #7
 //  'High' value stored in X2 (0 and 5 are hypothetical numbers, you can put your test values)
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
	
	LDUR X12,[X0,#0]
LDUR X13,[X1,#0]
STUR X13,[X0,#0]
STUR X12,[X1,#0]
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
	
	SUBI SP,SP,#24
STUR FP,[SP,#0]
STUR LR,[SP,#8]
STUR X0,[SP,#16]
STUR X1,[SP,#24]
ADDI FP,SP,#16

ADDI X9,X2,#0 // MOVING HIGH VALUE INTO X9
LSL X9,X9,#3  // MULTIPLY HIGH VALUE BY 8
ADD X10,X0,X9 // X10 HAS a[high] address
LDUR X11,[X10,#0] // X11 HAS THE PIVOT VALUE

CMP X4,X2 // CHECKING IF STATEMENT IF j == high 
B.NE secondif
ADDI X14,X3,#1 // X14 = i + 1
LSL X15,X14,#3 // (i + 1)*8
ADD X0,X0,X15
ADDI X1,X10,#0
BL SWAP
ADDI X0,X3,#1
B PARTITIONEND

secondif:
LDUR X0,[SP,#16]
LSL X19,X4,#3 // MULTIPLYING J * 8
ADD X20,X19,X0 // X20 ADDRESS OF a[j]
LDUR X21,[X20,#0]    // X21 HAS VALUE OF a[j]
SUBS XZR,X21,X11
B.GT CONTINUE
LDUR X0,[SP,#16]
ADDI X3,X3,#1 // i + 1
LSL X22,X3,#3 // (i + 1)*8
ADD X0,X0,X22 // X0 = a[i]
ADD X1,XZR,X20 // X1 = a[j]
BL SWAP

CONTINUE:
LDUR X0,[SP,#16]
LDUR X1,[SP,#24]
ADDI X4,X4,#1
BL PARTITION

PARTITIONEND:

LDUR FP,[SP,#0]
LDUR LR,[SP,#8]
ADDI SP,SP,#24
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
STUR X0,[SP,#16]
STUR X1,[SP,#24]
STUR X2,[SP,#32]
ADDI FP,SP,#40


CMP X1,X2
B.GE QUICKSORTEND
SUBI X3,X1,#1 // X3 = LOW -1 
ADDI X4,X1,#0 // X4 = LOW
BL PARTITION
STUR X0,[SP,#40] // SAVING PIVOT POSITION ONTO STACK


LDUR X0,[SP,#16]
LDUR X1,[SP,#24]
LDUR X2,[SP,#40]
SUBI X2,X2,#1
BL QUICKSORT


LDUR X0,[SP,#16]
LDUR X1,[SP,#40]
ADDI X1,X1,#1
LDUR X2,[SP,#32]
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
