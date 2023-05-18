LDA X0, a
ADDI X1,XZR,#0
ADDI X2,XZR,#4
SUBI X3,X1,#1
ADDI X4,X1,#0
BL PARTITION
STOP


SWAP: 

LDUR X9,[X0,#0]
LDUR X10,[X1,#0]
STUR X10,[X0,#0]
STUR X9,[X1,#0]

BR LR

////////////////////////////
//                    	//
//   	partition        //
//                   	//
////////////////////////////

PARTITION: 
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
ADD X14,X0,X15 // address of a[high]
LDUR X20,[X14,#0] // X20 HAS THE PIVOT VALUE a[high]

SUBS XZR,X4,X20
B.NE SECONDIF
ADDI X16,X3,#1 // I + 1
LSL X16,X16,#3 // (I + 1)*8
ADD X17,X16,X0 // A0 + I + 1
ADDI X1,X20,#0
ADDI X0,X14,#0
B PARTITIONEND

SECONDIF:
LDUR X0,[SP,#16]
LDUR X1,[SP,#24]
LDUR X2,[SP,#32]
LDUR X4,[SP,#48]

LSL X18,X4,#3 // J*8
ADD X19,X18,X0 // A0 + J*8
LDUR X21,[X19,#0] // A[J]
SUBS XZR, X21,X20
B.GT CONTINUE

ADDI X3,X3,#1 // I + 1

LSL X22,X3,#3 // (I + 1)*8
ADD X23,X22,X0 //A0 + (I+1)
ADDI X0,X23,#0
ADDI X1,X19,#0
BL SWAP


CONTINUE:

LDUR X0,[SP,#16]
LDUR X1,[SP,#24]
LDUR X2,[SP,#32]
LDUR X4,[SP,#48]
ADDI X4,X10,#1
BL PARTITION



PARTITIONEND:
PUTINT X0    ////// PRINTING
LDUR FP,[SP,#0]
LDUR LR,[SP,#8]
ADDI SP,SP,#80
BR LR
BR LR


