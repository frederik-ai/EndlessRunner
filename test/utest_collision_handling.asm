## 
# UNIT TEST FOR THE FILE collision_handling.asm
#
# -- this test specifies some test cases where a collision should either be detected by check_for_collision or where it
# -- should not be detected.
##

.data
s_test_name: .ascii "## COLLISION HANDLING UNIT TEST ##\n\0"
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

execute_tests:
	li a7, 4 # print to console
	la a0, s_test_name
	ecall
	jal test_case_1
	jal test_case_2
	jal test_case_3
	jal test_case_4
	jal test_case_5
	j end_tests

## TEST CASE 1
# no collision should not be detected [x-values differ completly]
test_case_1:
	li a0, 10	# player x1
	li a1, 50	# player y2
	li a2, 30	# player x2
	li a4, 400	# cactus x1
	li a6, 412	# cactus x2
	li a7, 100	# cactus y1
	sw ra, -32(sp)
	jal check_for_collision
	lw ra -32(sp)
	la s2, s_test1
	beq a0, zero, test_passed
	j test_failed

## TEST CASE 2
# no collision should not be detected [cactus is further on the left than the player]
test_case_2:
	li a0, 400
	li a1, 50
	li a2, 412
	li a4, 10
	li a6, 30
	li a7, 100
	sw ra, -32(sp)
	jal check_for_collision
	lw ra -32(sp)
	la s2, s_test2
	beq a0, zero, test_passed
	j test_failed

## TEST CASE 3
# no collision should not be detected [x1 values are identical, but player is above the cactus]
test_case_3:
	li a0, 100
	li a1, 50
	li a2, 50
	li a4, 100
	li a6, 150
	li a7, 230
	sw ra, -32(sp)
	jal check_for_collision
	lw ra -32(sp)
	la s2, s_test3
	beq a0, zero, test_passed
	j test_failed

## TEST CASE 4
# collision should be detected [x1 values are identical and player is not aobve the cactus]
test_case_4:
	li a0, 10
	li a1, 256
	li a2, 30
	li a4, 10
	li a6, 50
	li a7, 100
	sw ra, -32(sp)
	jal check_for_collision
	lw ra -32(sp)
	la s2, s_test4
	bne a0, zero, test_passed
	j test_failed

## TEST CASE 4
# collision should be detected [x2 values are identical and playyer is not above the cactus]
test_case_5:
	li a0, 10
	li a1, 256
	li a2, 30
	li a4, 0
	li a6, 30
	li a7, 30
	sw ra, -32(sp)
	jal check_for_collision
	lw ra -32(sp)
	la s2, s_test5
	bne a0, zero, test_passed
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

	li a7, 10
	ecall

.include "../src/collision_handling.asm"
