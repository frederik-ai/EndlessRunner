## 
# READ USER INPUT
#
# -- This file implements functionality to read and identify user input.
# -- Run 'read_userinput' in order to start the process.
#
# ----- output ----
# s11: current user input [encoding: 0 = invalid/none, 1 = spacebar]
##

.text
read_userinput:
	sw s0, 0(sp)
	sw s1, -4(sp)
	sw t0, -8(sp)
	sw t1, -12(sp)
	sw ra, -16(sp)
	sw t2, -20(sp)

	li s0, RECEIVER_DATA_REGISTER # base address of I/O
	li s1, RECEIVER_CONTROL_REGISTER
	lw t1, 0(s1)
	add t2, zero, zero # control value
	beq t1, t2, no_or_invalid_input # if there is no new input jump directly to this part

   ## input identification ##
	lw t0, 0(s0) # load input value; RECEIVER_CONTROL_REGISTER is now set to 0
	li t3, 0x20	 # 0x20 is the ascii value of the 'space' character
	beq t0, t3, space_pressed
	j no_or_invalid_input # only reached if above condition is false

space_pressed:
	addi s11, zero, 1
	j read_continue

no_or_invalid_input:
	add s11, zero, zero
	j read_continue

read_continue:
	sw zero, 0(s0) # reset the inout register

	lw s0, 0(sp)
	lw s1, -4(sp)
	lw t0, -8(sp)
	lw t1, -12(sp)
	lw ra, -16(sp)
	lw t2 -20(sp)
	ret

## just ignore the current input and delete it from the register ##
flush_input_register_only:
	sw s0, 0(sp)
	sw s1, -4(sp)
	li s1, RECEIVER_CONTROL_REGISTER
	lw zero, 0(s1) # reset input flag by reading the value
	li s0, RECEIVER_DATA_REGISTER
	add s11, zero, zero # no input
	sw zero, 0(s0) # reset input register
	lw s0, 0(sp)
	lw s1, -4(sp)
	ret
