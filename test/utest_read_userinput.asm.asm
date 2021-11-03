## 
# UNIT TEST FOR THE FILE read_userinput.asm
#
# -- this test specifies some test cases where a user input should be either identified or not identified.
##

.data
.include "../lib/lib_userinput.asm"
s_test_name: .ascii "## USER INPUT UNIT TEST ##\n\0"
.include "../lib/lib_utest_strings.asm"	# predefined strings for console output

.text
sw a0, 0(sp)
sw a1, -4(sp)
sw a2, -8(sp)
sw a4, -12(sp)
sw a6, -16(sp)
sw a7, -20(sp)
sw s0, -24(sp)
sw ra, -28(sp)
# 		 -32(sp) is already reserved later in the code
sw t0, -36(sp)
sw t1, -40(sp)

li s0, RECEIVER_DATA_REGISTER # base address of I/O
li s1, RECEIVER_CONTROL_REGISTER

execute_tests:
	li a7, 4 # print to console
	la a0, s_test_name
	ecall
	jal test_case_1
	jal test_case_2
	jal test_case_3
	jal test_case_4
	j end_tests

## TEST CASE 1
# no new input should be detected; RECEIVER_CONTROL_REGISTER is set to 0 and RECEIVER_DATA_REGISTER is set to an unknown random value
test_case_1:
	li t0, 0
	sw t0, 0(s1)	# set RECEIVER_CONTROL_REGISTER to 0
	sw ra, -32(sp)
	jal read_userinput
	lw ra -32(sp)
	la s2, s_test1
	beq s11, zero, test_passed # s11 is the output register of read_userinput -- 0 means no new space bar input has been identified
	j test_failed

## TEST CASE 2
# new input should not be detected, RECEIVER_CONTROL_REGISTER is set to 0 and RECEIVER_DATA_REGISTER is set to 0x20 ('spacebar')
test_case_2:
	li t0, 0
	sw t0, 0(s1)	# set RECEIVER_CONTROL_REGISTER to 0
	li t1, 0x20		# ascii code for 'spacebar'
	sw t1, 0(s0)
	sw ra, -32(sp)
	jal read_userinput
	lw ra -32(sp)
	la s2, s_test2
	beq s11, zero, test_passed
	j test_failed

## TEST CASE 3
# new input should be detected, but it is invalid --> expected output of s11: 0
test_case_3:
	li t0, 1
	sw t0, 0(s1)	# new key press is simulated
	li t1, 0x40		# ascii code for '@'
	sw t1, 0(s0)
	sw ra, -32(sp)
	jal read_userinput
	lw ra -32(sp)
	la s2, s_test3
	beq s11, zero, test_passed
	j test_failed

## TEST CASE 4
# new input should be considered valid --> expected output of s11: 1
test_case_4:
	li t0, 1
	sw t0, 0(s1)	# new key press is simulated
	li t1, 0x20
	sw t1, 0(s0)
	sw ra, -32(sp)
	jal read_userinput
	lw ra -32(sp)
	la s2, s_test4
	bne s11, zero, test_passed	# here bne because output should not be 0
	j test_failed


test_passed:
	li a7, 4 # print to console
	add a0, zero, s2
	ecall
	li a7, 4
	la a0, s_passed
	ecall
	ret

test_failed:
	li a7, 4 # print to console
	add a0, zero, s2
	ecall
	li a7, 4
	la a0, s_failed
	ecall
	ret

end_tests:
	lw a0, 0(sp)
	lw a1, -4(sp)
	lw a2, -8(sp)
	lw a4, -12(sp)
	lw a6, -16(sp)
	lw a7, -20(sp)
	lw s0, -24(sp)
	lw ra, -28(sp)
	lw t0, -36(sp)
	lw t1, -40(sp)
	
	li a7, 10
	ecall


.include "../src/read_userinput.asm"
