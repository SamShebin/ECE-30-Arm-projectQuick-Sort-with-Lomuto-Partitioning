LDA X0, a
ADDI X1,XZR,#0
ADDI X2,XZR,#4
SUBI X3,X1,#1
ADDI X4,X1,#0
BL PARTITION
PUTINT X0    ////// PRINTING
STOP


SWAP: 

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

